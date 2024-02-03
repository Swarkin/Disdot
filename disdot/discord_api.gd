extends Node
class_name DiscordAPI

const BASE_URL := 'https://discord.com/api/v10'

# TODO:
# - Query string support for join_url
# - Return types
#  - Classes
#   - ...
# - Static functions
#  - Static HTTPRequest node


# Util

func _request(url: String, method := HTTPClient.Method.METHOD_GET, custom_headers := PackedStringArray(), request_body := '') -> AwaitableHTTPRequest.HTTPResult:
	var http := AwaitableHTTPRequest.new()
	http.accept_gzip = false

	# ew.
	get_tree().root.add_child.call_deferred(http)
	await get_tree().process_frame
	await get_tree().process_frame
	#

	var r := await http.async_request(url, method, custom_headers, request_body)
	http.queue_free()
	return r

static func join_url(parts: PackedStringArray) -> String:
	const S := '/'
	var result := ''

	for p: String in parts:
		var part := p.strip_edges()
		result += part

		if not part.ends_with(S):
			result += S

	return result.trim_suffix('/')

static func headers(token: String, json_content := true) -> PackedStringArray:
	var h := PackedStringArray([
		'Authorization: Bot '+token,
		'User-Agent: Disdot (https://github.com/Swarkin/Disdot)'
	])
	if json_content:
		h.append('Content-Type: application/json')

	return h


# Endpoints

func get_guild_application_commands(token: String, app_id: int, guild_id: int, _localizations := false) -> AwaitableHTTPRequest.HTTPResult:
	@warning_ignore('static_called_on_instance')
	var url := join_url([BASE_URL,'applications', str(app_id), 'guilds', str(guild_id), 'commands'])

	@warning_ignore('static_called_on_instance')
	return await _request(url, HTTPClient.METHOD_GET, headers(token))

@warning_ignore('shadowed_variable_base_class')
func create_guild_application_command(token: String, app_id: int, guild_id: int, name: String) -> AwaitableHTTPRequest.HTTPResult:
	@warning_ignore('static_called_on_instance')
	var url := join_url([BASE_URL, 'applications', str(app_id), 'guilds', str(guild_id), 'commands'])

	@warning_ignore('static_called_on_instance')
	return await _request(url, HTTPClient.METHOD_POST,
		headers(token),
		JSON.stringify({
			'name': name,
			# TODO: optional fields
		})
	)
