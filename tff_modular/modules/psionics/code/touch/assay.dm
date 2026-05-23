// Спелл для чтения разума другого игрока на наличие псионических способностей

/datum/action/cooldown/spell/touch/psionic/assay
	name = "Psionic Assay"
	desc = "Check if the target is a psionic."
	button_icon_state = "tech_audibledeception"
	cooldown_time = 60 SECONDS
	mana_cost = 10
	target_msg = "Your get a headache, but it quickly fades."
	hand_path = /obj/item/melee/touch_attack/psionic/assay
	draw_message = span_notice("You ready your hand to cleanse a patient.")
	drop_message = span_notice("You lower your hand.")
	can_cast_on_self = TRUE
	category = "Tier 1"
	locked = FALSE
	point_cost = 0

/datum/action/cooldown/spell/touch/psionic/assay/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/mendicant)
	if(ishuman(victim))
		var/mob/living/carbon/human/human_victim = victim
		if(human_victim.can_block_magic(antimagic_flags))
			to_chat(human_victim, span_notice("Psionic nearby tries to check you for psionic levels."))
		else
			to_chat(human_victim, span_warning(target_msg))
		owner.visible_message(span_warning("[owner] presses his thumb onto [victim]s forehead."),
							  span_notice("You press your thumb onto [victim]s forehead and begin reading them."))
		to_chat(victim, span_danger("[owner] presses a thumb onto your forehead and holds it there. It burns sligthly!"))
		if(do_after(mendicant, 6 SECONDS, human_victim, IGNORE_SLOWDOWNS, TRUE))
			read_psionic_level(human_victim)
		drain_mana()
		return TRUE
	else
		return FALSE

/datum/action/cooldown/spell/touch/psionic/assay/proc/read_psionic_level(mob/living/carbon/human/patient)
	if(issynthetic(patient) && cast_power < 2)
		to_chat(owner, span_notice("I can see... just numbers. No idea how to work with synths."))
		return FALSE

	if(patient.get_psionic())
		var/datum/psionic/target_psi = patient.get_psionic()
		owner.visible_message(span_notice("[owner] backs off from [patient]."),
							  span_cyan("Target is a psionic. [patient.p_Their()] rank is [target_psi.psionic_level_string]"))
	else
		owner.visible_message(span_notice("[owner] backs off from [patient]."),
							  span_cyan("Target is not a psionic."))
