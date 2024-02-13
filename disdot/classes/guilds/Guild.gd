class_name Guild
extends BaseGuild
## Guilds in Discord represent an isolated collection of users and channels, and are often referred to as "servers" in the UI.[br][url]https://discord.com/developers/docs/resources/guild[/url]

# TODO
func _init(d: Dictionary) -> void:
	id = _safe_get(d, 'id', 0) as int
	name = _safe_get(d, 'name', '') as String
	icon = _safe_get(d, 'icon', '') as String
	icon_hash = _safe_get(d, 'icon_hash', '') as String
	splash = _safe_get(d, 'splash', '') as String
	discovery_splash = _safe_get(d, 'discovery_splash', '') as String
	owner = _safe_get(d, 'owner', false)
	owner_id = _safe_get(d, 'owner_id', 0) as int
	permissions = _safe_get(d, 'permissions', '') as String
	region = _safe_get(d, 'region','') as String
	afk_channel_id = _safe_get(d, 'afk_channel_id', 0) as int
	afk_timeout = _safe_get(d, 'afk_timeout', 0) as int
	widget_enabled = _safe_get(d, 'widget_enabled', false) as bool
	widget_channel_id = _safe_get(d, 'widget_channel_id', 0) as int
	verification_level = _safe_get(d, 'verification_level', 0) as int
	default_message_notifications = _safe_get(d, 'default_message_notifications', 0) as int
	explicit_content_filter = _safe_get(d, 'explicit_content_filter', 0) as int
	roles = _safe_get(d, 'roles', []) as Array#[Role]
	emojis = _safe_get(d, 'emojis', []) as Array#[Emoji]
	features = PackedStringArray(_safe_get(d, 'features', []) as Array[String])
	mfa_level = _safe_get(d, 'mfa_level', 0) as int
	application_id = _safe_get(d, 'application_id', 0) as int
	system_channel_id = _safe_get(d, 'system_channel_id', 0) as int
	rules_channel_id = _safe_get(d, 'rules_channel_id', 0) as int
	max_presences = _safe_get(d, 'max_presences', 0) as int
	max_members = _safe_get(d, 'max_members', 0) as int
	vanity_url_code = _safe_get(d, 'vanity_url_code', '') as String
	description = _safe_get(d, 'description', '') as String
	banner = _safe_get(d, 'banner', '') as String
	premium_tier = _safe_get(d, 'premium_tier', 0) as int
	premium_subscription_count = _safe_get(d, 'premium_subscription_count', 0) as int
	preferred_locale = _safe_get(d, 'preferred_locale', '') as String
	public_updates_channel_id = _safe_get(d, 'public_updates_channel_id', 0) as int
	max_video_channel_users = _safe_get(d, 'max_video_channel_users', 0) as int
	max_stage_video_channel_users = _safe_get(d, 'max_stage_video_channel_users', 0) as int
	approximate_member_count = _safe_get(d, 'approximate_member_count', 0) as int
	welcome_screen = _safe_get(d, 'welcome_screen', {}) as Dictionary
	nsfw_level = _safe_get(d, 'nsfw_level', 0) as int
	stickers = _safe_get(d, 'stickers', []) as Array
	premium_progress_bar_enabled = _safe_get(d, 'premium_progress_bar_enabled', false) as bool
	safety_alerts_channel_id = _safe_get(d, 'safety_alerts_channel_id', 0) as int

var id: int								## guild id
var name: String						## guild name (2-100 characters, excluding trailing and leading whitespace)
var icon: String						## icon hash
var icon_hash: String					## icon hash, returned when in the template object
var splash: String						## splash hash
var discovery_splash: String			## discovery splash hash; only present for guilds with the "DISCOVERABLE" feature
var owner: bool							## true if the user is the owner of the guild[br]this field is only sent when using the GET Current User Guilds endpoint and is relative to the requested user
var owner_id: int						## id of owner
var permissions: String					## total permissions for the user in the guild (excludes overwrites and implicit permissions)[br]this field is only sent when using the GET Current User Guilds endpoint and is relative to the requested user
## voice region id for the guild[br]this field is deprecated and is replaced by channel.rtc_region
## @deprecated
var region: String
var afk_channel_id: int					## id of afk channel
var afk_timeout: int					## afk timeout in seconds
var widget_enabled: bool				## true if the server widget is enabled
var widget_channel_id: int				## the channel id that the widget will generate an invite to, or [code]null[/code] if set to no invite
var verification_level: int				## verification level required for the guild
var default_message_notifications: int	## default message notifications level
var explicit_content_filter: int		## explicit content filter level
## roles in the guild
var roles: Array#[Role]
## custom guild emojis
var emojis: Array#[Emoji]
var features: PackedStringArray			## enabled guild features
var mfa_level: int						## required MFA level for the guild
var application_id: int					## application id of the guild creator if it is bot-created
var system_channel_id: int				## the id of the channel where guild notices such as welcome messages and boost events are posted
var system_channel_flags: int			## system channel flags
var rules_channel_id: int				## the id of the channel where Community guilds can display rules and/or guidelines
var max_presences: int					## the maximum number of presences for the guild ([code]null[/code] is always returned, apart from the largest of guilds)
var max_members: int					## the maximum number of members for the guild
var vanity_url_code: String				## the vanity url code for the guild
var description: String					## the description of a guild
var banner: String						## banner hash
var premium_tier: int					## premium tier (Server Boost level)
var premium_subscription_count: int		## the number of boosts this guild currently has
var preferred_locale: String			## the preferred locale of a Community guild; used in server discovery and notices from Discord, and sent in interactions; defaults to "en-US"
var public_updates_channel_id: int		## the id of the channel where admins and moderators of Community guilds receive notices from Discord
var max_video_channel_users: int		## the maximum amount of users in a video channel
var max_stage_video_channel_users: int	## the maximum amount of users in a stage video channel
var approximate_member_count: int		## approximate number of members in this guild, returned from the [code]GET /guilds/<id>[/code] and [code]/users/@me/guilds[/code] endpoints when [code]with_counts[/code] is [code]true[/code]
var approximate_presence_count: int		## approximate number of non-offline members in this guild, returned from the [code]GET /guilds/<id>[/code] and [code]/users/@me/guilds[/code] endpoints when [code]with_counts[/code] is [code]true[/code]
## the welcome screen of a Community guild, shown to new members, returned in an Invite's guild object
var welcome_screen: Dictionary #WelcomeScreen
var nsfw_level: int						## guild NSFW level
## custom guild stickers
var stickers: Array#[Sticker]
var premium_progress_bar_enabled: bool	## whether the guild has the boost progress bar enabled
var safety_alerts_channel_id: int		## the id of the channel where admins and moderators of Community guilds receive safety alerts from Discord
