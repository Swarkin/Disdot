class_name MessageCreateEvent
extends BaseEvent

# TODO
func _init(d: Dictionary) -> void:
	message = Message.new(d)
	guild_id = _safe_get(d, 'guild_id', 0) as int
	member = GuildMember.new(_safe_get(d, 'member', {}) as Dictionary)
	mentions = _safe_get(d, 'mentions', []) as Array

var message: Message
var guild_id: int
var member: GuildMember
var mentions: Array#[User]
