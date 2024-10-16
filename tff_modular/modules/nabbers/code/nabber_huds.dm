#define NABBER_HUD_Y_SHIFT 12

/mob/living/carbon/human/species/nabber/med_hud_set_status()
	. = ..()
	var/image/holder = hud_list?[STATUS_HUD]
	if (isnull(holder))
		return
	holder.pixel_y += NABBER_HUD_Y_SHIFT

/mob/living/carbon/human/species/nabber/med_hud_set_health()
	. = ..()
	var/image/holder = hud_list?[HEALTH_HUD]
	if (isnull(holder))
		return
	holder.pixel_y += NABBER_HUD_Y_SHIFT

/mob/living/carbon/human/species/nabber/sec_hud_set_ID()
	. = ..()
	var/image/holder = hud_list[ID_HUD]
	if (isnull(holder))
		return
	holder.pixel_y += NABBER_HUD_Y_SHIFT
	var/image/permit_holder = hud_list[PERMIT_HUD]
	if (isnull(permit_holder))
		return
	permit_holder.pixel_y += NABBER_HUD_Y_SHIFT

/mob/living/carbon/human/species/nabber/sec_hud_set_security_status()
	. = ..()
	var/image/holder = hud_list[WANTED_HUD]
	if (isnull(holder))
		return
	holder.pixel_y += NABBER_HUD_Y_SHIFT

/mob/living/carbon/human/species/nabber/sec_hud_set_implants()
	. = ..()
	var/image/holder
	for(var/i in (list(IMPSEC_FIRST_HUD, IMPLOYAL_HUD, IMPSEC_SECOND_HUD) & hud_list))
		holder = hud_list[i]
		if(isnull(holder))
			return
		holder.pixel_y += NABBER_HUD_Y_SHIFT

/mob/living/carbon/human/med_hud_set_status()
	. = ..()
	if(isnabber(src))
		var/image/holder = hud_list?[STATUS_HUD]
		if (isnull(holder))
			return
		holder.pixel_y += NABBER_HUD_Y_SHIFT

/mob/living/carbon/human/med_hud_set_health()
	. = ..()
	if(isnabber(src))
		var/image/holder = hud_list?[HEALTH_HUD]
		if (isnull(holder))
			return
		holder.pixel_y += NABBER_HUD_Y_SHIFT

/mob/living/carbon/human/sec_hud_set_ID()
	. = ..()
	if(isnabber(src))
		var/image/holder = hud_list[ID_HUD]
		if (isnull(holder))
			return
		holder.pixel_y += NABBER_HUD_Y_SHIFT
		var/image/permit_holder = hud_list[PERMIT_HUD]
		if (isnull(permit_holder))
			return
		permit_holder.pixel_y += NABBER_HUD_Y_SHIFT

/mob/living/carbon/human/sec_hud_set_security_status()
	. = ..()
	if(isnabber(src))
		var/image/holder = hud_list[WANTED_HUD]
		if (isnull(holder))
			return
		holder.pixel_y += NABBER_HUD_Y_SHIFT

/mob/living/carbon/human/sec_hud_set_implants()
	. = ..()
	if(isnabber(src))
		var/image/holder
		for(var/i in (list(IMPSEC_FIRST_HUD, IMPLOYAL_HUD, IMPSEC_SECOND_HUD) & hud_list))
			holder = hud_list[i]
			if(isnull(holder))
				return
			holder.pixel_y += NABBER_HUD_Y_SHIFT

#undef NABBER_HUD_Y_SHIFT
