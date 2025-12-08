/datum/quirk/item_quirk/breather/water_breather
	name = "Water Breather"
	desc = "You have a pair of gills and capable of breathing under water."
	alert_text = null
	icon = FA_ICON_FISH
	medical_record_text = "Patient has a pair of gills on their body."
	gain_text = span_notice("You feel that water is your second air.")
	lose_text = span_danger("You feel that water is not your second air anymore")
	value = 0
	breathing_mask = NONE
	breathing_tank = /obj/item/tank/internals/emergency_oxygen/engi
	breath_type = "oxygen"
	mob_trait = TRAIT_WATER_BREATHING

/datum/quirk/item_quirk/breather/water_breather/add_adaptation()
	return

/datum/quirk/item_quirk/breather/water_breather/remove()
	return

/datum/quirk/item_quirk/breather/water_breather/add_unique(client/client_source)
	return

/datum/quirk/item_quirk/breather/water_breather/remove_hydrophobia_action(datum/action/action)
	return

/datum/quirk/item_quirk/breather/water_breather/on_hydrophobia_action_granted(datum/source, datum/action/action)
	return
