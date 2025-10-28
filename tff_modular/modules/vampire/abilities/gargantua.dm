/datum/vampire_subclass/gargantua
	standard_powers = list(
		/datum/action/cooldown/vampire/blood_swell = 150,
		/datum/action/cooldown/vampire/stomp = 250,
		/datum/action/cooldown/vampire/blood_rush = 250,
		/datum/vampire_passive/blood_swell_upgrade = 400,
		/datum/action/cooldown/vampire/overwhelming_force = 600,
		/datum/action/cooldown/mob_cooldown/charge/vampire = 800,
		)
	glare_power_mod = 1.2

/datum/action/cooldown/vampire/blood_swell
	name = "Blood Swell (30)"
	desc = "You infuse your body with blood, making you highly resistant to stuns and physical damage. However, this makes you unable to fire ranged weapons while it is active."
	cooldown_time = 40 SECONDS
	required_blood = 30
	button_icon_state = "blood_swell"

/datum/action/cooldown/vampire/blood_swell/Activate(atom/target)
	. = ..()
	var/mob/living/carbon/human/vamp = owner

	vamp.apply_status_effect(/datum/status_effect/blood_swell)

/datum/status_effect/blood_swell
	id = "bloodswell"
	duration = 10 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/vampire/blood_swell

/atom/movable/screen/alert/status_effect/vampire/blood_swell
	name = "Blood Swell"
	desc = "Your blood gives you superhuman speed."
	icon_state = "blood_swell_status"

/datum/status_effect/blood_swell/on_apply()
	. = ..()
	var/mob/living/carbon/human/vamp = owner
	var/datum/antagonist/vampire/vamp_datum = vamp.mind?.has_antag_datum(/datum/antagonist/vampire)
	ADD_TRAIT(vamp, TRAIT_NOGUNS, ACTION_TRAIT)
	vamp.physiology.stun_mod *= 0.5
	vamp.physiology.stamina_mod *= 0.5
	vamp.physiology.brute_mod *= 0.75
	vamp.physiology.burn_mod *= 0.75
	if(locate(/datum/vampire_passive/blood_swell_upgrade) in vamp_datum.powers)
		RegisterSignal(vamp, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(on_attack), TRUE)

/datum/status_effect/blood_swell/proc/on_attack(mob/living/source, atom/target, proximity, modifiers)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/vamp = source
	var/mob/living/carbon/human/victim = target
	if(!isliving(target))
		return
	vamp.do_attack_animation(target, ATTACK_ANIMATION_BLUNT)
	victim.adjustBruteLoss(20)

/datum/status_effect/blood_swell/on_remove()
	. = ..()
	var/mob/living/carbon/human/vamp = owner
	var/datum/antagonist/vampire/vamp_datum = vamp.mind?.has_antag_datum(/datum/antagonist/vampire)
	REMOVE_TRAIT(vamp, TRAIT_NOGUNS, ACTION_TRAIT)
	vamp.physiology.stun_mod /= 0.5
	vamp.physiology.stamina_mod /= 0.5
	vamp.physiology.brute_mod /= 0.75
	vamp.physiology.burn_mod /= 0.75
	if(locate(/datum/vampire_passive/blood_swell_upgrade) in vamp_datum.powers)
		UnregisterSignal(vamp, COMSIG_LIVING_UNARMED_ATTACK)

/datum/action/cooldown/vampire/stomp
	name = "Seismic Stomp (30)"
	desc = "You slam your foot into the ground sending a powerful shockwave through the station's hull, knocking peoples around you."
	button_icon_state = "seismic_stomp"
	required_blood = 30
	cooldown_time = 60 SECONDS

/datum/action/cooldown/vampire/stomp/Activate(atom/target)
	. = ..()
	var/mob/living/carbon/human/vamp = owner
	var/turf/T = get_turf(vamp)
	playsound(T, 'sound/effects/meteorimpact.ogg', 100, TRUE)
	new /obj/effect/temp_visual/circle_wave/brown(T)
	for(var/mob/living/carbon/human/vampire_victims in view(3, T))
		if(vampire_victims == vamp)
			continue
		vampire_victims.SetKnockdown(2 SECONDS)
		vampire_victims.SetParalyzed(2 SECONDS)
		vampire_victims.adjustBruteLoss(20)

	for(var/turf/open/floor/floor_tiles in view(3, T))
		if(prob(50))
			floor_tiles.break_tile()

/datum/action/cooldown/vampire/overwhelming_force
	name = "Overwhelming Force (10)"
	desc = "When toggled you will pry open doors by clicking on it."
	cooldown_time = 2 SECONDS
	button_icon_state = "OH_YEAAAAH"

/datum/action/cooldown/vampire/overwhelming_force/Activate(atom/target)
	. = ..()
	RegisterSignal(owner, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(pry_door), TRUE)

/datum/action/cooldown/vampire/overwhelming_force/proc/pry_door(mob/living/source, atom/target, proximity, modifiers)
	SIGNAL_HANDLER
	var/datum/antagonist/vampire/vamp = source.mind?.has_antag_datum(/datum/antagonist/vampire)
	var/obj/item/card/id/id_card = source.get_idcard(hand_first = TRUE)
	if(istype(target, /obj/machinery/door))
		var/obj/machinery/door/prying_item = target
		if(vamp.current_blood_level <= 10)
			return
		if(prying_item.check_access(id_card))
			return
		prying_item.open(TRUE)
		vamp.adjust_blood(-10, FALSE)

/datum/action/cooldown/vampire/blood_rush
	name = "Blood Rush (30)"
	desc = "Infuse yourself with blood magic to boost your movement speed and break out of leg restraints."
	cooldown_time = 30 SECONDS
	required_blood = 30
	button_icon_state = "blood_rush"

/datum/action/cooldown/vampire/blood_rush/Activate(atom/target)
	. = ..()
	var/mob/living/carbon/human/vamp = owner
	var/obj/item/restraints/cuffs
	vamp.apply_status_effect(/datum/status_effect/blood_rush)
	vamp.clear_cuffs(cuffs)
	vamp.SetKnockdown(0)
	vamp.set_resting(FALSE, instant = TRUE)

/datum/status_effect/blood_rush
	id = "bloodrush"
	duration = 10 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/vampire/blood_rush

/datum/status_effect/blood_rush/on_apply()
	. = ..()
	var/mob/living/carbon/human/vamp = owner
	vamp.add_movespeed_modifier(/datum/movespeed_modifier/blood_rush)
	return TRUE

/datum/status_effect/blood_rush/on_remove()
	. = ..()
	var/mob/living/carbon/human/vamp = owner
	vamp.remove_movespeed_modifier(/datum/movespeed_modifier/blood_rush)
	return TRUE

/datum/movespeed_modifier/blood_rush
	multiplicative_slowdown = -0.3

/atom/movable/screen/alert/status_effect/vampire/blood_rush
	name = "Blood Rush"
	desc = "Your blood gives you superhuman speed."
	icon_state = "blood_rush_status"

/datum/action/cooldown/mob_cooldown/charge/vampire
	name = "Charge (30)"
	desc = "You charge into choosen direction, sending every enemy in way fly away."
	button_icon_state = "vampire_charge"
	button_icon = 'tff_modular/modules/vampire/actions.dmi'
	background_icon = 'tff_modular/modules/vampire/actions.dmi'
	overlay_icon = 'tff_modular/modules/vampire/actions.dmi'
	background_icon_state = "bg_vampire"
	cooldown_time = 30 SECONDS
	charge_speed = 0.5
	charge_damage = 40
	destroy_objects = TRUE
	charge_past = 10
	charge_delay = 0.1

/datum/action/cooldown/mob_cooldown/charge/vampire/IsAvailable(feedback)
	. = ..()
	var/mob/living/carbon/human/vamp_human = owner
	var/datum/antagonist/vampire/vamp = vamp_human.mind?.has_antag_datum(/datum/antagonist/vampire)
	if(vamp.current_blood_level < 30)
		to_chat(vamp_human, span_danger("You have not enough blood to use this action."))
		return FALSE
	return TRUE

/datum/action/cooldown/mob_cooldown/charge/vampire/hit_target(atom/movable/source, mob/living/target, damage_dealt)
	. = ..()
	var/mob/living/carbon/human/vamp_living = source
	var/datum/antagonist/vampire/vamp = vamp_living.mind?.has_antag_datum(/datum/antagonist/vampire)
	var/mob/living/carbon/human/vamp_victim = target
	vamp.adjust_blood(-30, FALSE)
	vamp_victim.adjustBruteLoss(30)
	var/throwtarget = get_edge_target_turf(vamp_living, get_dir(vamp_living, get_step_away(vamp_victim, vamp_living)))
	vamp_victim.throw_at(throwtarget, 3, 5)
