class_name User
extends BetterBaseClass
## Users in Discord are generally considered the base entity. Users can spawn across the entire platform, be members of guilds, participate in text and voice chat, and much more. Users are separated by a distinction of "bot" vs "normal." Although they are similar, bot users are automated users that are "owned" by another user. Unlike normal users, bot users do not have a limitation on the number of Guilds they can be a part of.[br][url]https://discord.com/developers/docs/resources/user#user-object[/url]

var id: int										## the user's id
var username: String					## the user's username, not unique across the platform
var discriminator: int				## the user's Discord-tag
var global_name: String				## the user's display name, if it is set. For bots, this is the application name
var avatar: String						## the user's avatar hash
var bot: bool									## whether the user belongs to an OAuth2 application
var system: bool							## whether the user is an Official Discord System user (part of the urgent message system)
var mfa_enabled: bool					## whether the user has two factor enabled on their account
var banner: String						## the user's banner hash
var accent_color: int					## the user's banner color encoded as an integer representation of hexadecimal color code
var locale: String						## the user's chosen language option
var verified: bool						## whether the email on this account has been verified
var email: String							## the user's email
var flags: int								## the flags on a user's account
var premium_type: int					## the type of Nitro subscription on a user's account
var public_flags: int					## the public flags on a user's account
var avatar_decoration: String	## the user's avatar decoration hash
