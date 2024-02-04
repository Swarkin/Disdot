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
	assert(not token.is_empty(), 'Invalid Bot Token')
	assert(app_id, 'Invalid App ID')

	disdot.start(token, app_id)


func _on_disdot_bot_ready(event: ReadyEvent) -> void:
	pass

func _on_disdot_message_create(event: MessageCreateEvent) -> void:
	pass
