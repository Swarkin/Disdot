class_name InstallParams
extends BetterBaseClass

func _init(d: Dictionary) -> void:
	scopes = _safe_get(d, 'scopes', []) as Array[String]
	permissions = _safe_get(d, 'permissions', '') as String

var scopes: Array[String]
var permissions: String
