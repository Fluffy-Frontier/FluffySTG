//Security skinsuits! This file is for armor vests only

/obj/item/clothing/suit/armor/vest/skinvest
	name = "security skinvest"
	desc = "A slim composite armor vest, oftenly used with skinsuits."
	icon = 'tff_modular/modules/security_skinsuits/icons/obj/skinvests.dmi'
	worn_icon = 'tff_modular/modules/security_skinsuits/icons/mob/skinvests.dmi'
	icon_state = "skinvest_sec"
	worn_icon_state = "skinvest_sec"

/obj/item/clothing/suit/armor/vest/skinvest/equipped(mob/living/affected_mob, slot)
	. = ..()
	var/mob/living/carbon/human/affected_human = affected_mob
	if(src == affected_human.wear_suit)
		if(affected_human.physique == FEMALE)
			worn_icon_state = "[initial(icon_state)]_f" //Это горе но да, у броника тоже фимейл спрайты
		else
			worn_icon_state = "[initial(icon_state)]"

		affected_mob.update_worn_oversuit()

/obj/item/clothing/suit/armor/vest/skinvest/hos
	name = "head of security skinvest"
	desc = "A slim composite armor vest, oftenly used with skinsuits. This one has some gold stripes, and much better protection!"
	icon_state = "skinvest_hos"
	worn_icon_state = "skinvest_hos"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	armor_type = /datum/armor/armor_hos
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS
	strip_delay = 8 SECONDS

/obj/item/clothing/suit/armor/vest/skinvest/ward
	name = "warden skinvest"
	desc = "A slim composite armor vest, oftenly used with skinsuits. This one smells blood and donuts, ugh."
	icon_state = "skinvest_ward"
	worn_icon_state = "skinvest_ward"

/obj/item/clothing/suit/armor/vest/skinvest/orange
	name = "security 'orange' skinvest"
	desc = "A slim composite armor vest, oftenly used with skinsuits. This one has a lot of orange stripes!"
	icon_state = "skinvest_orange"
	worn_icon_state = "skinvest_orange"
