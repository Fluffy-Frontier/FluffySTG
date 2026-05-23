// Восстанавливает кровь, окси урон, открытые травмы. Не лечит другие типы урона.
// Если уровень Эпсилон - удаляет лярвы ксеноморфов.
/datum/action/cooldown/spell/touch/psionic/mending
	name = "Psionic Mending"
	desc = "Mend a creature's wounds. This handles internal wounds as well."
	button_icon_state = "tech_biomedaura"
	cooldown_time = 60 SECONDS
	mana_cost = 30
	target_msg = "You body numbs a little."
	hand_path = /obj/item/melee/touch_attack/psionic/mending
	draw_message = span_notice("You ready your hand to mend a patient.")
	drop_message = span_notice("You lower your hand.")
	can_cast_on_self = TRUE
	locked = FALSE
	channel_time = 2 SECONDS

/datum/action/cooldown/spell/touch/psionic/mending/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/mendicant)
	if(ishuman(victim))
		var/mob/living/carbon/human/human_victim = victim
		if(issynthetic(human_victim) && cast_power < 2)
			to_chat(owner, span_notice("I dont know how to work with synths."))
			return FALSE
		if(human_victim.can_block_magic(antimagic_flags))
			to_chat(human_victim, span_notice("Psionic nearby tries to mend you."))
		else
			to_chat(human_victim, span_warning(target_msg))
		if(!do_after(mendicant, 5 SECONDS / cast_power, human_victim, IGNORE_SLOWDOWNS, TRUE))
			return FALSE
		else
			try_heal_all(human_victim)
		drain_mana()
		return TRUE
	else
		return FALSE

/datum/action/cooldown/spell/touch/psionic/mending/proc/try_heal_all(mob/living/carbon/human/patient)
	if(patient.all_wounds && cast_power >= 2)
		var/datum/wound/wound2fix = patient.all_wounds[1]
		wound2fix.remove_wound()
		playsound(patient, 'sound/effects/wounds/crack2.ogg', 40, TRUE)

	for(var/obj/item/organ/O in patient.organs)
		O.apply_organ_damage(-15 * cast_power)

	if(patient.get_oxy_loss() >= OXYLOSS_PASSOUT_THRESHOLD-10)
		patient.adjust_oxy_loss(-30 * cast_power, forced = TRUE)

	patient.adjust_tox_loss(-20 * cast_power, forced = TRUE)

	if(patient.get_organ_slot("parasite_egg") && cast_power >= 2) // Удаляем ксеноморфов
		var/obj/item/organ/body_egg/parasite = patient.get_organ_slot("parasite_egg")
		parasite.owner.vomit(VOMIT_CATEGORY_BLOOD | MOB_VOMIT_KNOCKDOWN | MOB_VOMIT_HARM)
		parasite.owner.visible_message(
										span_warning("[patient] twitches, gags and vomits a living creqture with blood! Gross!"),
										span_bolddanger("Suddenly you feel sharp pain in your chest, then something starts moving up your throat. \
														Before you can react somethign slips past your lips with a mix of vomit and blood!"),
									  )
		var/atom/drop_loc = parasite.drop_location()
		parasite.Remove(parasite.owner)
		if(drop_loc)
			parasite.forceMove(drop_loc)

	var/damage_to_heal = 25 * cast_power
	patient.heal_overall_damage(damage_to_heal, damage_to_heal, damage_to_heal)
