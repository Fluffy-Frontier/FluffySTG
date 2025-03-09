/obj/structure/closet/supplypod/syndicate_cargo
	name = "Syndicate cargo pod"
	desc = "A Syndicate drop pod, used for supply deliveries to remote outposts."
	style = /datum/pod_style/syndicate
	bluespace = TRUE
	explosionSize = list(0,0,1,2)

/obj/machinery/computer/cargo/express/interdyne
	pod_type = /obj/structure/closet/supplypod/syndicate_cargo

/obj/machinery/computer/cargo/express/interdyne/ui_act(action, params, datum/tgui/ui)
	if(action == "add") // if we're generating a supply order
		if (!beacon || !using_beacon ) // checks if using a beacon or not.
			say("Error! Destination is not whitelisted, aborting.")
			return
		var/id = params["id"]
		id = text2path(id) || id
		var/datum/supply_pack/is_supply_pack = SSshuttle.supply_packs[id]
		if(!is_supply_pack || !istype(is_supply_pack)) //if we're ordering a company import pack, add a temp pack to the global supply packs list, and remove it
			var/datum/armament_entry/armament_order = locate(id)
			params["id"] = length(SSshuttle.supply_packs) + 1
			var/datum/supply_pack/armament/temp_pack = new
			temp_pack.name = initial(armament_order.item_type.name)
			temp_pack.cost = armament_order.cost
			temp_pack.contains = list(armament_order.item_type)
			temp_pack.crate_type = /obj/structure/closet/crate/secure/syndicate/cybersun/night
			temp_pack.access = ACCESS_SYNDICATE
			SSshuttle.supply_packs += temp_pack
			. = ..()
			SSshuttle.supply_packs -= temp_pack
			return
		else
			var/datum/supply_pack/temp_pack = is_supply_pack
			switch(temp_pack.group)
				if("Medical")  temp_pack.crate_type = /obj/structure/closet/crate/secure/syndicate/interdyne
				if("Canisters & Materials")  temp_pack.crate_type = /obj/structure/closet/crate/secure/syndicate/tiger
				if("Livestock")  temp_pack.crate_type = /obj/structure/closet/crate/critter
				if("Vending Restocks")  temp_pack.crate_type = /obj/structure/closet/crate/secure/syndicate/self
				if("Food & Hydroponics")  temp_pack.crate_type = /obj/structure/closet/crate/secure/syndicate/arc
				if("Miscellaneous Supplies")  temp_pack.crate_type = /obj/structure/closet/crate/secure/syndicate/cybersun/dawn
				if("Engineering")  temp_pack.crate_type = /obj/structure/closet/crate/secure/syndicate/cybersun/noon
				if("Science")  temp_pack.crate_type = /obj/structure/closet/crate/secure/syndicate/cybersun/dusk
				if("Service") temp_pack.crate_type = /obj/structure/closet/crate/secure/syndicate/wafflecorp
				if("Security") temp_pack.crate_type = /obj/structure/closet/crate/secure/syndicate/gorlex
				else  temp_pack.crate_type = /obj/structure/closet/crate/secure/syndicate
			temp_pack.access = ACCESS_SYNDICATE
			SSshuttle.supply_packs += temp_pack
			. = ..()
			SSshuttle.supply_packs -= temp_pack
			return
	return ..()
