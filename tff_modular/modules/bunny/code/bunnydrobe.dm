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
		/obj/item/clothing/under/rank/captain/bunnysuit = 3,
		/obj/item/clothing/suit/armor/vest/capcarapace/tailcoat_captain = 3,
		/obj/item/clothing/neck/bunny/bunnytie/captain = 3,
		/obj/item/clothing/head/hats/caphat/bunnyears_captain = 3,
	)
	// Service
	access_lists["[ACCESS_SERVICE]"] = list(
		/obj/item/clothing/under/rank/civilian/janitor/bunnysuit = 3,
		/obj/item/clothing/under/rank/civilian/bartender_bunnysuit = 3,
		/obj/item/clothing/under/rank/civilian/cook_bunnysuit = 3,
		/obj/item/clothing/under/rank/civilian/clown/clown_bunnysuit = 3,
		/obj/item/clothing/under/rank/civilian/mime_bunnysuit = 3,
		/obj/item/clothing/under/rank/civilian/chaplain_bunnysuit = 3,
		/obj/item/clothing/under/rank/civilian/curator_bunnysuit_red = 3,
		/obj/item/clothing/under/rank/civilian/curator_bunnysuit_green = 3,
		/obj/item/clothing/under/rank/civilian/curator_bunnysuit_teal = 3,
		/obj/item/clothing/under/rank/civilian/lawyer_bunnysuit_black = 3,
		/obj/item/clothing/under/rank/civilian/lawyer_bunnysuit_blue = 3,
		/obj/item/clothing/under/rank/civilian/lawyer_bunnysuit_red = 3,
		/obj/item/clothing/under/rank/civilian/lawyer_bunnysuit_good = 3,
		/obj/item/clothing/under/rank/civilian/psychologist_bunnysuit = 3,
		/obj/item/clothing/suit/jacket/tailcoat/janitor = 3,
		/obj/item/clothing/suit/jacket/tailcoat/cook = 3,
		/obj/item/clothing/suit/jacket/tailcoat/botanist = 3,
		/obj/item/clothing/suit/jacket/tailcoat/clown = 3,
		/obj/item/clothing/suit/jacket/tailcoat/mime = 3,
		/obj/item/clothing/suit/jacket/tailcoat/chaplain = 3,
		/obj/item/clothing/suit/jacket/tailcoat/curator_red = 3,
		/obj/item/clothing/suit/jacket/tailcoat/curator_green = 3,
		/obj/item/clothing/suit/jacket/tailcoat/curator_teal = 3,
		/obj/item/clothing/suit/jacket/tailcoat/lawyer_black = 3,
		/obj/item/clothing/suit/jacket/tailcoat/lawyer_blue = 3,
		/obj/item/clothing/suit/jacket/tailcoat/lawyer_red = 3,
		/obj/item/clothing/suit/jacket/tailcoat/lawyer_good = 3,
		/obj/item/clothing/suit/jacket/tailcoat/psychologist = 3,
		/obj/item/clothing/neck/bunny/bunnytie/janitor = 3,
		/obj/item/clothing/neck/bunny/bunnytie/bartender = 3,
		/obj/item/clothing/neck/bunny/bunnytie/cook = 3,
		/obj/item/clothing/neck/bunny/bunnytie/botanist = 3,
		/obj/item/clothing/neck/bunny/clown = 3,
		/obj/item/clothing/neck/bunny_pendant = 3,
		/obj/item/clothing/neck/bunny/bunnytie/lawyer_black = 3,
		/obj/item/clothing/neck/bunny/bunnytie/lawyer_blue = 3,
		/obj/item/clothing/neck/bunny/bunnytie/lawyer_red = 3,
		/obj/item/clothing/neck/bunny/bunnytie/lawyer_good = 3,
		/obj/item/clothing/head/playbunnyears/janitor = 3,
		/obj/item/clothing/head/playbunnyears/bartender = 3,
		/obj/item/clothing/head/playbunnyears/cook = 3,
		/obj/item/clothing/head/playbunnyears/botanist = 3,
		/obj/item/clothing/head/playbunnyears/clown = 3,
		/obj/item/clothing/head/playbunnyears/mime = 3,
		/obj/item/clothing/head/playbunnyears/chaplain = 3,
		/obj/item/clothing/head/playbunnyears/curator_red = 3,
		/obj/item/clothing/head/playbunnyears/curator_green = 3,
		/obj/item/clothing/head/playbunnyears/curator_teal = 3,
		/obj/item/clothing/head/playbunnyears/lawyer_black = 3,
		/obj/item/clothing/head/playbunnyears/lawyer_blue = 3,
		/obj/item/clothing/head/playbunnyears/lawyer_red = 3,
		/obj/item/clothing/head/playbunnyears/lawyer_good = 3,
		/obj/item/clothing/head/playbunnyears/psychologist = 3,
	)
	// Cargo
	access_lists["[ACCESS_CARGO]"] = list(
		/obj/item/clothing/under/rank/cargo/cargo_bunnysuit = 3,
		/obj/item/clothing/under/rank/cargo/miner/bunnysuit = 3,
		/obj/item/clothing/under/rank/cargo/mailman_bunnysuit = 3,
		/obj/item/clothing/under/rank/cargo/bitrunner/bunnysuit = 3,
		/obj/item/clothing/suit/jacket/tailcoat/cargo = 3,
		/obj/item/clothing/suit/jacket/tailcoat/miner = 3,
		/obj/item/clothing/suit/jacket/tailcoat/bitrunner = 3,
		/obj/item/clothing/neck/bunny/bunnytie/cargo = 3,
		/obj/item/clothing/neck/bunny/bunnytie/miner = 3,
		/obj/item/clothing/neck/bunny/bunnytie/mailman = 3,
		/obj/item/clothing/neck/bunny/bunnytie/bitrunner = 3,
		/obj/item/clothing/head/playbunnyears/cargo = 3,
		/obj/item/clothing/head/playbunnyears/miner = 3,
		/obj/item/clothing/head/playbunnyears/mailman = 3,
		/obj/item/clothing/head/playbunnyears/bitrunner = 3,
		/obj/item/clothing/shoes/workboots/mining/heeled = 3,
	)
	// Science
	access_lists["[ACCESS_SCIENCE]"] = list(
		/obj/item/clothing/under/rank/rnd/scientist/bunnysuit = 3,
		/obj/item/clothing/under/rank/rnd/scientist/roboticist_bunnysuit = 3,
		/obj/item/clothing/under/rank/rnd/geneticist/bunnysuit = 3,
		/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/science = 3,
		/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/science/robotics = 3,
		/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/science/genetics = 3,
		/obj/item/clothing/neck/bunny/bunnytie/scientist = 3,
		/obj/item/clothing/neck/bunny/bunnytie/roboticist = 3,
		/obj/item/clothing/neck/bunny/bunnytie/geneticist = 3,
		/obj/item/clothing/head/playbunnyears/scientist = 3,
		/obj/item/clothing/head/playbunnyears/roboticist = 3,
		/obj/item/clothing/head/playbunnyears/geneticist = 3,
	)
	// Security
	access_lists["[ACCESS_SECURITY]"] = list(
		/obj/item/clothing/under/rank/security/security_bunnysuit = 3,
		/obj/item/clothing/under/rank/security/security_assistant_bunnysuit = 3,
		/obj/item/clothing/under/rank/security/warden_bunnysuit = 3,
		/obj/item/clothing/under/rank/security/brig_phys_bunnysuit = 3,
		/obj/item/clothing/under/rank/security/detective_bunnysuit = 3,
		/obj/item/clothing/under/rank/security/prisoner_bunnysuit = 3,
		/obj/item/clothing/suit/armor/security_tailcoat = 3,
		/obj/item/clothing/suit/armor/security_tailcoat/assistant = 3,
		/obj/item/clothing/suit/armor/security_tailcoat/warden = 3,
		/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/sec = 3,
		/obj/item/clothing/suit/jacket/det_suit/tailcoat = 3,
		/obj/item/clothing/suit/jacket/det_suit/tailcoat/noir = 3,
		/obj/item/clothing/neck/bunny/bunnytie/security = 3,
		/obj/item/clothing/neck/bunny/bunnytie/security_assistant = 3,
		/obj/item/clothing/neck/bunny/bunnytie/brig_phys = 3,
		/obj/item/clothing/neck/bunny/bunnytie/detective = 3,
		/obj/item/clothing/neck/bunny/bunnytie/prisoner = 3,
		/obj/item/clothing/head/playbunnyears/security = 3,
		/obj/item/clothing/head/playbunnyears/security/assistant = 3,
		/obj/item/clothing/head/playbunnyears/warden = 3,
		/obj/item/clothing/head/playbunnyears/brig_phys = 3,
		/obj/item/clothing/head/playbunnyears/detective = 3,
		/obj/item/clothing/head/playbunnyears/detective/noir = 3,
		/obj/item/clothing/head/playbunnyears/prisoner = 3,
	)
	// Medbay
	access_lists["[ACCESS_MEDICAL]"] = list(
		/obj/item/clothing/under/rank/medical/doctor_bunnysuit = 3,
		/obj/item/clothing/under/rank/medical/paramedic_bunnysuit = 3,
		/obj/item/clothing/under/rank/medical/chemist/bunnysuit = 3,
		/obj/item/clothing/under/rank/medical/pathologist_bunnysuit = 3,
		/obj/item/clothing/under/rank/medical/coroner_bunnysuit = 3,
		/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat = 3,
		/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/paramedic = 3,
		/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/chemist = 3,
		/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/pathologist = 3,
		/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/coroner = 3,
		/obj/item/clothing/neck/bunny/bunnytie/doctor = 3,
		/obj/item/clothing/neck/bunny/bunnytie/paramedic = 3,
		/obj/item/clothing/neck/bunny/bunnytie/chemist = 3,
		/obj/item/clothing/neck/bunny/bunnytie/pathologist = 3,
		/obj/item/clothing/neck/bunny/bunnytie/coroner = 3,
		/obj/item/clothing/head/playbunnyears/doctor = 3,
		/obj/item/clothing/head/playbunnyears/paramedic = 3,
		/obj/item/clothing/head/playbunnyears/chemist = 3,
		/obj/item/clothing/head/playbunnyears/pathologist = 3,
		/obj/item/clothing/head/playbunnyears/coroner = 3,
	)
	// Engineering
	access_lists["[ACCESS_ENGINEERING]"] = list(
		/obj/item/clothing/under/rank/medical/doctor_bunnysuit = 3,
		/obj/item/clothing/under/rank/medical/paramedic_bunnysuit = 3,
		/obj/item/clothing/under/rank/medical/chemist/bunnysuit = 3,
		/obj/item/clothing/under/rank/medical/pathologist_bunnysuit = 3,
		/obj/item/clothing/under/rank/medical/coroner_bunnysuit = 3,
		/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat = 3,
		/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/paramedic = 3,
		/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/chemist = 3,
		/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/pathologist = 3,
		/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/coroner = 3,
		/obj/item/clothing/neck/bunny/bunnytie/doctor = 3,
		/obj/item/clothing/neck/bunny/bunnytie/paramedic = 3,
		/obj/item/clothing/neck/bunny/bunnytie/chemist = 3,
		/obj/item/clothing/neck/bunny/bunnytie/pathologist = 3,
		/obj/item/clothing/neck/bunny/bunnytie/coroner = 3,
		/obj/item/clothing/head/playbunnyears/doctor = 3,
		/obj/item/clothing/head/playbunnyears/paramedic = 3,
		/obj/item/clothing/head/playbunnyears/chemist = 3,
		/obj/item/clothing/head/playbunnyears/pathologist = 3,
		/obj/item/clothing/head/playbunnyears/coroner = 3,
	)
	// Assistant
	access_lists["[ACCESS_MAINT_TUNNELS]"] = list(
		/obj/item/clothing/under/costume/playbunny = 3,
		/obj/item/clothing/under/costume/playbunny/british = 3,
		/obj/item/clothing/under/costume/playbunny/communist = 3,
		/obj/item/clothing/under/costume/playbunny/usa = 3,
		/obj/item/clothing/suit/jacket/tailcoat = 3,
		/obj/item/clothing/neck/bunny/bunnytie = 3,
		/obj/item/clothing/neck/bunny/bunnytie/communist = 3,
		/obj/item/clothing/neck/bunny/bunnytie/blue = 3,
		/obj/item/clothing/head/playbunnyears = 3,
		/obj/item/clothing/head/playbunnyears/british = 3,
		/obj/item/clothing/head/playbunnyears/communist = 3,
		/obj/item/clothing/head/playbunnyears/usa = 3,
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

