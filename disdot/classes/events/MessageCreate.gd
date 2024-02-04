class_name MessageCreateEvent
extends BetterBaseClass

# TODO
func _init(d: Dictionary) -> void:
	message = Message.new(d)
	guild_id = _safe_get(d, 'guild_id', 0) as int

var message: Message
var guild_id: int
var member: Dictionary
var mentions: Array
