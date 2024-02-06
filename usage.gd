extends Node

const ENV_PATH := '.env'

@export var disdot: Disdot


func _ready() -> void:
	var cfg := ConfigFile.new()
	var err := cfg.load(ENV_PATH)
	if err:
		push_error('Failed to open .env file: ', error_string(err))
		return

	var token := cfg.get_value('Bot', 'Token', '') as String
	var app_id := cfg.get_value('Bot', 'AppID', '') as int

	const I := disdot.Intents
	disdot.start(
		token,
		app_id,
		I.GUILDS | I.GUILD_MESSAGES
	)


func _on_disdot_bot_ready(event: ReadyEvent) -> void:
	print(event.user.username, ' is ready!')
