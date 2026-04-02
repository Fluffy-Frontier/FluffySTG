/obj/machinery/vending/access/bunny
	name = "\improper Bunny Outfitting Station"
	desc = "A vending machine for specialised clothing for BNNUY."
	product_ads = "Nya style!;Everybody can be bunny!;You have the right to lie and bunny!;What's up doc?"
	icon = 'tff_modular/modules/bunny/icons/obj/vending.dmi'
	icon_state = "bunnydrobe"
	light_mask = "wardrobe-light-mask"
	vend_reply = "Thank you for using the CommDrobe!"
	auto_build_products = TRUE
	payment_department = ACCOUNT_SRV
	refill_canister = /obj/item/vending_refill/wardrobe/bunny
	light_color = COLOR_SERVICE_LIME
	allow_custom = TRUE

/obj/item/vending_refill/wardrobe/bunny
	machine_name = "Bunny Outfitting Station"

/obj/machinery/vending/access/bunny/build_access_list(list/access_lists)
	// Command
	access_lists["[ACCESS_CAPTAIN]"] = list(
		/obj/item/clothing/under/rank/captain/bunnysuit = 3,
		/obj/item/clothing/suit/armor/vest/capcarapace/tailcoat_captain = 3,
		/obj/item/clothing/neck/bunny/bunnytie/captain = 3,
		/obj/item/clothing/head/hats/caphat/bunnyears_captain = 3,
	)
	access_lists["[ACCESS_HOP]"] = list(
		/obj/item/clothing/under/rank/civilian/hop_bunnysuit = 3,
		/obj/item/clothing/suit/armor/hop_tailcoat = 3,
		/obj/item/clothing/neck/bunny/bunnytie/hop = 3,
		/obj/item/clothing/head/playbunnyears/hop = 3,
	)
	access_lists["[ACCESS_CMO]"] = list(
		/obj/item/clothing/under/rank/medical/cmo_bunnysuit = 3,
		/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/cmo = 3,
		/obj/item/clothing/neck/bunny/bunnytie/cmo = 3,
		/obj/item/clothing/head/playbunnyears/cmo = 3,
	)
	access_lists["[ACCESS_RD]"] = list(
		/obj/item/clothing/under/rank/rnd/research_director/bunnysuit = 3,
		/obj/item/clothing/suit/jacket/research_director/tailcoat = 3,
		/obj/item/clothing/neck/bunny/bunnytie/rd = 3,
		/obj/item/clothing/head/playbunnyears/rd = 3,
	)
	access_lists["[ACCESS_CE]"] = list(
		/obj/item/clothing/under/rank/engineering/chief_engineer/bunnysuit = 3,
		/obj/item/clothing/suit/utility/fire/ce_tailcoat = 3,
		/obj/item/clothing/neck/bunny/bunnytie/ce = 3,
		/obj/item/clothing/head/playbunnyears/ce = 3,
	)
	access_lists["[ACCESS_HOS]"] = list(
		/obj/item/clothing/under/rank/security/head_of_security/bunnysuit = 3,
		/obj/item/clothing/suit/armor/hos_tailcoat = 3,
		/obj/item/clothing/neck/bunny/bunnytie/security = 3,
		/obj/item/clothing/head/playbunnyears/hos = 3,
	)
	access_lists["[ACCESS_QM]"] = list(
		/obj/item/clothing/under/rank/cargo/quartermaster_bunnysuit = 3,
		/obj/item/clothing/suit/jacket/tailcoat/quartermaster = 3,
		/obj/item/clothing/neck/bunny/bunnytie/cargo = 3,
		/obj/item/clothing/head/playbunnyears/quartermaster = 3,
	)
	access_lists["[ACCESS_CENT_GENERAL]"] = list(
		/obj/item/clothing/under/costume/playbunny/centcom = 3,
		/obj/item/clothing/suit/armor/security_tailcoat/centcom = 3,
		/obj/item/clothing/neck/bunny/bunnytie/centcom = 3,
		/obj/item/clothing/head/playbunnyears/centcom = 3,
	)
	access_lists["[ACCESS_COMMAND]"] = list(
		/obj/item/clothing/shoes/fancy_heels/cc = 3,
		/obj/item/clothing/shoes/fancy_heels/red = 3,
		/obj/item/clothing/shoes/fancy_heels/blue = 3,
		/obj/item/clothing/shoes/fancy_heels/lightgrey = 3,
		/obj/item/clothing/shoes/fancy_heels/navyblue = 3,
		/obj/item/clothing/shoes/fancy_heels/white = 3,
		/obj/item/clothing/shoes/fancy_heels/darkblue = 3,
		/obj/item/clothing/shoes/fancy_heels/black = 3,
		/obj/item/clothing/shoes/fancy_heels/purple = 3,
		/obj/item/clothing/shoes/fancy_heels/red = 3,
		/obj/item/clothing/shoes/fancy_heels/grey = 3,
		/obj/item/clothing/shoes/fancy_heels/brown = 3,
		/obj/item/clothing/shoes/fancy_heels/orange = 3,
		/obj/item/clothing/shoes/jackboots/gogo_boots = 3,
		/obj/item/clothing/shoes/fancy_heels/lightblue = 3,
		/obj/item/clothing/shoes/galoshes/heeled = 3,
		/obj/item/clothing/shoes/fancy_heels/green = 3,
		/obj/item/clothing/shoes/clown_shoes/heeled = 3,
		/obj/item/clothing/shoes/fancy_heels/darkgreen = 3,
		/obj/item/clothing/shoes/fancy_heels/teal = 3,
		/obj/item/clothing/shoes/fancy_heels/mutedblack = 3,
		/obj/item/clothing/shoes/fancy_heels/mutedblue = 3,
		/obj/item/clothing/shoes/fancy_heels/beige = 3,
		/obj/item/clothing/shoes/fancy_heels/darkgrey = 3,
	)
