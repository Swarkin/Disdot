class_name Channel
extends BetterBaseClass

# TODO:
#  - Return Types

func _init(d: Dictionary) -> void:
	id = _safe_get(d, 'id', 0) as int
	type = _safe_get(d, 'type', 0) as int
	guild_id = _safe_get(d, 'guild_id', 0) as int
	position = _safe_get(d, 'position', 0) as int
	permission_overwrites = _safe_get(d, 'permission_overwrites', []) as Array#[Overwrite]
	name = _safe_get(d, 'name', '') as String
	topic = _safe_get(d, 'topic', '') as String
	nsfw = _safe_get(d, 'nsfw', false) as bool
	last_message_id = _safe_get(d, 'last_message_id', 0) as int
	bitrate = _safe_get(d, 'bitrate', 0) as int
	user_limit = _safe_get(d, 'user_limit', 0) as int
	rate_limit_per_user = _safe_get(d, 'rate_limit_per_user', 0) as int
	recipients.assign(_safe_get(d, 'recipients', []) as Array[User])
	icon = _safe_get(d, 'icon', '') as String
	owner_id = _safe_get(d, 'owner_id', 0) as int
	application_id = _safe_get(d, 'application_id', 0) as int
	managed = _safe_get(d, 'managed', false) as bool
	parent_id = _safe_get(d, 'parent_id', 0) as int
	last_pin_timestamp = _safe_get(d, 'last_pin_timestamp', 0) as int
	rtc_region = _safe_get(d, 'rtc_region', '') as String
	video_quality_mode = _safe_get(d, 'video_quality_mode', 0) as int
	message_count = _safe_get(d, 'message_count', 0) as int
	member_count = _safe_get(d, 'member_count', 0) as int
	thread_metadata = _safe_get(d, 'thread_metadata', {}) as Dictionary
	member = _safe_get(d, 'member', {}) as Dictionary
	default_auto_archive_duration = _safe_get(d, 'default_auto_archive_duration', 0) as int
	permissions = _safe_get(d, 'permissions', '') as String
	flags = _safe_get(d, 'flags', 0) as int
	total_message_sent = _safe_get(d, 'total_message_sent', 0) as int
	available_tags.assign(_safe_get(d, 'available_tags', []) as Array[Dictionary])
	applied_tags = _safe_get(d, 'applied_tags', []) as PackedInt64Array
	default_reaction_emoji = _safe_get(d, 'default_reaction_emoji', {}) as Dictionary
	default_thread_rate_limit_per_user = _safe_get(d, 'default_thread_rate_limit_per_user', 0) as int
	default_sort_order = _safe_get(d, 'default_sort_order', 0) as int
	default_forum_layout = _safe_get(d, 'default_forum_layout', 0) as int

var id: int
var type: int
var guild_id: int
var position: int
var permission_overwrites: Array
var name: String
var topic: String
var nsfw: bool
var last_message_id: int
var bitrate: int
var user_limit: int
var rate_limit_per_user: int
var recipients: Array[User]
var icon: String
var owner_id: int
var application_id: int
var managed: bool
var parent_id: int
var last_pin_timestamp: int
var rtc_region: String
var video_quality_mode: int
var message_count: int
var member_count: int
var thread_metadata: Dictionary
var member: Dictionary
var default_auto_archive_duration: int
var permissions: String
var flags: int
var total_message_sent: int
var available_tags: Array[Dictionary]
var applied_tags: PackedInt64Array
var default_reaction_emoji: Dictionary
var default_thread_rate_limit_per_user: int
var default_sort_order: int
var default_forum_layout: int

func get_message(message_id: int) -> AwaitableHTTPRequest.HTTPResult:
	return await Discord.get_message(id, message_id)

func create_message(content: String) -> AwaitableHTTPRequest.HTTPResult:
	return await Discord.create_message(id, content)

func delete_message(message_id: int) -> AwaitableHTTPRequest.HTTPResult:
	return await Discord.delete_message(id, message_id)
