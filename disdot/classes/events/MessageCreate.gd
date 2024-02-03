class_name MessageCreateEvent
extends BetterBaseClass

# TODO
func _init(dict: Dictionary) -> void:
	message = Message.new(dict)
	guild_id = dict.get('guild_id', 0) as int

var message: Message
var guild_id: int
var member: Dictionary
var mentions: Array
