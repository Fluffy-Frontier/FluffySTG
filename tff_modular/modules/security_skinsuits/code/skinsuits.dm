//Security skinsuits! This file is for uniform only

/obj/item/clothing/under/rank/security/skinsuit_n
	name = "security skinsuit"
	desc = "A black security skinsuit that covers almost whole body, featuring high collar. Also, made of fireproof materials!"
	icon = 'tff_modular/modules/security_skinsuits/icons/obj/skinsuits.dmi'
	icon_state = "skinsuit"
	worn_icon_state = "skinsuit"
	worn_icon = 'tff_modular/modules/security_skinsuits/icons/mob/skinsuits.dmi'
	worn_icon_digi = 'tff_modular/modules/security_skinsuits/icons/mob/skinsuits_digi.dmi'
	alternate_worn_layer = GLOVES_LAYER //Идёт поверх перчаток
	body_parts_covered = CHEST|GROIN|LEGS|FEET|HANDS
	female_sprite_flags = NO_FEMALE_UNIFORM //Отдельные спрайты под фимейлов, дап-дап
	resistance_flags = FIRE_PROOF

/obj/item/clothing/under/rank/security/skinsuit_n/equipped(mob/living/affected_mob, slot)
	. = ..()
	var/mob/living/carbon/human/affected_human = affected_mob
	if(src == affected_human.w_uniform)
		if(affected_human.physique == FEMALE)
			worn_icon_state = "[initial(worn_icon_state)]_f"
		else
			worn_icon_state = "[initial(worn_icon_state)]"

		affected_mob.update_worn_undersuit()

/obj/item/clothing/under/rank/security/skinsuit_n/hos
	name = "head of security skinsuit"
	desc = "A black security skinsuit that covers almost whole body, featuring high collar. Also, made of fireproof materials! This one has some gold stripes, and a little bit more comfortable."
	icon_state = "skinsuit_hos"
	worn_icon_state = "skinsuit_hos"

/obj/item/clothing/under/rank/security/skinsuit_n/ward
	name = "warden skinsuit"
	desc = "A black security skinsuit that covers almost whole body, featuring high collar. Also, made of fireproof materials! This one has some silver stripes, and smells blood and donuts, huh..."
	icon_state = "skinsuit_ward"
	worn_icon_state = "skinsuit_ward"

/obj/item/clothing/under/rank/security/skinsuit_n/orange
	name = "security 'orange' skinsuit"
	desc = "A black security skinsuit that covers almost whole body, featuring high collar. Also, made of fireproof materials! This one has a lot of orange stripes!"
	icon_state = "skinsuit_orange"
	worn_icon_state = "skinsuit_orange"
