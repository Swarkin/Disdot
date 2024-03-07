class_name Activity
extends BetterBaseClass

var name: String			## Activity's name
var type: int				## Activity type
var url: String				## Stream URL, is validated when type is 1
var created_at: int			## Unix timestamp (in milliseconds) of when the activity was added to the user's session
var timestamps: Dictionary	## Unix timestamps for start and/or end of the game
var application_id: String	## Application ID for the game
var details: String			## What the player is currently doing
var state: String			## User's current party status, or text used for a custom status
var emoji: Dictionary		## Emoji used for a custom status
var party: Dictionary		## Information for the current party of the player
var assets: Dictionary		## Images for the presence and their hover texts
var secrets: Dictionary		## Secrets for Rich Presence joining and spectating
var instance: bool			## Whether or not the activity is an instanced game session
var flags: int				## Activity flags ORd together, describes what the payload includes
var buttons: Array			## Custom buttons shown in the Rich Presence (max 2)

func _init(d: Dictionary) -> void:
	name = _safe_get(d, 'name', '') as String
	type = _safe_get(d, 'type', 0) as int
	url = _safe_get(d, 'url', '') as String
	created_at = _safe_get(d, 'created_at', 0) as int
	timestamps = _safe_get(d, 'timestamps', {}) as Dictionary
	application_id = _safe_get(d, 'application_id', '') as String
	details = _safe_get(d, 'details', '') as String
	state = _safe_get(d, 'state', '') as String
	emoji = _safe_get(d, 'emoji', {}) as Dictionary
	party = _safe_get(d, 'party', {}) as Dictionary
	assets = _safe_get(d, 'assets', {}) as Dictionary
	secrets = _safe_get(d, 'secrets', {}) as Dictionary
	instance = _safe_get(d, 'instance', false) as bool
	flags = _safe_get(d, 'flags', 0) as int
	buttons = _safe_get(d, 'buttons', []) as Array
