
/obj/item/organ/proboscis
	name = "proboscis"
	zone = BODY_ZONE_HEAD
	//icon = 'tff_modular/modules/deadspace/icons/'
	//icon_state = "proboscis"
	slot = ORGAN_SLOT_PROBOSCIS
	var/retracted = TRUE

/datum/action/cooldown/necro/infector_proboscis
	name = "Proboscis sting"
	desc = "Use your proboscis to attack and infect your victim"
	cooldown_time = 4 SECONDS
	click_to_activate = TRUE
	var/proboscis_damage = 9
	var/necrotoxin_amount = 7

/datum/action/cooldown/necro/infector_proboscis/Activate(atom/target)
	. = TRUE
	var/mob/living/carbon/human/necromorph/infector/holder = owner
	if(!isliving(target))
		return
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


