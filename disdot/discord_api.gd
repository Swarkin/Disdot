class_name DiscordAPI
extends Node

const BASE_URL := 'https://discord.com/api/v10'
var token: String
var app_id: int

# TODO:
# - Query string support for join_url
# - Return types
#  - Classes
#   - ...
# - Optional fields ("Optional" type using structs?)
# - (Advanced) Static and async HTTPRequest Node

func init(_token := '', _app_id := 0) -> void:
	token = _token
	app_id = _app_id


func _request(url: String, method := HTTPClient.Method.METHOD_GET, custom_headers := PackedStringArray(), request_body := '') -> AwaitableHTTPRequest.HTTPResult:
	var http := AwaitableHTTPRequest.new()
	http.accept_gzip = false
	http.timeout = 10.0

	get_tree().root.add_child.call_deferred(http)
	await get_tree().process_frame
	await get_tree().process_frame

	var r := await http.async_request(url, method, custom_headers if not custom_headers.is_empty() else headers(), request_body)
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
		'Authorization: Bot '+token,
		'User-Agent: Disdot (https://github.com/Swarkin/Disdot)'
	])
	if json_content:
		h.append('Content-Type: application/json')

	return h


func get_gateway_bot() -> AwaitableHTTPRequest.HTTPResult:
	var url := join_url([BASE_URL, 'gateway', 'bot'])
	return await _request(url, HTTPClient.METHOD_GET, headers())


func get_message(channel_id: int, message_id: int) -> AwaitableHTTPRequest.HTTPResult:
	var url := join_url([BASE_URL, 'channels', str(channel_id), 'messages', str(message_id)])

	return await _request(url)

func create_message(channel_id: int, content: String) -> AwaitableHTTPRequest.HTTPResult:
	var url := join_url([BASE_URL, 'channels', str(channel_id), 'messages'])

	return await _request(url, HTTPClient.METHOD_POST, headers(),
		JSON.stringify({
				'content': content,
		})
	)

func delete_message(channel_id: int, message_id: int) -> AwaitableHTTPRequest.HTTPResult:
	var url := join_url([BASE_URL, 'channels', str(channel_id), 'messages', str(message_id)])

	return await _request(url, HTTPClient.METHOD_DELETE)


func get_guild_application_commands(guild_id: int, _localizations := false) -> AwaitableHTTPRequest.HTTPResult:
	var url := join_url([BASE_URL, 'applications', str(app_id), 'guilds', str(guild_id), 'commands'])
	return await _request(url, HTTPClient.METHOD_GET, headers())

func create_guild_application_command(guild_id: int, cmd_name: String) -> AwaitableHTTPRequest.HTTPResult:
	var url := join_url([BASE_URL, 'applications', str(app_id), 'guilds', str(guild_id), 'commands'])
	return await _request(url, HTTPClient.METHOD_POST, headers(),
		JSON.stringify({
			'name': cmd_name,
		})
	)
