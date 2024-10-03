/obj/machinery/vending/access/playbunny
	name = "\improper Bunny Outfitting Station"
	desc = "A vending machine for specialised clothing for BNNUY."
	product_ads = "Nya style!;Everybody can be bunny!;You have the right to lie and bunny!;What's up doc?"
	icon = 'tff_modular/modules/bunny/icons/obj/vending.dmi'
	icon_state = "bunnydrobe"
	light_mask = "wardrobe-light-mask"
	vend_reply = "Thank you for using the CommDrobe!"
	auto_build_products = TRUE
	payment_department = ACCOUNT_SRV
	refill_canister = /obj/item/vending_refill/wardrobe/playbunny
	light_color = COLOR_SERVICE_LIME

/obj/item/vending_refill/wardrobe/playbunny
	machine_name = "Bunny Outfitting Station"

/obj/machinery/vending/access/playbunny/build_access_list(list/access_lists)
	// Command
	access_lists["[ACCESS_CAPTAIN]"] = list(
		/obj/item/clothing/under/costume/playbunny/captain = 3,
		/obj/item/clothing/suit/jacket/playbunny/captain = 3,
		/obj/item/clothing/neck/playbunny/captain = 3,
		/obj/item/clothing/head/playbunny/captain = 3,
	)
	access_lists["[ACCESS_HOP]"] = list(
		/obj/item/clothing/under/costume/playbunny/hop = 3,
		/obj/item/clothing/suit/jacket/playbunny/hop = 3,
		/obj/item/clothing/neck/playbunny/hop = 3,
		/obj/item/clothing/head/playbunny/hop = 3,
	)
	access_lists["[ACCESS_CMO]"] = list(
		/obj/item/clothing/under/costume/playbunny/cmo = 3,
		/obj/item/clothing/suit/toggle/labcoat/playbunny/cmo = 3,
		/obj/item/clothing/neck/playbunny/cmo = 3,
		/obj/item/clothing/head/playbunny/cmo = 3,
	)
	access_lists["[ACCESS_RD]"] = list(
		/obj/item/clothing/under/costume/playbunny/rd = 3,
		/obj/item/clothing/suit/jacket/playbunny/rd = 3,
		/obj/item/clothing/neck/playbunny/rd = 3,
		/obj/item/clothing/head/playbunny/rd = 3,
	)
	access_lists["[ACCESS_CE]"] = list(
		/obj/item/clothing/under/costume/playbunny/ce = 3,
		/obj/item/clothing/suit/jacket/playbunny/ce = 3,
		/obj/item/clothing/neck/playbunny/ce = 3,
		/obj/item/clothing/head/playbunny/ce = 3,
	)
	access_lists["[ACCESS_HOS]"] = list(
		/obj/item/clothing/under/costume/playbunny/hos = 3,
		/obj/item/clothing/suit/jacket/playbunny/security_tailcoat/hos = 3,
		/obj/item/clothing/neck/playbunny/security = 3,
		/obj/item/clothing/head/playbunny/hos = 3,
	)
	access_lists["[ACCESS_QM]"] = list(
		/obj/item/clothing/under/costume/playbunny/qm = 3,
		/obj/item/clothing/suit/jacket/playbunny/qm = 3,
		/obj/item/clothing/neck/playbunny/cargo = 3,
		/obj/item/clothing/head/playbunny/qm = 3,
	)
	access_lists["[ACCESS_CENT_GENERAL]"] = list(
		/obj/item/clothing/under/costume/playbunny/centcom = 3,
		/obj/item/clothing/suit/jacket/playbunny/security_tailcoat/centcom = 3,
		/obj/item/clothing/neck/playbunny/centcom = 3,
		/obj/item/clothing/head/playbunny/centcom = 3,
	)
