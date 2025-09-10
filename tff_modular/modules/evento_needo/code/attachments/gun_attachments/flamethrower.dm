/obj/item/attachment/gun/flamethrower
	name = "underbarrel flamethrower"
	desc = "A compact underbarrel flamethrower holding up to 20 units of fuel, enough for two sprays."
	icon_state = "flamethrower"
	weapon_type = null
	var/obj/item/flamethrower/underbarrel/attached_flamethrower

/obj/item/attachment/gun/flamethrower/Initialize()
	. = ..()
	attached_flamethrower = new /obj/item/flamethrower/underbarrel(src)

/obj/item/attachment/gun/flamethrower/Destroy()
	. = ..()
	QDEL_NULL(attached_flamethrower)

/obj/item/attachment/gun/flamethrower/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	if(attached_flamethrower.lit == TRUE)
		attached_flamethrower.toggle_igniter(user)
	else if(attached_flamethrower.lit == FALSE)
		attached_flamethrower.toggle_igniter(user)

/obj/item/attachment/gun/flamethrower/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/tank/internals/plasma))
		attached_flamethrower.attackby(I,user)
	else
		return ..()

/obj/item/attachment/gun/flamethrower/on_preattack(obj/item/gun/gun, atom/target, mob/living/user, list/params)
	if(gun.gun_firemodes[gun.firemode_index] == FIREMODE_UNDERBARREL)
		log_combat(user, target, "flamethrowered", src)
		attached_flamethrower.flame_turf(get_turf(target))
		return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/item/attachment/gun/flamethrower/on_ctrl_click(obj/item/gun/gun, mob/user)
	. = ..()
	attached_flamethrower.toggle_igniter(user)

/obj/item/flamethrower/underbarrel
	name = "underbarrel flamethrower"
	desc = "Something is wrong if you're seeing this."
	create_full = TRUE

/obj/item/flamethrower/underbarrel/Initialize(mapload)
	. = ..()
	ptank = new /obj/item/tank/internals/plasma/flamethrower_underbarrel(src)

// you cant pull out the fuel beaker
/obj/item/flamethrower/underbarrel/click_alt(mob/user)
	return

/obj/item/tank/internals/plasma/flamethrower_underbarrel
	name = "internal fuel tank"
	desc = "An internal fuel tank for a flamethrower. You shouldn't have been able to pull this out."


