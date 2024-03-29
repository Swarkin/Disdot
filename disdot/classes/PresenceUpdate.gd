class_name PresenceUpdateEvent
extends BaseEvent

func _init(d: Dictionary) -> void:
	user = User.new(_safe_get(d, 'user', {}) as Dictionary)
	guild_id = _safe_get(d, 'guild_id', 0) as int
	status = _safe_get(d, 'status', '') as String
	activities = _safe_get(d, 'activities', []) as Array[Dictionary]
	client_status = ClientStatus.new(_safe_get(d, 'client_status', {}) as Dictionary)

var user: User
var guild_id: int
var status: String
var activities: Array[Dictionary]
var client_status: ClientStatus
