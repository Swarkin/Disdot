extends HBoxContainer

@export var disdot: Disdot


func _enter_tree() -> void:
	if not disdot:
		push_warning('No Disdot instance assigned')
		queue_free()
