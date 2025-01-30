/obj/item/gun/ballistic/automatic/wt550/evil
	name = "\improper C-20A carabine"
	desc = "A lightweight, fully automatic variant of C-20r SMG designed for planetary combat. Uses 4.6x30mm rounds."
	pin = /obj/item/firing_pin/implant/pindicate
	fire_sound = 'modular_nova/modules/modular_weapons/sounds/rifle_heavy.ogg'
	fire_sound_volume = 70
	icon_state = "c20r"
	inhand_icon_state = "c20r"
	recoil = 0.2

/obj/item/gun/ballistic/shotgun/riot/sol/evil/special
	name = "\improper Krait Shotgun"
	desc = "A simplified variant of the SolFed Renoster Shotgun designed by Gorlex Marauders. While cheaper in production, it does come with worse ergonimics and greater recoil."
	recoil = 1

// делаем ящик
/obj/item/storage/toolbox/guncase/interdyne
	name = "Special gun case"
	desc = "A weapon's case. Has a blood-red 'S' stamped on the cover."

/obj/item/storage/toolbox/guncase/interdyne/wt550/PopulateContents()
	new /obj/item/gun/ballistic/automatic/wt550/evil(src)
	new /obj/item/ammo_box/magazine/wt550m9(src)
	new /obj/item/ammo_box/magazine/wt550m9(src)

// Делаем есворд для офицера
/obj/item/melee/energy/sword/saber/green/dyne
	name = "Officer energy sword"
	desc = "“When death comes for me, I will look it right in the eye” - reads the inscription on the hilt."
