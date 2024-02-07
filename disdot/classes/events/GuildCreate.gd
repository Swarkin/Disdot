class_name GuildCreateEvent
extends BaseEvent
## [url]https://discord.com/developers/docs/topics/gateway-events#guild-create[/url]

# TODO
func _init(d: Dictionary) -> void:
	guild = Guild.new(d)
	joined_at = _safe_get(d, 'joined_at', '') as String
	large = _safe_get(d, 'large', false) as bool
	unavailable = _safe_get(d, 'unavailable', false) as bool
	member_count = _safe_get(d, 'member_count', 0) as int
	voice_states = _safe_get(d, 'voice_states', []) as Array
	for member_data: Dictionary in _safe_get(d, 'members', []) as Array[Dictionary]:
		members.append(GuildMember.new(member_data))
	channels = _safe_get(d, 'channels', []) as Array
	threads = _safe_get(d, 'threads', []) as Array
	presences = _safe_get(d, 'presences', []) as Array
	stage_instances = _safe_get(d, 'stage_instances', []) as Array
	guild_scheduled_events = _safe_get(d, 'guild_scheduled_events', []) as Array

var guild: Guild
var joined_at: String
var large: bool
var unavailable: bool
var member_count: int
var voice_states: Array
var members: Array[GuildMember]
var channels: Array#[Channel]
var threads: Array#[Channel]
var presences: Array#[PresenceUpdate]
var stage_instances: Array#[StageInstance]
var guild_scheduled_events: Array#[GuildScheduledEvent]
