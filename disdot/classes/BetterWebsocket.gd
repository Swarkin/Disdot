@icon('res://classes/BetterWebsocket.svg')
extends Node
class_name BetterWebsocket
## Better Websocket Node v1.0.1 by swark1n

signal connected
signal disconnected
signal connection_failed(code: int, reason: String)
signal state_changed(state: WebSocketPeer.State)
signal packet_received(content: PackedByteArray)

@export var verbose := false

var s := WebSocketPeer.new()				## The underlying Websocket.
var _processing := false
var _prev_state := s.STATE_CLOSED		## To get the Websocket state, use [code]better_websocket.s.get_ready_state()[/code] instead.


func begin_connection(url: String) -> Error:
	var err := s.connect_to_url(url)

	if not err:
		_processing = true
		return err  # OK

	var close_reason := s.get_close_reason()
	var close_code := s.get_close_code()
	connection_failed.emit(close_code, close_reason)
	if verbose:
		push_error('BetterWebsocket | Connection failed: ', error_string(err), ', code: ', close_code, ', reason: ', close_reason)

	return err


func close_connection(code := 1000) -> void:
	s.close(code)


func send_packet(content: String) -> Error:
	return s.put_packet(content.to_utf8_buffer())


func _process(_dt: float) -> void:
	if not _processing:
		return

	s.poll()

	var state := s.get_ready_state()
	if not state == _prev_state:
		state_changed.emit(state)
		_prev_state = state

		if state == s.STATE_OPEN:
			connected.emit()

	match state:
		s.STATE_OPEN:
			while s.get_available_packet_count():
				packet_received.emit(s.get_packet())

		s.STATE_CLOSED:
			disconnected.emit()
			_processing = false
