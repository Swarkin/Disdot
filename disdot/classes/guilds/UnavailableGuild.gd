class_name UnavailableGuild
extends BaseGuild

func _init(d: Dictionary) -> void:
	id = _safe_get(d, 'id', 0) as int

var id: int
