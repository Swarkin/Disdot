class_name DisdotUIGuilds
extends Control

const GUILD_SCN := preload('res://disdot/ui/ui_guild.tscn')
@export var _container: Container

var guilds: Dictionary#[int, BaseGuild]
var _rebuild_queued: bool


func add_guild(g: BaseGuild) -> void:
	guilds[g.id] = g
	_queue_rebuild()

func remove_guild(id: int) -> void:
	guilds.erase(id)
	_queue_rebuild()


func _queue_rebuild() -> void:
	if _rebuild_queued:
		return

	_rebuild_queued = true
	_rebuild_ui.call_deferred()

func _rebuild_ui() -> void:
	_rebuild_queued = false
	_clear()

	for g: BaseGuild in guilds.values():
		var scn := GUILD_SCN.instantiate() as Control
		scn.tooltip_text = str(g.id)

		if g is Guild:
			pass
		elif g is UnavailableGuild:
			pass

		_container.add_child(scn)

func _clear() -> void:
	for c: Control in _container.get_children():
		print(' ! freed ', c.tooltip_text)
		c.free()
