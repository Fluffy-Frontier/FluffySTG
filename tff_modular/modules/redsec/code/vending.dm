/obj/machinery/vending/wardrobe/uni_sec_wardrobe
	name = "\improper MultiSec Drobe"
	desc = "A vending machine for security and security-related clothing!"
	product_ads = "Beat perps in style!;It's red and blue so you can't distinguish blood and water!;You have the right to be fashionable!;Now you can be the fashion police you always wanted to be!"
	icon = 'tff_modular/modules/redsec/icons/obj/vending.dmi'
	icon_state = "secdrobe"
	product_categories = list(
		list(
			"name" = "RedSec",
			"icon" = "hat-cowboy",
			"products" = list(
					/obj/item/clothing/suit/hooded/wintercoat/security/redsec = 5,
					/obj/item/storage/belt/security/redsec = 5,
					/obj/item/storage/backpack/security/redsec = 5,
					/obj/item/storage/backpack/satchel/sec/redsec = 5,
					/obj/item/storage/backpack/duffelbag/sec/redsec = 5,
					/obj/item/clothing/under/rank/security/officer/redsec = 5,
					/obj/item/clothing/shoes/jackboots/sec/redsec = 5,
					/obj/item/clothing/head/beret/sec = 5,
					/obj/item/clothing/head/soft/sec = 5,
					/obj/item/clothing/mask/bandana/red = 5,
					/obj/item/clothing/glasses/hud/security/redsec = 5,
					/obj/item/clothing/gloves/color/black = 5,
					/obj/item/clothing/under/rank/security/officer/skirt = 5,
					/obj/item/clothing/under/rank/security/skyrat/utility/redsec = 5,
					/obj/item/clothing/suit/toggle/jacket/sec/old = 5,
					/obj/item/clothing/suit/armor/vest/alt/sec/redsec = 2
			),
		),

		list(
			"name" = "BlueSec",
			"icon" = "user-tie",
			"products" = list(
					/obj/item/clothing/suit/hooded/wintercoat/security = 5,
					/obj/item/clothing/suit/toggle/jacket/sec = 5,
					/obj/item/clothing/suit/armor/vest/peacekeeper/brit = 5,
					/obj/item/clothing/suit/armor/vest/peacekeeper = 5,
					/obj/item/storage/belt/security = 5,
					/obj/item/clothing/neck/security_cape = 5,
					/obj/item/clothing/neck/security_cape/armplate = 5,
					/obj/item/storage/backpack/security = 5,
					/obj/item/storage/backpack/satchel/sec = 5,
					/obj/item/storage/backpack/duffelbag/sec = 5,
					/obj/item/clothing/under/rank/security/officer = 5,
					/obj/item/clothing/under/rank/security/peacekeeper/tactical = 5,
					/obj/item/clothing/under/rank/security/peacekeeper/sol/cadet = 5,
					/obj/item/clothing/under/rank/security/peacekeeper/sol = 5,
					/obj/item/clothing/under/rank/security/skyrat/utility = 5,
					/obj/item/clothing/shoes/jackboots/sec = 5,
					/obj/item/clothing/head/security_garrison = 5,
					/obj/item/clothing/head/security_cap = 5,
					/obj/item/clothing/head/beret/sec/peacekeeper = 5,
					/obj/item/clothing/glasses/hud/security = 5,
					/obj/item/clothing/head/costume/ushanka/sec = 5,
					/obj/item/clothing/head/hats/sec/peacekeeper/sol = 5,
					/obj/item/clothing/head/hats/sec/peacekeeper/sol/traffic = 5,
					/obj/item/clothing/gloves/color/black/security = 5
			),
		),
	)

	premium = list( /obj/item/clothing/under/rank/security/officer/formal = 5,
					/obj/item/clothing/suit/jacket/officer/tan = 5,
					/obj/item/clothing/suit/jacket/officer/blue = 3,
					/obj/item/clothing/head/beret/sec/navyofficer = 5,
					/obj/item/clothing/glasses/hud/security/sunglasses = 3,
					/obj/item/clothing/glasses/hud/security/sunglasses/redsec = 3
	)

	refill_canister = /obj/item/vending_refill/wardrobe/unisec_wardrobe
	light_color = "#abadcc"
	vend_reply = "Kick these scumbags!"
	extra_price = PAYCHECK_COMMAND * 6

/obj/item/vending_refill/wardrobe/redsec_wardrobe
	machine_name = "RedSec outfitting station"

/obj/item/vending_refill/wardrobe/unisec_wardrobe
	machine_name = "MultiSec outfitting station"

/obj/machinery/vending/wardrobe/sec_wardrobe/red
	refill_canister = /obj/item/vending_refill/wardrobe/redsec_wardrobe
