// Питье крови, при выпивании крови разумного дает 50 единиц крови.
/datum/action/cooldown/vampire/drain_blood
	name = "Drain Blood"

/datum/action/cooldown/vampire/drain_blood/Trigger(trigger_flags)
	. = ..()
	if(!iscarbon(owner))
		return FALSE
	var/mob/living/carbon/human/user = owner
	var/datum/antagonist/vampire/vampire = user.mind.has_antag_datum(/datum/antagonist/vampire)
	var/mob/living/carbon/human/victim = user.pulling
	if(!iscarbon(user.pulling))
		return FALSE
	if(victim.stat == DEAD)
		to_chat(user, span_warning("You need a living victim!"))
		return FALSE
	if(victim.mind.has_antag_datum(/datum/antagonist/vampire))
		to_chat(user, span_warning("Victim's blood is awful."))
		return FALSE
	var/blood_name = LOWER_TEXT(user.get_bloodtype()?.get_blood_name())
	if(!victim.blood_volume || victim.get_blood_reagent() != user.get_blood_reagent())
		if (blood_name)
			to_chat(user, span_warning("[victim] doesn't have [blood_name]!"))
		else
			to_chat(user, span_warning("[victim] doesn't have anything inside of them you could drink!"))
		return FALSE
	if(!do_after(user, 3 SECONDS, target = victim, hidden = TRUE))
		return FALSE
	var/drained_blood = min(victim.blood_volume, 100)
	victim.show_message(span_danger("[user] is draining your blood!"))
	playsound(user, 'sound/items/drink.ogg', 30, TRUE, -2)
	victim.blood_volume = clamp(victim.blood_volume - drained_blood, 0, BLOOD_VOLUME_MAXIMUM)
	victim.blood_volume = clamp(victim.blood_volume + (drained_blood * 0.25), 0, BLOOD_VOLUME_MAXIMUM)
	if(!victim.client)
		to_chat(user, span_cult_italic("The victim's blood does not satisfy you."))
		return TRUE
	else
		to_chat(user, span_cult_italic("You can feel the warm blood..."))
	vampire.adjust_blood(50, TRUE)
	vampire.check_vampire_upgrade()
	if(!victim.blood_volume)
		to_chat(user, span_notice("You finish off [victim]'s [blood_name] supply."))
	return TRUE

// Станит людей и боргов в радиусе 3x3
/datum/action/cooldown/vampire/glare
	name = "Glare"
	cooldown_time = 25 SECONDS
	button_icon_state = "vampire_glare"

/datum/action/cooldown/vampire/glare/Activate(atom/target)
	. = ..()
	var/datum/antagonist/vampire/vamp_datum = owner.mind?.has_antag_datum(/datum/antagonist/vampire)
	if(!isliving(owner))
		return FALSE
	owner.flash_lighting_fx(1, 2, LIGHT_COLOR_INTENSE_RED, 0.7 SECONDS)
	for(var/mob/living/carbon/human/victim in range(1, owner))
		if(victim.mind?.has_antag_datum(/datum/antagonist/vampire))
			continue
		if(victim.can_block_magic(MAGIC_RESISTANCE_HOLY, charge_cost = 0))
			continue
		if(victim == owner)
			continue
		if(vamp_datum.subclass)
			victim.adjustStaminaLoss(60 * vamp_datum.subclass.glare_power_mod)
		else
			victim.adjustStaminaLoss(60)
		victim.Paralyze(3 SECONDS)
		victim.flash_act(2, FALSE)
		victim.adjust_timed_status_effect(12 SECONDS, /datum/status_effect/speech/slurring)
		to_chat(victim, "<span class='warning'>You are blinded by [owner]'s glare.</span>")
	for(var/mob/living/silicon/robot/synth_victim in range(1, owner))
		if(!iscyborg(synth_victim))
			continue
		synth_victim.emp_knockout(4 SECONDS)
	return TRUE

// Восстановление, лечит стамину и при наличии пассивки лечит ХП.
/datum/action/cooldown/vampire/rejuvenate
	name = "Rejuvenate"
	cooldown_time = 30 SECONDS
	button_icon_state = "vampire_rejuvinate"

/datum/action/cooldown/vampire/rejuvenate/Activate(atom/target)
	. = ..()
	var/mob/living/carbon/vampire = owner
	vampire.SetAllImmobility(0)
	vampire.setStaminaLoss(0)
	vampire.set_resting(FALSE, instant = TRUE)
	var/datum/antagonist/vampire/antag_datum = vampire.mind?.has_antag_datum(/datum/antagonist/vampire)
	if(locate(/datum/vampire_passive/regen) in antag_datum.powers)
		vampire.adjustBruteLoss(-15)
		vampire.adjustFireLoss(-15)
		vampire.adjustToxLoss(-20)
		vampire.adjustOrganLoss(-10)
	to_chat(vampire, "<span class='notice'>You instill your body with clean blood and remove any incapacitating effects.</span>")

// Получить специализацию. Пока что просто дает подкласс гаргантюа и не более.
/datum/action/cooldown/vampire/specialize
	name = "Receive Specialization"
	cooldown_time = 2 SECONDS
	button_icon_state = "select_class"

/datum/action/cooldown/vampire/specialize/Activate(atom/target)
	. = ..()
	var/mob/living/carbon/vamp_human = owner
	var/datum/antagonist/vampire/vamp = vamp_human.mind?.has_antag_datum(/datum/antagonist/vampire)
	if(vamp.subclass)
		qdel(src)
		Remove(vamp_human)
		return FALSE

	var/static/list/specialization
	if(!specialization)
		specialization = list()

		specialization_list(
			specialization_name = "Gargantua",
			specialization_image = image(icon = 'tff_modular/modules/vampire/actions.dmi', icon_state = "blood_swell"),
			specialization_info = span_info("Gargantua is a strong, durable class aimed at good defense and physical strength. It has poor mobility compared to other classes."),
			specialization = specialization,
		)

	var/vampire_specialization = show_radial_menu(vamp_human, vamp_human, specialization, radius = 38, require_near = TRUE, tooltips = TRUE)
	if(QDELETED(src) || QDELETED(vamp_human) || isnull(vampire_specialization))
		return FALSE

	grant_specialization(vampire_specialization)
	qdel(src)
	Remove(vamp_human)
	return TRUE

/datum/action/cooldown/vampire/specialize/proc/specialization_list(specialization_name, specialization_image, specialization_info, list/specialization)
	var/datum/radial_menu_choice/specialization_option = new()

	specialization_option.name = specialization_name
	specialization_option.image = specialization_image
	specialization_option.info = specialization_info

	specialization[specialization_name] = specialization_option

/datum/action/cooldown/vampire/specialize/proc/grant_specialization(vampire_specialization)
	var/mob/living/carbon/vamp_human = owner
	var/datum/antagonist/vampire/vamp = vamp_human.mind?.has_antag_datum(/datum/antagonist/vampire)
	switch(vampire_specialization)
		if("Gargantua")
			vamp.subclass = new /datum/vampire_subclass/gargantua(vamp)
			to_chat(vamp_human, span_cult_italic("I feel power, anger, and a desire to destroy. I'm ready to destroy anyone who gets in my way. No one will stop me from achieving my goal..."))
	vamp.check_vampire_upgrade()
