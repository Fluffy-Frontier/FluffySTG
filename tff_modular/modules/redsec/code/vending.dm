/obj/machinery/vending/wardrobe/sec_wardrobe
	desc = "An Armadyne peacekeeper equipment vendor."
	name = "\improper MultiSec Peacekeeper Outfitting Station"
	icon = 'tff_modular/modules/redsec/icons/vending.dmi'
	icon_state = "secdrobe"
	product_ads = "Crack capitalist skulls!;Beat some heads in!;Don't forget - harm is good!;Your weapons are right here.;Handcuffs!;Freeze, scumbag!;Don't tase me bro!;Tase them, bro.;Why not have a donut?"
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
	light_color = "#abadcc"
	vend_reply = "Beat these scumbags!"
	extra_price = PAYCHECK_COMMAND * 3
