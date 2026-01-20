/// TGMC_XENOS (old nova sector xenos)

// Взмах хвоста дефендера + является базовым для взмахов хвоста королевы и равагера
/datum/action/cooldown/spell/aoe/repulse/xeno/tgmc_tailsweep
	name = "Crushing Tail Sweep"
	desc = "Throw back attackers with a sweep of your tail, likely breaking some bones in the process."
	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED | AB_CHECK_LYING
	cooldown_time = 60 SECONDS
	aoe_radius = 1
	button_icon = 'tff_modular/modules/tgmc_xenos/icons/xeno_actions.dmi'
	button_icon_state = "crush_tail"
	sparkle_path = /obj/effect/temp_visual/dir_setting/tailsweep/defender

	/// The sound that the tail sweep will make upon hitting something
	var/impact_sound = 'sound/effects/clang.ogg'
	/// How long mobs hit by the tailsweep should be knocked down for
	var/knockdown_time = 4 SECONDS
	/// How much damage tail sweep impacts should do to a mob
	var/impact_damage = 30
	/// What wound bonus should the tai sweep impact have
	var/impact_wound_bonus = 20
	/// What type of sharpness should this tail sweep have
	var/impact_sharpness = FALSE
	/// What type of damage should the tail sweep do
	var/impact_damage_type = BRUTE
	// Урон по мехам
	var/vehicle_damage = 20
	// Можем ли откинуть мех ударом хвоста
	var/vehicle_throwing = TRUE
	// Время стана оператора меха
	var/mecha_occupant_stun_duration

/datum/action/cooldown/spell/aoe/repulse/xeno/tgmc_tailsweep/Grant(mob/granted_to)
	. = ..()
	RegisterSignal(granted_to, COMSIG_XENO_PLASMA_ADJUSTED, PROC_REF(on_owner_plasma_change))

/datum/action/cooldown/spell/aoe/repulse/xeno/tgmc_tailsweep/Remove(mob/removed_from)
	UnregisterSignal(removed_from, COMSIG_XENO_PLASMA_ADJUSTED)
	return ..()

/datum/action/cooldown/spell/aoe/repulse/xeno/tgmc_tailsweep/proc/on_owner_plasma_change()
	SIGNAL_HANDLER

	build_all_button_icons()

/datum/action/cooldown/spell/aoe/repulse/xeno/tgmc_tailsweep/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/carbon/alien/adult/tgmc/owner_alien = owner
	if(!istype(owner_alien) || owner_alien.unable_to_use_abilities)
		return FALSE

/datum/action/cooldown/spell/aoe/repulse/xeno/tgmc_tailsweep/cast_on_thing_in_aoe(atom/movable/victim, atom/caster)
	if(!isliving(victim) && !ismecha(victim))
		return

	if(isalien(victim))
		return

	var/turf/throwtarget = get_edge_target_turf(caster, get_dir(caster, get_step_away(victim, caster)))
	var/dist_from_caster = get_dist(victim, caster)
	if(isliving(victim))
		var/mob/living/victim_living = victim
		if(dist_from_caster <= 0)
			victim_living.Knockdown(knockdown_time)
			if(sparkle_path)
				new sparkle_path(get_turf(victim_living), get_dir(caster, victim_living))
		else
			victim_living.Knockdown(knockdown_time * 2) //They are on the same turf as us, or... somewhere else, I'm not sure how but they are getting smacked down

		victim_living.apply_damage(impact_damage, impact_damage_type, BODY_ZONE_CHEST, wound_bonus = impact_wound_bonus, sharpness = impact_sharpness)
		shake_camera(victim_living, 4, 3)
		playsound(victim_living, impact_sound, 100, TRUE, 8, 0.9)
		victim.visible_message(span_danger("[caster]'s tail slams into [victim], throwing them back!"), span_userdanger("[caster]'s tail slams into you, throwing you back!"))

		victim_living.safe_throw_at(throwtarget, ((clamp((max_throw - (clamp(dist_from_caster - 2, 0, dist_from_caster))), 3, max_throw))), 1, caster, force = repulse_force)

	else if(ismecha(victim))
		var/obj/vehicle/sealed/mecha/victim_mecha = victim
		var/list/mob/occupants = victim_mecha.return_occupants()

		for(var/mob/living/occupant in occupants)
			if(!isliving(occupant))
				continue
			if(!isnull(mecha_occupant_stun_duration))
				occupant.Stun(mecha_occupant_stun_duration)
			shake_camera(occupant, 4, 3)
			playsound(occupant, impact_sound, 100, TRUE, 8, 0.9)

		victim_mecha.take_damage(vehicle_damage, impact_damage_type)
		victim_mecha.visible_message(span_danger("[caster]'s tail slams into [victim], throwing them back!"), span_userdanger("[caster]'s tail slams into you, throwing you back!"))

		if(vehicle_throwing)
			if((victim_mecha.max_integrity < 400) && (dist_from_caster <= 1))
				victim_mecha.safe_throw_at(throwtarget, 1, 1, caster, spin = FALSE, force = repulse_force)

/obj/effect/temp_visual/dir_setting/tailsweep/defender
	icon = 'tff_modular/modules/tgmc_xenos/icons/xeno_actions.dmi'
	icon_state = "crush_tail_anim"


// Взмах хвоста преторианца
/datum/action/cooldown/spell/aoe/repulse/xeno/tgmc_tailsweep/hard_throwing
	name = "Flinging Tail Sweep"
	desc = "Throw back attackers with a sweep of your tail that is much stronger than other aliens."

	aoe_radius = 2
	repulse_force = MOVE_FORCE_OVERPOWERING //Fuck everyone who gets hit by this tail in particular

	button_icon_state = "throw_tail"

	sparkle_path = /obj/effect/temp_visual/dir_setting/tailsweep/praetorian

	impact_sound = 'sound/items/weapons/slap.ogg'
	impact_damage = 20
	impact_wound_bonus = 10

	mecha_occupant_stun_duration = 1.2 SECONDS

/obj/effect/temp_visual/dir_setting/tailsweep/praetorian
	icon = 'tff_modular/modules/tgmc_xenos/icons/xeno_actions.dmi'
	icon_state = "throw_tail_anim"


// Взмах хвоста равагера
/datum/action/cooldown/spell/aoe/repulse/xeno/tgmc_tailsweep/slicing
	name = "Slicing Tail Sweep"
	desc = "Throw back attackers with a swipe of your tail, slicing them with its sharpened tip."

	aoe_radius = 2

	button_icon_state = "slice_tail"

	sparkle_path = /obj/effect/temp_visual/dir_setting/tailsweep/ravager

	sound = 'tff_modular/modules/tgmc_xenos/sound/alien_tail_swipe.ogg' //The defender's tail sound isn't changed because its big and heavy, this isn't

	impact_sound = 'modular_nova/master_files/sound/weapons/bloodyslice.ogg'
	impact_damage = 40
	impact_sharpness = SHARP_EDGED

	vehicle_damage = 10
	mecha_occupant_stun_duration = null
	vehicle_throwing = FALSE

/obj/effect/temp_visual/dir_setting/tailsweep/ravager
	icon = 'tff_modular/modules/tgmc_xenos/icons/xeno_actions.dmi'
	icon_state = "slice_tail_anim"
