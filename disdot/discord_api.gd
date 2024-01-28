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


# Classes

## Users in Discord are generally considered the base entity. Users can spawn across the entire platform, be members of guilds, participate in text and voice chat, and much more. Users are separated by a distinction of "bot" vs "normal." Although they are similar, bot users are automated users that are "owned" by another user. Unlike normal users, bot users do not have a limitation on the number of Guilds they can be a part of.[br][url]https://discord.com/developers/docs/resources/user#user-object[/url]
class User:
	extends DictConstructor
	var id: int							## the user's id
	var username: String		## the user's username, not unique across the platform
	var discriminator: int	## the user's Discord-tag
	var global_name: String	## the user's display name, if it is set. For bots, this is the application name
	var avatar: String			## the user's avatar hash
	var bot: bool						## whether the user belongs to an OAuth2 application
	var system: bool				## whether the user is an Official Discord System user (part of the urgent message system)
	var mfa_enabled: bool		## whether the user has two factor enabled on their account
	var banner: String			## the user's banner hash
	var accent_color: int		## the user's banner color encoded as an integer representation of hexadecimal color code
	var locale: String			## the user's chosen language option
	var verified: bool			## whether the email on this account has been verified
	var email: String				## the user's email
	var flags: int					## the flags on a user's account
	var premium_type: int		## the type of Nitro subscription on a user's account
	var public_flags: int		## the public flags on a user's account
	var avatar_decoration: String	## the user's avatar decoration hash

## Guilds in Discord represent an isolated collection of users and channels, and are often referred to as "servers" in the UI.[br][url]https://discord.com/developers/docs/resources/guild[/url]
class Guild:
	extends DictConstructor
	var id: int																## guild id
	var name: String													## guild name (2-100 characters, excluding trailing and leading whitespace)
	var icon: String													## icon hash
	var icon_hash: String											## icon hash, returned when in the template object
	var splash: String												## splash hash
	var discovery_splash: String							## discovery splash hash; only present for guilds with the "DISCOVERABLE" feature
	var owner: bool														## true if the user is the owner of the guild[br]this field is only sent when using the GET Current User Guilds endpoint and is relative to the requested user
	var owner_id: int													## id of owner
	var permissions: String										## total permissions for the user in the guild (excludes overwrites and implicit permissions)[br]this field is only sent when using the GET Current User Guilds endpoint and is relative to the requested user
	## voice region id for the guild[br]this field is deprecated and is replaced by channel.rtc_region
	## @deprecated
	var region: String
	var afk_channel_id: int										## id of afk channel
	var afk_timeout: int											## afk timeout in seconds
	var widget_enabled: bool									## true if the server widget is enabled
	var widget_channel_id: int								## the channel id that the widget will generate an invite to, or [code]null[/code] if set to no invite
	var verification_level: int								## verification level required for the guild
	var default_message_notifications: int		## default message notifications level
	var explicit_content_filter: int					## explicit content filter level
	## roles in the guild
	var roles: Array#[Role]
	## custom guild emojis
	var emojis: Array#[Emoji]
	var features: Array[String]								## enabled guild features
	var mfa_level: int												## required MFA level for the guild
	var application_id: int										## application id of the guild creator if it is bot-created
	var system_channel_id: int								## the id of the channel where guild notices such as welcome messages and boost events are posted
	var system_channel_flags: int							## system channel flags
	var rules_channel_id: int									## the id of the channel where Community guilds can display rules and/or guidelines
	var max_presences: int										## the maximum number of presences for the guild ([code]null[/code] is always returned, apart from the largest of guilds)
	var max_members: int											## the maximum number of members for the guild
	var vanity_url_code: String								## the vanity url code for the guild
	var description: String										## the description of a guild
	var banner: String												## banner hash
	var premium_tier: int											## premium tier (Server Boost level)
	var premium_subscription_count: int				## the number of boosts this guild currently has
	var preferred_locale: String							## the preferred locale of a Community guild; used in server discovery and notices from Discord, and sent in interactions; defaults to "en-US"
	var public_updates_channel_id: int				## the id of the channel where admins and moderators of Community guilds receive notices from Discord
	var max_video_channel_users: int					## the maximum amount of users in a video channel
	var max_stage_video_channel_users: int		## the maximum amount of users in a stage video channel
	var approximate_member_count: int					## approximate number of members in this guild, returned from the [code]GET /guilds/<id>[/code] and [code]/users/@me/guilds[/code] endpoints when [code]with_counts[/code] is [code]true[/code]
	var approximate_presence_count: int				## approximate number of non-offline members in this guild, returned from the [code]GET /guilds/<id>[/code] and [code]/users/@me/guilds[/code] endpoints when [code]with_counts[/code] is [code]true[/code]
	## the welcome screen of a Community guild, shown to new members, returned in an Invite's guild object
	var welcome_screen: Dictionary #WelcomeScreen
	var nsfw_level: int												## guild NSFW level
	## custom guild stickers
	var stickers: Array#[Sticker]
	var premium_progress_bar_enabled: bool		## whether the guild has the boost progress bar enabled
	var safety_alerts_channel_id: int					## the id of the channel where admins and moderators of Community guilds receive safety alerts from Discord


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
