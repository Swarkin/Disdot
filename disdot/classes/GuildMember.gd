class_name GuildMember
extends BetterBaseClass

# TODO
func _init(d: Dictionary) -> void:
	user = User.new(_safe_get(d, 'user', {}) as Dictionary)
	nick = _safe_get(d, 'nick', '') as String
	avatar = _safe_get(d, 'avatar', '') as String
	roles = _safe_get(d, 'roles', []) as Array
	joined_at = _safe_get(d, 'joined_at', '') as String
	premium_since = _safe_get(d, 'premium_since', '') as String
	deaf = _safe_get(d, 'deaf', false) as bool
	mute = _safe_get(d, 'mute', false) as bool
	flags = _safe_get(d, 'flags', 0) as int
	pending = _safe_get(d, 'pending', false) as bool
	permissions = _safe_get(d, 'permissions', '') as String
	communication_disabled_until = _safe_get(d, 'communication_disabled_until', '') as String

var user: User
var nick: String
var avatar: String
var roles: Array
var joined_at: String
var premium_since: String
var deaf: bool
var mute: bool
var flags: int
var pending: bool
var permissions: String
var communication_disabled_until: String
