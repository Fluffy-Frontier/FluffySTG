/obj/item/gun/ballistic/automatic/wt550/evil
	desc = "Light-weight and fully automatic. Uses 4.6x30mm rounds."
	pin = /obj/item/firing_pin/implant/pindicate
	recoil = 0.2

/obj/item/gun/ballistic/shotgun/riot/sol/evil/special
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
