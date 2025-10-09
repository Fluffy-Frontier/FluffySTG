//7.5x64mm CLIP (F90, Boomslang)

/obj/projectile/bullet/a75clip
	name = "7.5x64mm CLIP bullet"
	stamina = 10
	damage = 40
	armour_penetration = 50

	speed = BULLET_SPEED_SNIPER

	icon_state = "redtrac"
	light_color = COLOR_SOFT_RED
	light_range = 2

/obj/projectile/bullet/a75clip/trac
	damage = 10
	armour_penetration = 0
	shrapnel_type = /obj/item/shrapnel/bullet/tracker/a75clip

/obj/item/shrapnel/bullet/tracker/a75clip
	name = "7.5x64mm Tracker"

//this should only exist on the big ass turrets. don't fucking give players this.
/obj/projectile/bullet/a75clip/rubber //"rubber"
	name = "7.5x64mm CLIP rubber bullet"
	damage = 10
	stamina = 40

// .300 Magnum

/obj/projectile/bullet/c300
	name = ".300 Magnum bullet"
	damage = 50
	stamina = 10
	armour_penetration = 40
	speed = BULLET_SPEED_RIFLE

/obj/projectile/bullet/c300/trac
	name = ".300 Tracker"
	damage = 10
	armour_penetration = 0
	shrapnel_type = /obj/item/shrapnel/bullet/tracker
