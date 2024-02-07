class_name ReadyEvent
extends BaseEvent
## The ready event is dispatched when a client has completed the initial handshake with the gateway (for new sessions). The ready event can be the largest and most complex event the gateway will send, as it contains all the state required for a client to begin interacting with the rest of the platform.[br][url]https://discord.com/developers/docs/topics/gateway-events#ready[/url]

# TODO
func _init(d: Dictionary) -> void:
	v = _safe_get(d, 'v', 0) as int
	user = User.new(_safe_get(d, 'user', {}) as Dictionary)
	for guild_data: Dictionary in _safe_get(d, 'guilds', []) as Array[Dictionary]:
		guilds.append(UnavailableGuild.new(guild_data))
	session_id = _safe_get(d, 'session_id', '') as String
	resume_gateway_url = _safe_get(d, 'resume_gateway_url', '') as String
	#shard
	#application

var v: int													## API version
var user: User											## Information about the user including email
var guilds: Array[UnavailableGuild]	## Guilds the user is in
var session_id: String							## Used for resuming connections
var resume_gateway_url: String			## Gateway URL for resuming connections
var shard: Array[int]								## Shard information associated with this session, if sent when identifying
var application: Dictionary					## Contains id and flags
