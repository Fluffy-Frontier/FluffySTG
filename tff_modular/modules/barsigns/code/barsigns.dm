// Modularly copypaste-set the correct icon file
/obj/machinery/barsign/update_icon_state()
	. = ..()
	// Try to use TFF override
	if(istype(chosen_sign, /datum/barsign/fluffy))
		icon = TFF_BARSIGN_FILE
		return

/datum/barsign/fluffy/thelastlight
	name = "The Last Light"
	icon_state = "lastlight"
	neon_color = "#EBB823"

/datum/barsign/fluffy/afterlife
	name = "After Life"
	icon_state = "afterlife"
	neon_color = "#3bfa74"
