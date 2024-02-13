class_name GuildPreview
extends BaseGuild

func _init(d: Dictionary) -> void:
	id = _safe_get(d, 'id', 0) as int
	name = _safe_get(d, 'name', '') as String
	icon = _safe_get(d, 'icon', '') as String
	splash = _safe_get(d, 'splash', '') as String
	discovery_splash = _safe_get(d, 'discovery_splash', '') as String
	emojis = _safe_get(d, 'emojis', []) as Array#[Emoji]
	features = PackedStringArray(_safe_get(d, 'features', []) as Array[String])
	approximate_member_count = _safe_get(d, 'approximate_member_count', 0) as int
	approximate_presence_count = _safe_get(d, 'approximate_presence_count', 0) as int
	description = _safe_get(d, 'description', '') as String
	stickers = _safe_get(d, 'stickers', []) as Array#[Sticker]

var id: int							## guild id
var name: String
var icon: String
var splash: String
var discovery_splash: String
var emojis: Array#[Emoji]
var features: PackedStringArray
var approximate_member_count: int
var approximate_presence_count: int
var description: String
var stickers: Array#[Sticker]
