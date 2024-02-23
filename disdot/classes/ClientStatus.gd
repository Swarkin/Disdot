class_name ClientStatus
extends BetterBaseClass

func _init(d: Dictionary) -> void:
	desktop = _safe_get(d, 'desktop', '') as String
	mobile = _safe_get(d, 'mobile', '') as String
	web = _safe_get(d, 'web', '') as String

var desktop: String
var mobile: String
var web: String
