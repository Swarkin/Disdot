class_name DiscordAPI
extends Node

const BASE_URL := 'https://discord.com/api/v10'
var _token: String
var _app_id: int

# TODO:
# - Query string support for join_url
# - Return types
#  - Classes
#   - ...
# - Static and async HTTPRequest Node
# - Optional fields

func _init(token := '', app_id := 0) -> void:
	_token = token
	_app_id = app_id

func _enter_tree() -> void:
	assert(_token and _app_id)


func _request(url: String, method := HTTPClient.Method.METHOD_GET, custom_headers := PackedStringArray(), request_body := '') -> AwaitableHTTPRequest.HTTPResult:
	var http := AwaitableHTTPRequest.new()
	http.accept_gzip = false
	http.timeout = 10.0

	# ew.
	get_tree().root.add_child.call_deferred(http)
	await get_tree().process_frame
	await get_tree().process_frame
	#

	var r := await http.async_request(url, method, custom_headers, request_body)
	http.queue_free()
	return r

func join_url(parts: PackedStringArray) -> String:
	const S := '/'
	var result := ''

	for p: String in parts:
		var part := p.strip_edges()
		result += part

		if not part.ends_with(S):
			result += S

	return result.trim_suffix('/')

func headers(json_content := true) -> PackedStringArray:
	var h := PackedStringArray([
		'Authorization: Bot '+_token,
		'User-Agent: Disdot (https://github.com/Swarkin/Disdot)'
	])
	if json_content:
		h.append('Content-Type: application/json')

	return h


func create_message(channel_id: int, content: String) -> AwaitableHTTPRequest.HTTPResult:
	var url := join_url([BASE_URL, 'channels', str(channel_id), 'messages'])

	return await _request(url, HTTPClient.METHOD_POST, headers(),
		JSON.stringify({
				'content': content,
		})
	)


func get_guild_application_commands(guild_id: int, _localizations := false) -> AwaitableHTTPRequest.HTTPResult:
	var url := join_url([BASE_URL, 'applications', str(_app_id), 'guilds', str(guild_id), 'commands'])

	return await _request(url, HTTPClient.METHOD_GET, headers())

@warning_ignore('shadowed_variable_base_class')
func create_guild_application_command(guild_id: int, name: String) -> AwaitableHTTPRequest.HTTPResult:
	var url := join_url([BASE_URL, 'applications', str(_app_id), 'guilds', str(guild_id), 'commands'])

	return await _request(url, HTTPClient.METHOD_POST, headers(),
		JSON.stringify({
			'name': name,
		})
	)
