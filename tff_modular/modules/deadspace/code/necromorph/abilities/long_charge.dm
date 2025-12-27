/datum/action/cooldown/mob_cooldown/charge/necro/long_charge
	name = "Toggle Charging"
	desc = "Short ranged charge which helps you to destroy any obstacles on your way."
	cooldown_time = 15 SECONDS
	charge_distance = 5
	charge_damage = 30
	destroy_objects = TRUE

/datum/action/cooldown/mob_cooldown/charge/necro/long_charge/on_moved(atom/source)
	INVOKE_ASYNC(src, PROC_REF(DestroySurroundings), source)

/datum/action/cooldown/mob_cooldown/charge/necro/long_charge/on_bump(atom/movable/source, atom/target)
	if(owner == target)
		return
	if(destroy_objects)
		if(isturf(target))
			SSexplosions.medturf += target
		if(isobj(target) && target.density)
			SSexplosions.med_mov_atom += target

	INVOKE_ASYNC(src, PROC_REF(DestroySurroundings), source)
	try_hit_target(source, target)
