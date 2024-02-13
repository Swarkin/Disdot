class_name Team
extends BetterBaseClass
## Teams are groups of developers (or other Discord users) who want to collaborate and share access to an app's configuration, management, and payout settings.

func _init(d: Dictionary) -> void:
	icon = _safe_get(d, 'icon', '') as String
	id = _safe_get(d, 'id', 0) as int
	for member_data: Dictionary in _safe_get(d, 'members', []) as Array[Dictionary]:
		members.append(TeamMember.new(member_data))
	name = _safe_get(d, 'name', '') as String
	owner_user_id = _safe_get(d, 'owner_user_id', 0) as int

var icon: String
var id: int
var members: Array[TeamMember]
var name: String
var owner_user_id: int
