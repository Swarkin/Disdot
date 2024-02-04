class_name Disdot
extends Node
## [url]https://discord.com/developers/docs/topics/gateway#connections[/url]

# TODO:
# - Move Gateway URL request to DiscordAPI

signal bot_ready(event: ReadyEvent)
signal message_create(event: MessageCreateEvent)

enum Op {
	Invalid = -1,
	Dispatch = 0,
	Heartbeat = 1,
	Identify = 2,
	PresenceUpdate = 3,
	VoiceStateUpdate = 4,

	Resume = 6,
	Reconnect = 7,
	RequestGuildMembers = 8,
	InvalidSession = 9,
	Hello = 10,
	HeartbeatACK = 11}
class Event:
	const Ready := 'READY'
	const MessageCreate := 'MESSAGE_CREATE'

const BASE_URL := 'https://discord.com/api/v10'
@export var verbose := true

var _http: AwaitableHTTPRequest
var _socket: BetterWebsocket
var _api: DiscordAPI
var _heartbeat_timer: Timer
var _token: String
var _app_id: int
var _socket_url: String
var _last_seq_num: int

func _init() -> void:
	_http = AwaitableHTTPRequest.new()
	_http.accept_gzip = false
	_http.timeout = 10.0

	_socket = BetterWebsocket.new()
	_socket.verbose = true
	_socket.packet_received.connect(_on_packet_received)
	_socket.state_changed.connect(_on_state_changed)

	_heartbeat_timer = Timer.new()
	_heartbeat_timer.timeout.connect(_heartbeat)

	for n: Node in [_http, _socket, _heartbeat_timer]:
		add_child(n)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_cancel'):
		stop()


func start(token: String, app_id: int) -> void:
	if verbose: print('Starting')

	_token = token
	_app_id = app_id

	_api = DiscordAPI.new(_token, _app_id)
	add_child(_api)

	var r := await _http.async_request(BASE_URL+'/gateway/bot', HTTPClient.METHOD_GET, _api.headers())
	assert(r.success and r.status_code == 200, 'Gateway URL request failed')

	_socket_url = (r.json as Dictionary).get('url') as String + '/?v=10&encoding=json'
	if verbose: print('Websocket URL: ', _socket_url)

	_socket.begin_connection(_socket_url)

func stop() -> void:
	if verbose: print('Stopping')

	_heartbeat_timer.stop()
	_socket.close_connection()


func _on_packet_received(p: PackedByteArray) -> void:
	var packet_str := p.get_string_from_utf8()
	print_rich('[color=webgray]Packet received: ', packet_str, '[/color]')

	var json := JSON.parse_string(packet_str) as Dictionary
	strip_packet_recursive(json, '_trace')

	var op := json.get('op', -1) as Op
	assert(not op == -1)

	match op:
		Op.Dispatch:
			_update_seq_num(json.get('s'))

			var event_data := json.get('d') as Dictionary
			var event_name := json.get('t') as String

			if verbose:
				print('┌───── Received Event ─────┐')
				print('│ Name: ', event_name)
				print('│ ', event_data)

			match event_name:
				Event.Ready:
					var event := ReadyEvent.new(event_data)
					bot_ready.emit(event)

				Event.MessageCreate:
					var event := MessageCreateEvent.new(event_data)
					message_create.emit(event)

				_:
					if verbose: print('└─────── Unhandled ────────┘')
					return

			if verbose: print('└──────────────────────────┘')

		Op.Hello:
			if verbose: print('Hello Opcode received')
			var d := json.get('d') as Dictionary

			var interval_s := (d.get('heartbeat_interval') as int) * 0.001
			assert(interval_s > 10.0, 'Heartbeat interval likely too low')

			_heartbeat()
			_identify()

			if verbose: print('Starting Heartbeat Timer with interval ', interval_s, 's')
			_heartbeat_timer.start(interval_s)

		Op.HeartbeatACK:
			if verbose: print('Heartbeat ACK received')

		_:
			print('Unhandled Opcode: ', op)

func _on_state_changed(state: WebSocketPeer.State) -> void:
	print('Websocket state changed: ', state)

func _heartbeat() -> void:
	if verbose: print('Heartbeat')

	@warning_ignore('incompatible_ternary')
	_socket.send_packet(JSON.stringify({
		'op': 1, 'd': _last_seq_num if _last_seq_num else null})
	)

func _identify() -> void:
	if verbose: print('Identify')

	_socket.send_packet(JSON.stringify({
		'op': Op.Identify,
		'd': {
			'token': _token,
			'intents': 1 << 9,
			'properties': {
				'os': 'linux',
				'browser': 'disdot',
				'device': 'disdot'
			}
		}
	}))

func _update_seq_num(num: Variant) -> void:
	if num is int:
		if not _last_seq_num + 1 == num:
			push_warning('Missed a sequence number!')

		_last_seq_num = num
		if verbose:
			print_rich('[color=dimgray]Sequence number: ', num, '[/color]')

func strip_packet_recursive(d: Dictionary, rm_key: String) -> void:
	d.erase(rm_key)

	for key: String in d.keys():
		var val := d[key] as Variant

		if val is Dictionary:
			strip_packet_recursive(val as Dictionary, rm_key)
		elif val is Array:
			walk_array(val as Array, rm_key)

func walk_array(arr: Array, rm_key: String) -> void:
	for val: Variant in arr:
		if val is Dictionary:
			strip_packet_recursive(val as Dictionary, rm_key)
		elif val is Array:
			walk_array(val as Array, rm_key)
