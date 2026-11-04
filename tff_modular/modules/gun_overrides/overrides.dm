//This file overrides the Nova gun overrides. Its silly as fuck but yes

//Combat shotgun
/obj/item/gun/ballistic/shotgun/automatic/combat
	name = "combat shotgun"
	desc = "A semi automatic shotgun with tactical furniture and a six-shell capacity underneath."
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "cshotgun" //In case of something bad
	worn_icon = 'icons/mob/clothing/back.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'icons/mob/inhands/weapons/64x_guns_right.dmi'
	inhand_icon_state = "shotgun_combat"
	inhand_x_dimension = 64
	inhand_y_dimension = 64

//Compact combat shotgun
/obj/item/gun/ballistic/shotgun/automatic/combat/compact
	worn_icon = 'icons/mob/clothing/back.dmi'
	worn_icon_state = "cshotgunc"

//Riot grenade launcher
/obj/item/gun/grenadelauncher //Begone, demoman
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'

//Nukie M90
/obj/item/gun/ballistic/automatic/m90
	icon = 'icons/obj/weapons/guns/ballistic.dmi'

//Nukie C20R
/obj/item/gun/ballistic/automatic/c20r
	icon = 'icons/obj/weapons/guns/ballistic.dmi'

