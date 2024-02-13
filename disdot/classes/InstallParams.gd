class_name InstallParams
extends BetterBaseClass

func _init(d: Dictionary) -> void:
	scopes = PackedStringArray(_safe_get(d, 'scopes', []) as Array[String])
	permissions = _safe_get(d, 'permissions', '') as String

var scopes: PackedStringArray
var permissions: String
