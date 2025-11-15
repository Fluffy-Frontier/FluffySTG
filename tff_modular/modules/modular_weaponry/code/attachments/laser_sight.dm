/obj/item/attachment/laser_sight
	name = "laser sight"
	desc = "Designed to be rail-mounted on a compatible firearm to provide increased accuracy and decreased spread."
	icon_state = "laserpointer"

	attach_features_flags = ATTACH_REMOVABLE_HAND|ATTACH_TOGGLE
	pixel_shift_x = 1
	pixel_shift_y = 4

/obj/item/attachment/laser_sight/toggle_attachment(obj/item/gun/gun, mob/user)
	. = ..()

	if(toggled)
		gun.spread = initial(gun.spread) - 3 >= 0 ? initial(gun.spread) - 3 : 0
		gun.spread_unwielded = initial(gun.spread_unwielded) - 3 >= 0 ? initial(gun.spread_unwielded) - 3 : 0
	else
		gun.spread += initial(gun.spread) - 3 >= 0 ? initial(gun.spread) + 3 : 1
		gun.spread_unwielded = initial(gun.spread_unwielded) - 3 >= 0 ? initial(gun.spread_unwielded) + 3 : 1

	playsound(user, toggled ? 'sound/items/weapons/magin.ogg' : 'sound/items/weapons/magout.ogg', 40, TRUE)
