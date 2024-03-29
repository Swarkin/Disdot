extends Node

const ENV_PATH := '.env'

@export var disdot: Disdot


func _ready() -> void:
	var cfg := ConfigFile.new()
	var err := cfg.load(ENV_PATH)
	if err:
		push_error('Failed to open .env file: ', error_string(err))
		return

	Discord.token = cfg.get_value('Bot', 'Token', '') as String
	Discord.app_id = cfg.get_value('Bot', 'AppID', '') as int

	const I := disdot.Intents
	disdot.start(
		I.GUILDS | I.GUILD_MESSAGES | I.MESSAGE_CONTENT
	)


func _on_disdot_bot_ready(event: ReadyEvent) -> void:
	pass


func _on_disdot_guild_create(event: GuildCreateEvent) -> void:
	pass


func _on_disdot_message_create(event: MessageCreateEvent) -> void:
	pass
