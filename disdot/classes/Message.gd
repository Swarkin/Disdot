class_name Message
extends BetterBaseClass
## Represents a message sent in a channel within Discord.

func _init(d: Dictionary) -> void:
	id = _safe_get(d, 'id', 0) as int
	channel_id = _safe_get(d, 'channel_id', 0) as int
	author = _safe_get(d, 'author', {}) as Dictionary
	content = _safe_get(d, 'content', '') as String
	timestamp = _safe_get(d, 'timestamp', '') as String
	edited_timestamp = _safe_get(d, 'edited_timestamp', '') as String
	tts = _safe_get(d, 'tts', false) as bool
	mention_everyone = _safe_get(d, 'mention_everyone', false) as bool
	mentions = _safe_get(d, 'mentions', []) as Array
	mention_roles = _safe_get(d, 'mention_roles', []) as Array
	mention_channels = _safe_get(d, 'mention_channels', []) as Array
	attachments = _safe_get(d, 'attachments', []) as Array
	embeds = _safe_get(d, 'embeds', []) as Array
	reactions = _safe_get(d, 'reactions', []) as Array
	nonce = _safe_get(d, 'nonce', null) as Variant
	pinned = _safe_get(d, 'pinned', false) as bool
	webhook_id = _safe_get(d, 'webhook_id', 0) as int
	type = _safe_get(d, 'type', 0) as int
	activity = _safe_get(d, 'activity', {}) as Dictionary
	application = _safe_get(d, 'application', {}) as Dictionary
	application_id = _safe_get(d, 'application_id', 0) as int
	message_reference = _safe_get(d, 'message_reference', {}) as Dictionary
	flags = _safe_get(d, 'flags', 0) as int
	referenced_message = _safe_get(d, 'referenced_message', {}) as Dictionary
	interaction = _safe_get(d, 'interaction', {}) as Dictionary
	thread = _safe_get(d, 'thread', {}) as Dictionary
	components = _safe_get(d, 'components', []) as Array
	sticker_items = _safe_get(d, 'sticker_items', []) as Array
	stickers = _safe_get(d, 'stickers', []) as Array
	position = _safe_get(d, 'position', 0) as int
	role_subscription_data = _safe_get(d, 'role_subscription_data', {}) as Dictionary
	resolved = _safe_get(d, 'resolved', {}) as Dictionary

var id: int
var channel_id: int
var author: Dictionary
var content: String
var timestamp: String
var edited_timestamp: String
var tts: bool
var mention_everyone: bool
var mentions: Array
var mention_roles: Array
var mention_channels: Array
var attachments: Array
var embeds: Array
var reactions: Array
var nonce: Variant
var pinned: bool
var webhook_id: int
var type: int
var activity: Dictionary
var application: Dictionary
var application_id: int
var message_reference: Dictionary
var flags: int
var referenced_message: Dictionary
var interaction: Dictionary
var thread: Dictionary
var components: Array
var sticker_items: Array
var stickers: Array
var position: int
var role_subscription_data: Dictionary
var resolved: Dictionary
