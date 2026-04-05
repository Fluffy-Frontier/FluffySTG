/// TGMC_XENOS (old nova sector xenos)

#define TGMC_ALIEN_BODYPART_BURN_MODIFIER 1.5


/obj/item/bodypart/head/alien/tgmc
	burn_modifier = TGMC_ALIEN_BODYPART_BURN_MODIFIER

/obj/item/bodypart/chest/alien/tgmc
	burn_modifier = TGMC_ALIEN_BODYPART_BURN_MODIFIER

/obj/item/bodypart/arm/left/alien/tgmc
	burn_modifier = TGMC_ALIEN_BODYPART_BURN_MODIFIER

/obj/item/bodypart/arm/right/alien/tgmc
	burn_modifier = TGMC_ALIEN_BODYPART_BURN_MODIFIER

/obj/item/bodypart/leg/left/alien/tgmc
	burn_modifier = TGMC_ALIEN_BODYPART_BURN_MODIFIER

/obj/item/bodypart/leg/right/alien/tgmc
	burn_modifier = TGMC_ALIEN_BODYPART_BURN_MODIFIER


/mob/living/carbon/alien/adult/tgmc/newBodyPart(zone)
	var/obj/item/bodypart/new_bodypart
	switch(zone)
		if(BODY_ZONE_L_ARM)
			new_bodypart = new /obj/item/bodypart/arm/left/alien/tgmc()
		if(BODY_ZONE_R_ARM)
			new_bodypart = new /obj/item/bodypart/arm/right/alien/tgmc()
		if(BODY_ZONE_HEAD)
			new_bodypart = new /obj/item/bodypart/head/alien/tgmc()
		if(BODY_ZONE_L_LEG)
			new_bodypart = new /obj/item/bodypart/leg/left/alien/tgmc()
		if(BODY_ZONE_R_LEG)
			new_bodypart = new /obj/item/bodypart/leg/right/alien/tgmc()
		if(BODY_ZONE_CHEST)
			new_bodypart = new /obj/item/bodypart/chest/alien/tgmc()
	if(new_bodypart)
		new_bodypart.update_limb(is_creating = TRUE)


#undef TGMC_ALIEN_BODYPART_BURN_MODIFIER
