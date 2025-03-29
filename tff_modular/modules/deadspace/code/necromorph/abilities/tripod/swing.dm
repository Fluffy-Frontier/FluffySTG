/datum/action/cooldown/necro/swing/tripod
	name = "Tripod's Swing"
	cooldown_time = 3.5 SECONDS
	damage = 65
	swing_time = 0.6 SECONDS
	move_time = 0.6 SECONDS
	visual_type = /obj/effect/temp_visual/swing/tripod

/datum/action/cooldown/necro/swing/tripod/PreActivate(atom/target)
	if(owner.incapacitated)
		return FALSE
	if(!get_turf(target))
		return FALSE

	return ..()

/datum/action/cooldown/necro/swing/tripod/Activate(atom/target)
	StartCooldown()
	target = get_turf(target)
	owner.face_atom(target)

	actively_moving = FALSE
	swing_target = target
	windup()
	swing()
	return TRUE


/datum/action/cooldown/necro/swing/tripod/hit_mob(mob/living/L)
	//We harmlessly swooce over lying targets
	if (L.body_position == LYING_DOWN)
		return FALSE
	.=..()

/obj/effect/temp_visual/swing/tripod
	name = "tentacle"
	icon = 'tff_modular/modules/deadspace/icons/necromorphs/swinging_limbs.dmi'
	base_icon_state = "tripod_left"
	icon_state = "tripod_left"
	pixel_x = -48
