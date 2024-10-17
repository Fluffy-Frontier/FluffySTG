/datum/armament_entry/company_import/nri_surplus/clothing/space_suit
	item_type = /obj/item/clothing/suit/space/voskhod
	cost = PAYCHECK_COMMAND*3
	name = "Voskhod armor Crate"
	desc = "A single kit of NRI armored space suit."
	cost = CARGO_CRATE_VALUE * 2.5
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/clothing/suit/space/voskhod = 1,
					/obj/item/clothing/head/helmet/space/voskhod = 1,
				)
	crate_name = "Voskhod armor Crate"
