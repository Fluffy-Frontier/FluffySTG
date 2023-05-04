/obj/machinery/vending/wardrobe/uni_sec_wardrobe
	name = "\improper Universal SecDrobe"
	desc = "A vending machine for security and security-related clothing!"
	product_ads = "Beat perps in style!;It's red and blue so you can't distinguish blood and water!;You have the right to be fashionable!;Now you can be the fashion police you always wanted to be!"
	vend_reply = "Thank you for using the SecDrobe!"
	icon = '~ff/modules/redsec/icons/obj/vending.dmi'
	icon_state = "secdrobe"
	product_categories = list(
		list(
			"name" = "RedSec",
			"icon" = "hat-cowboy",
			"products" = list(
					/obj/item/clothing/suit/hooded/wintercoat/security/redsec = 6,
					/obj/item/storage/belt/security/redsec = 6,
					/obj/item/storage/backpack/security/redsec = 6,
					/obj/item/storage/backpack/satchel/sec/redsec = 6,
					/obj/item/storage/backpack/duffelbag/sec/redsec = 6,
					/obj/item/clothing/under/rank/security/officer/redsec = 6,
					/obj/item/clothing/shoes/jackboots/sec/redsec = 6,
					/obj/item/clothing/head/beret/sec = 6,
					/obj/item/clothing/head/soft/sec = 6,
					/obj/item/clothing/mask/bandana/red = 6,
					/obj/item/clothing/glasses/hud/security/redsec = 6,
					/obj/item/clothing/gloves/color/black = 6,
					/obj/item/clothing/under/rank/security/officer/skirt = 6,
					/obj/item/clothing/under/rank/security/skyrat/utility/redsec = 6,
					/obj/item/clothing/suit/toggle/jacket/sec/old = 6,
					/obj/item/clothing/suit/armor/vest/alt/sec/redsec = 6,
			),
		),

		list(
			"name" = "BlueSec",
			"icon" = "hat-cowboy",
			"products" = list(
					/obj/item/clothing/suit/hooded/wintercoat/security = 5,
					/obj/item/clothing/suit/toggle/jacket/sec = 5,
					/obj/item/clothing/suit/armor/vest/peacekeeper/brit = 5,
					/obj/item/storage/belt/security = 6,
					/obj/item/clothing/neck/security_cape = 5,
					/obj/item/clothing/neck/security_cape/armplate = 5,
					/obj/item/storage/backpack/security = 5,
					/obj/item/storage/backpack/satchel/sec = 5,
					/obj/item/storage/backpack/duffelbag/sec = 5,
					/obj/item/clothing/under/rank/security/officer = 10,
					/obj/item/clothing/under/rank/security/peacekeeper/tactical = 4,
					/obj/item/clothing/under/rank/security/peacekeeper/sol/cadet = 3,
					/obj/item/clothing/under/rank/security/peacekeeper/sol = 3,
					/obj/item/clothing/under/rank/security/skyrat/utility = 3,
					/obj/item/clothing/shoes/jackboots/sec = 10,
					/obj/item/clothing/head/security_garrison = 10,
					/obj/item/clothing/head/security_cap = 10,
					/obj/item/clothing/head/beret/sec/peacekeeper = 5,
					/obj/item/clothing/glasses/hud/security = 6,
					/obj/item/clothing/head/costume/ushanka/sec = 10,
					/obj/item/clothing/head/hats/sec/peacekeeper/sol = 5,
					/obj/item/clothing/head/hats/sec/peacekeeper/sol/traffic = 5,
					/obj/item/clothing/gloves/color/black/security = 10,
			),
		),
	)

	premium = list( /obj/item/clothing/under/rank/security/officer/formal = 5,
					/obj/item/clothing/suit/jacket/officer/tan = 5,
					/obj/item/clothing/suit/jacket/officer/blue = 3,
					/obj/item/clothing/head/beret/sec/navyofficer = 5,
					/obj/item/clothing/glasses/hud/security/sunglasses/redsec = 3,
					/obj/item/clothing/glasses/hud/security/sunglasses = 3,
	)

	light_color = "#abadcc"
	vend_reply = "Kick these scumbags!"
	extra_price = PAYCHECK_COMMAND * 6
