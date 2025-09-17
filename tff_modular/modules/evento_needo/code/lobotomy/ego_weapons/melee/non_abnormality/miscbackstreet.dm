//Axe Gang is just garbage for the backstreets.

/obj/item/ego_weapon/city/axegang
	name = "axe gang axe"
	desc = "An axe used by the axe gangs of the backstreets."
	icon_state = "axe_grunt"
	force = 32
	attack_speed = CLICK_CD_MELEE
	damtype = BRUTE

	attack_verb_continuous = list("slices", "slashes", "stabs")
	attack_verb_simple = list("slice", "slash", "stab")
	hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/ego/axe2.ogg'

/obj/item/ego_weapon/city/axegang/leader
	name = "axe gang heavy axe"
	desc = "An axe used by the gang leaders of the of the backstreet's Axe Gang."
	icon_state = "axe_gang"
	force = 42
