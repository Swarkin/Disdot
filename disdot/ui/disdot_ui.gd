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
	disdot.guild_create.connect(_on_guild_create)


func _on_bot_ready(event: ReadyEvent) -> void:
	ui_user.username_label.text = event.user.username
	for guild: UnavailableGuild in event.guilds:
		ui_guilds.add_guild(guild)

func _on_guild_create(event: GuildCreateEvent) -> void:
	var g := event.guild
	if g.id in ui_guilds.guilds:
		ui_guilds.remove_guild(g.id)

	ui_guilds.add_guild(g)
	print('Rotated Guild ', g.id)

func _on_message_create(event: MessageCreateEvent) -> void:
	pass
