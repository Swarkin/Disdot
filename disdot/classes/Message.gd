class_name Message
extends BetterBaseClass
## Represents a message sent in a channel within Discord.

# TODO
func _init(dict: Dictionary) -> void:
	id = dict.get('id', 0) as int
	author = dict.get('author', {}) as Dictionary
	content = dict.get('content', '') as String

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
var embeds: Area2D
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
