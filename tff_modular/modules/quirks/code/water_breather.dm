/datum/quirk/item_quirk/breather/water_breather
	name = "Water Breather"
	alert_text = null
	gain_text = span_notice("You feel that water is your second air.")
	lose_text = span_danger("You feel that water is not your second air anymore")
	breathing_tank = /obj/item/tank/internals/emergency_oxygen
	breath_type = "oxygen"
	mob_trait = TRAIT_WATER_BREATHING

/datum/quirk/item_quirk/breather/water_breather/add_adaptation()
	return

/datum/quirk/item_quirk/breather/water_breather/remove()
	return

/datum/quirk/item_quirk/breather/water_breather/add_unique(client/client_source)
	return
