/datum/uplink_item/explosives/detomatix
	name = "Detomatix disk"
	desc = "When inserted into a tablet, this cartridge gives you four opportunities to \
			detonate tablets of crewmembers who have their message feature enabled. \
			The concussive effect from the explosion will knock the recipient out for a short period, and deafen them for longer."
	item = /obj/item/computer_disk/virus/detomatix
	cost = /datum/uplink_item/low_cost/explosive::cost
	limited_stock = 1
	restricted = TRUE

// TFF override for EMP cost
/datum/uplink_item/explosives/emp
	cost = /datum/uplink_item/low_cost/explosive::cost

