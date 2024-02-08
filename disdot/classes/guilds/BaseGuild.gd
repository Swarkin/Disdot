class_name BaseGuild
extends BetterBaseClass
## Base Guild object

func _init(d: Dictionary) -> void:
	id = _safe_get(d, 'id', 0) as int

var id: int	## guild id
