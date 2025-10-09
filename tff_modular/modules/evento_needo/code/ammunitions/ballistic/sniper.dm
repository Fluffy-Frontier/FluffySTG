//7.5x64mm CLIP

/obj/item/ammo_casing/a75clip
	name = "7.5x64mm CLIP bullet casing"
	desc = "A 7.5x64mm CLIP bullet casing."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo_bullets.dmi'
	icon_state = "big-brass"
	caliber = CALIBER_75X64MM
	projectile_type = /obj/projectile/bullet/a75clip

/obj/item/ammo_casing/a75clip/trac
	name = "7.5x64mm CLIP tracker"
	desc = "A 7.5x64mm CLIP tracker."
	projectile_type = /obj/projectile/bullet/a75clip/trac
	icon_state = "big-brass-trac"

// .300 Magnum (Smile Rifle)

/obj/item/ammo_casing/a300
	name = ".300 Magnum bullet casing"
	desc = "A .300 Magnum bullet casing."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo_bullets.dmi'
	icon_state = "rifle-steel"
	caliber = CALIBER_A300
	projectile_type = /obj/projectile/bullet/c300

/obj/item/ammo_casing/a300/trac
	name = ".300 Magnum Trac bullet casing"
	desc = "A .300 Magnum Tracker casing."
	icon_state = "rifle-steel-trac"
	projectile_type = /obj/projectile/bullet/c300/trac
