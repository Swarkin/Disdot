class_name DisdotUIRoot
extends Control

@export var disdot: Disdot
@export var ui_user: DisdotUIUser
@export var ui_guilds: DisdotUIGuilds
@export var ui_users: Control


func _enter_tree() -> void:
	if not disdot:
		push_error('No Disdot instance assigned')
		return

	disdot.bot_ready.connect(_on_bot_ready)
	disdot.message_create.connect(_on_message_create)


func _on_bot_ready(event: ReadyEvent) -> void:
	print('UI: Populating from ReadyEvent')

	ui_user.username_label.text = event.user.username

	for guild: Guild in event.guilds:
		ui_guilds.add_guild(guild.id)

func _on_message_create(event: MessageCreateEvent) -> void:
	pass
