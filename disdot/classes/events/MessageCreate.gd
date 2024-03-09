class_name MessageCreateEvent
extends BaseEvent
## Sent when a message is created.[br][url]https://discord.com/developers/docs/topics/gateway-events#message-create[/url]

func _init(d: Dictionary) -> void:
	message = Message.new(d)
	guild_id = _safe_get(d, 'guild_id', 0) as int
	member = GuildMember.new(_safe_get(d, 'member', {}) as Dictionary)
	for mention_data: Dictionary in _safe_get(d, 'mentions', []) as Array[Dictionary]:
		mentions.append(User.new(mention_data))

var message: Message
var guild_id: int
var member: GuildMember
var mentions: Array[User]
