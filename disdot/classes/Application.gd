class_name Application
extends BetterBaseClass
## Application object

func _init(d: Dictionary) -> void:
	id = _safe_get(d, 'id', 0) as int
	name = _safe_get(d, 'name', '') as String
	icon = _safe_get(d, 'icon', '') as String
	description = _safe_get(d, 'description', '') as String
	rpc_origins = PackedStringArray(_safe_get(d, 'rpc_origins', []) as Array[String])
	bot_public = _safe_get(d, 'bot_public', false) as bool
	bot_require_code_grant = _safe_get(d, 'bot_require_code_grant', false) as bool
	bot = User.new(_safe_get(d, 'bot', {}) as Dictionary)
	terms_of_service_url = _safe_get(d, 'terms_of_service_url', '') as String
	privacy_policy_url = _safe_get(d, 'privacy_policy_url', '') as String
	owner = User.new(_safe_get(d, 'owner', {}) as Dictionary)
	summary = _safe_get(d, 'summary', '') as String
	verify_key = _safe_get(d, 'verify_key', '') as String
	team = Team.new(_safe_get(d, 'team', {}) as Dictionary)
	guild_id = _safe_get(d, 'guild_id', 0) as int
	guild = Guild.new(_safe_get(d, 'guild', {}) as Dictionary)
	primary_sku_id = _safe_get(d, 'primary_sku_id', 0) as int
	slug = _safe_get(d, 'slug', '') as String
	cover_image = _safe_get(d, 'cover_image', '') as String
	flags = _safe_get(d, 'flags', 0) as int
	approximate_guild_count = _safe_get(d, 'approximate_guild_count', 0) as int
	redirect_uris = PackedStringArray(_safe_get(d, 'redirect_uris', []) as Array[String])
	interactions_endpoint_url = _safe_get(d, 'interactions_endpoint_url', '') as String
	role_connections_verification_url = _safe_get(d, 'role_connections_verification_url', '') as String
	tags = PackedStringArray(_safe_get(d, 'tags', []) as Array[String])
	install_params = InstallParams.new(_safe_get(d, 'install_params', {}) as Dictionary)
	custom_install_url = _safe_get(d, 'custom_install_url', '') as String

var id: int
var name: String
var icon: String
var description: String
var rpc_origins: PackedStringArray
var bot_public: bool
var bot_require_code_grant: bool
var bot: User
var terms_of_service_url: String
var privacy_policy_url: String
var owner: User
## @deprecated
var summary: String
var verify_key: String
var team: Team
var guild_id: int
var guild: Guild
var primary_sku_id: int
var slug: String
var cover_image: String
var flags: int
var approximate_guild_count: int
var redirect_uris: PackedStringArray
var interactions_endpoint_url: String
var role_connections_verification_url: String
var tags: PackedStringArray
var install_params: InstallParams
var custom_install_url: String
