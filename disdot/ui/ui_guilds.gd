class_name DisdotUIGuilds
extends Control

const GUILD_SCN := preload('res://disdot/ui/ui_guild.tscn')
var _guilds: PackedInt64Array

@export var _container: Container


func add_guild(id: int) -> void:
	print('UI: Adding Guild ', id)
	_guilds.append(id)
	_update_ui()


func _update_ui() -> void:
	for c: Control in _container.get_children():
		c.call_deferred(&'free')

	for id: int in _guilds:
		var scn := GUILD_SCN.instantiate() as Control
		scn.tooltip_text = str(id)
		_container.add_child(scn)
