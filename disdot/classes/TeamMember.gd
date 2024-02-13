class_name TeamMember
extends BetterBaseClass

func _init(d: Dictionary) -> void:
	membership_state = _safe_get(d, 'membership_state', 0) as int
	team_id = _safe_get(d, 'team_id', 0) as int
	user = User.new(_safe_get(d, 'user', {}) as Dictionary)
	role = _safe_get(d, 'role', '') as String

var membership_state: int
var team_id: int
var user: User
var role: String
