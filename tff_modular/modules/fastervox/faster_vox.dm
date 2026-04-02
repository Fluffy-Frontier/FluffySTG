/obj/item/organ/brain/cybernetic/cortical/vox/on_mob_insert(mob/living/carbon/human/brain_owner, special, movement_flags)
	. = ..()
	var/mob/living/carbon/human/vox = brain_owner
	vox.add_actionspeed_modifier(/datum/actionspeed_modifier/vox)

/obj/item/organ/brain/cybernetic/cortical/vox/on_mob_remove(mob/living/carbon/human/brain_owner, special)
	. = ..()
	var/mob/living/carbon/human/vox = brain_owner
	vox.remove_actionspeed_modifier(/datum/actionspeed_modifier/vox)

/datum/actionspeed_modifier/vox
	multiplicative_slowdown = -0.1
