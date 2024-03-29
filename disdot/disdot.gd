class_name Disdot
extends Node
## [url]https://discord.com/developers/docs/topics/gateway#connections[/url]

signal bot_ready(event: ReadyEvent)
signal message_create(event: MessageCreateEvent)
signal guild_create(event: GuildCreateEvent)

enum Op {
	INVALID = -1,
	DISPATCH = 0,
	HEARTBEAT = 1,
	IDENTIFY = 2,
	PRESENCE_UPDATE = 3,
	VOICE_STATE_UPDATE = 4,
	RESUME = 6,
	RECONNECT = 7,
	REQUEST_GUILD_MEMBERS = 8,
	INVALID_SESSION = 9,
	HELLO = 10,
	HEARTBEAT_ACK = 11 }
enum Intents { ## Gateway Intents[br][url=https://discord.com/developers/docs/topics/gateway#gateway-intents]View Documentation[/url]
	GUILDS = 1 << 0,
	GUILD_MEMBERS = 1 << 1,
	GUILD_MODERATION = 1 << 2,
	GUILD_EMOJIS_AND_STICKERS = 1 << 3,
	GUILD_INTEGRATIONS = 1 << 4,
	GUILD_WEBHOOKS = 1 << 5,
	GUILD_INVITES = 1 << 6,
	GUILD_VOICE_STATES = 1 << 7,
	GUILD_PRESENCES = 1 << 8,
	GUILD_MESSAGES = 1 << 9,
	GUILD_MESSAGE_REACTIONS = 1 << 10,
	GUILD_MESSAGE_TYPING = 1 << 11,
	DIRECT_MESSAGES = 1 << 12,
	DIRECT_MESSAGE_REACTIONS = 1 << 13,
	DIRECT_MESSAGE_TYPING = 1 << 14,
	MESSAGE_CONTENT = 1 << 15,
	GUILD_SCHEDULED_EVENTS = 1 << 16,
	AUTO_MODERATION_CONFIGURATION = 1 << 20,
	AUTO_MODERATION_EXECUTION = 1 << 21 }
class Event:
	const READY := 'READY'
	const MESSAGE_CREATE := 'MESSAGE_CREATE'
	const GUILD_CREATE := 'GUILD_CREATE'

const BASE_URL := 'https://discord.com/api/v10'
@export var verbose := true

var _http: AwaitableHTTPRequest
var _socket: BetterWebsocket
var _heartbeat_timer: Timer

var _socket_url: String
var _last_seq_num: int

var _intents: int


func _init() -> void:
	_http = AwaitableHTTPRequest.new()
	_http.accept_gzip = false
	_http.timeout = 10.0

	_socket = BetterWebsocket.new()
	if verbose: _socket.verbose = true
	_socket.packet_received.connect(_on_packet_received)
	_socket.state_changed.connect(_on_state_changed)

	_heartbeat_timer = Timer.new()
	_heartbeat_timer.timeout.connect(_heartbeat)

	for n: Node in [_http, _socket, _heartbeat_timer]:
		add_child(n)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&'ui_cancel'):
		stop()


func start(intents: int) -> void:
	if verbose: print('Starting')

	assert(not Discord.token.is_empty(), 'Invalid Bot Token')
	assert(Discord.app_id, 'Invalid App ID')
	assert(intents >= 0, 'Invalid Intents')

	_intents = intents

	var r := await Discord.get_gateway_bot()
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
	if verbose: print_rich('[color=webgray]>>> ', packet_str, '[/color]')

	var json := JSON.parse_string(packet_str) as Dictionary
	strip_packet_recursive(json, '_trace')

	var op := json.get('op', -1) as Op
	assert(not op == -1)

	match op:
		Op.DISPATCH:
			_update_seq_num(json.get('s'))

			var event_data := json.get('d') as Dictionary
			var event_name := json.get('t') as String

			if verbose:
				print('┌───── Received Event ─────┐')
				print('│ Name: ', event_name)
				print('│ ', event_data)

			match event_name:
				Event.READY:
					var event := ReadyEvent.new(event_data)
					bot_ready.emit(event)

				Event.MESSAGE_CREATE:
					var event := MessageCreateEvent.new(event_data)
					message_create.emit(event)

				Event.GUILD_CREATE:
					var event := GuildCreateEvent.new(event_data)
					guild_create.emit(event)

				_:
					if verbose: print('└─────── Unhandled ────────┘')
					return

			if verbose: print('└──────────────────────────┘')

		Op.HELLO:
			if verbose: print('Hello Opcode received')
			var d := json.get('d') as Dictionary

			var interval_s := (d.get('heartbeat_interval') as float) * 0.001
			assert(interval_s > 10.0, 'Heartbeat interval likely too low')

			_heartbeat()
			_identify()

			if verbose: print('Starting Heartbeat Timer with interval ', interval_s, 's')
			_heartbeat_timer.start(interval_s)

		Op.HEARTBEAT_ACK:
			if verbose:print_rich('[color=webgray]>>> Heartbeat ACK[/color]')

		_:
			if verbose: print('Unhandled Opcode: ', op)

func _on_state_changed(state: WebSocketPeer.State) -> void:
	print('Websocket state changed: ', state)

func _heartbeat() -> void:
	if verbose: print('Heartbeat')

	@warning_ignore('incompatible_ternary')
	_socket.send_packet(JSON.stringify({
		'op': Op.HEARTBEAT, 'd': _last_seq_num if _last_seq_num else null})
	)

func _identify() -> void:
	if verbose: print('Identify with intents ', _intents)

	_socket.send_packet(JSON.stringify({
		'op': Op.IDENTIFY,
		'd': {
			'token': Discord.token,
			'intents': _intents,
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
