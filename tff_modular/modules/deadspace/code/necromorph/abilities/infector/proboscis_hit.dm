/datum/action/cooldown/necro/infector_proboscis
	name = "Proboscis sting"
	desc = "Use your proboscis to attack and infect your victim"
	cooldown_time = 4 SECONDS
	click_to_activate = TRUE
	var/proboscis_damage = 9
	var/necrotoxin_amount = 7

/datum/action/cooldown/necro/infector_proboscis/Trigger(trigger_flags, atom/target)
	var/mob/living/carbon/human/necromorph/infector/holder = owner
	var/obj/item/organ/tongue/necro/proboscis/tongue = holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		to_chat(owner, span_warning("You need your proboscis to use it!"), MESSAGE_TYPE_LOCALCHAT)
		return
	tongue.extend()

	return ..()

/datum/action/cooldown/necro/infector_proboscis/Activate(atom/target)
	. = TRUE
	var/mob/living/carbon/human/necromorph/infector/holder = owner
	if(!isliving(target))
		return
	var/obj/item/organ/tongue/necro/proboscis/tongue = holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		to_chat(owner, span_warning("You have lost your tongue!"), MESSAGE_TYPE_LOCALCHAT)
		return
	tongue.hide()

	. = ..()
	var/mob/living/human = target
	if(human.stat != DEAD)
		holder.inject_necrotoxin(target, necrotoxin_amount)
	else
		holder.play_necro_sound(SOUND_ATTACK, VOLUME_MID, 1, 3)
		if(do_after(holder, 5 SECONDS))
			human.start_necromorph_conversion()

/datum/action/cooldown/necro/infector_proboscis/enhanced
	proboscis_damage = 9
	cooldown_time = 7 SECONDS
	necrotoxin_amount = 14


