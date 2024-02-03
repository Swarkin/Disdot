extends BetterBaseClass
class_name ReadyEvent

# TODO
func _init(dict: Dictionary) -> void:
	v = dict.get('v', 0) as int
	user = User.new(dict.get('user', {}) as Dictionary)
	resume_gateway_url = dict.get('resume_gateway_url', '') as String

var v: int
var user: User
var guilds: Array
var session_id: String
var resume_gateway_url: String
var shard: Array[int]
var application: Dictionary
