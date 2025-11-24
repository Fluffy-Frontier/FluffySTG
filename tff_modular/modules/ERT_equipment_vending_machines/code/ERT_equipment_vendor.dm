// Базовый вариант вендора как темплейт для всех "специализированных" версий
/obj/machinery/vending/ertvend
	name = "\improper ERT Equipment Vend"
	desc = "Equipment for those cases where everything has gone wrong at the station. Do you still have time to read this description? Get to work now!"
	icon = 'tff_modular/modules/ERT_equipment_vending_machines/icons/obj/ERT_equipment_vendor.dmi'
	icon_state = "ERTvend"
	icon_deny = "ERTvend-deny"
	panel_type = "panelERTvend"
	light_mask = "ERTvend-light-mask"
	light_color = "#a5aae7ff"
	onstation = 0
	all_products_free = 1
	allow_custom = 0
	// scan_id = 1
	// контроль доступов у вендоров не работает
	// req_access = list("cent_general")

	product_ads = "Every second counts!;Get the equipment NOW! Manage your inventory on the ERT shuttle!;The maximum response time according to the corporate standard is 3 minutes. HURRY UP!"
	vend_reply = "Move out! Fire at will!"

	product_categories = list(
		list(
			"name" = "Weapons",
			"icon" = "gun",
			"products" = list(

			),
		),
		list(
			"name" = "Ammo",
			"icon" = "box-archive",
			"products" = list(

			),
		),
		list(
			"name" = "Accessories",
			"icon" = "person-military-rifle",
			"products" = list(
				/obj/item/storage/belt/security/webbing = 4,
				/obj/item/clothing/accessory/cqd_holster = 8,
				/obj/item/flashlight/seclite = 8,
				/obj/item/storage/pouch/ammo = 4,
				/obj/item/shield/riot/tele = 4,
				/obj/item/shield/ballistic = 4,
				/obj/item/screwdriver = 8,
				/obj/item/wirecutters = 8,
				/obj/item/mod/module/jetpack = 4,
				/obj/item/mod/module/magboot = 4,
				/obj/item/firing_pin/implant/mindshield = 8
			),
		),
	)
	contraband = list(
		/obj/item/clothing/under/costume/playbunny/centcom = 1,
		/obj/item/clothing/suit/armor/security_tailcoat/centcom = 1,
		/obj/item/clothing/neck/bunny/bunnytie/centcom = 1,
		/obj/item/clothing/head/playbunnyears/centcom = 1,
		/obj/item/clothing/shoes/fancy_heels/green = 1,
		/obj/item/clothing/shoes/fancy_heels/darkgreen = 1
	)
	premium = list(
		/obj/item/stock_parts/power_store/cell/lead = 1
	)
	refill_canister = /obj/item/vending_refill/ertvend

// в теории это сделает вендоры бесплатными при спавне, а не только при загрузке карт и темплейтов
/obj/machinery/vending/ertvend/Initialize()
    . = ..()
    all_products_free = TRUE
    qdel(GetComponent(/datum/component/payment))

// Вендор для ОБР Blue. Снаряжение примерно аналогично раундстартовой оружейке СБ
/obj/machinery/vending/ertvend/blue
	name = "\improper ERT Equipment Vend - Blue"
	product_categories = list(
		list(
			"name" = "Weapons",
			"icon" = "gun",
			"products" = list(
				/obj/item/gun/energy/disabler = 4,
				/obj/item/gun/energy/disabler/smg = 4,
				/obj/item/gun/ballistic/automatic/pistol/sol = 4,
				/obj/item/gun/energy/e_gun/dragnet = 2,
				/obj/item/gun/energy/modular_laser_rifle/carbine = 2,
				/obj/item/gun/ballistic/automatic/sol_smg = 2,
				/obj/item/gun/ballistic/automatic/wt550 = 2,
				/obj/item/gun/ballistic/shotgun/riot/sol = 2
			),
		),
		list(
			"name" = "Ammo",
			"icon" = "box-archive",
			"products" = list(
				/obj/item/ammo_box/magazine/c35sol_pistol = 8,
				/obj/item/ammo_box/magazine/c35sol_pistol/stendo = 8,
				/obj/item/ammo_box/magazine/wt550m9 = 8,
				/obj/item/ammo_box/advanced/s12gauge/rubber = 8,
				/obj/item/ammo_box/advanced/s12gauge/bean = 8,
				/obj/item/ammo_box/advanced/s12gauge/antitide = 8,
				/obj/item/ammo_box/advanced/s12gauge = 8,
				/obj/item/ammo_box/advanced/s12gauge/incendiary = 8,
				/obj/item/ammo_box/advanced/s12gauge/hunter = 8,
				/obj/item/ammo_box/advanced/s12gauge/flechette = 8
			),
		),
		list(
			"name" = "Accessories",
			"icon" = "person-military-rifle",
			"products" = list(
				/obj/item/storage/belt/security/webbing = 4,
				/obj/item/clothing/accessory/cqd_holster = 8,
				/obj/item/flashlight/seclite = 8,
				/obj/item/storage/pouch/ammo = 4,
				/obj/item/shield/riot/tele = 4,
				/obj/item/shield/ballistic = 4,
				/obj/item/screwdriver = 8,
				/obj/item/wirecutters = 8,
				/obj/item/mod/module/jetpack = 4,
				/obj/item/mod/module/magboot = 4,
				/obj/item/firing_pin/implant/mindshield = 8
			),
		),
	)
	premium = list(
		/obj/item/stock_parts/power_store/cell/lead = 1
	)

// Вендор для ОБР Amber. Снаряга примерно аналогична тому, что можно заказать в карго

/obj/machinery/vending/ertvend/amber
	name = "\improper ERT Equipment Vend - Amber"
	icon_state = "ERTvend-amber"
	product_categories = list(
		list(
			"name" = "Weapons",
			"icon" = "gun",
			"products" = list(
				/obj/item/gun/ballistic/automatic/proto/unrestricted = 2,
				/obj/item/gun/ballistic/automatic/pistol/trappiste = 4,
				/obj/item/gun/ballistic/revolver/takbok = 4,
				/obj/item/gun/ballistic/automatic/pistol/m1911 = 4,
				/obj/item/gun/ballistic/automatic/xhihao_smg = 2,
				/obj/item/gun/ballistic/automatic/nt20 = 2,
				/obj/item/gun/ballistic/automatic/laser = 2,
				/obj/item/gun/energy/laser/carbine/cybersun/black_market_trader = 2,
				/obj/item/gun/ballistic/shotgun/automatic/combat/compact = 2,
				/obj/item/gun/ballistic/shotgun/automatic/combat = 2,
				/obj/item/gun/ballistic/automatic/sol_rifle/marksman = 2,
				/obj/item/gun/ballistic/automatic/sol_rifle = 2
			),
		),
		list(
			"name" = "Ammo",
			"icon" = "box-archive",
			"products" = list(
				/obj/item/ammo_box/magazine/smgm9mm = 8,
				/obj/item/ammo_box/magazine/c585trappiste_pistol = 20,
				/obj/item/ammo_box/c585trappiste = 8,
				/obj/item/ammo_box/magazine/m45 = 8,
				/obj/item/ammo_box/magazine/recharge = 16,
				/obj/item/ammo_box/magazine/c40sol_rifle = 8,
				/obj/item/ammo_box/magazine/c40sol_rifle/standard =8,
				/obj/item/ammo_box/magazine/smgm45 = 8,
				/obj/item/ammo_box/advanced/s12gauge/rubber = 8,
				/obj/item/ammo_box/advanced/s12gauge/bean = 8,
				/obj/item/ammo_box/advanced/s12gauge/antitide = 8,
				/obj/item/ammo_box/advanced/s12gauge = 8,
				/obj/item/ammo_box/advanced/s12gauge/buckshot = 8,
				/obj/item/ammo_box/advanced/s12gauge/incendiary = 8,
				/obj/item/ammo_box/advanced/s12gauge/hunter = 8,
				/obj/item/ammo_box/advanced/s12gauge/flechette = 8
			),
		),
		list(
			"name" = "Accessories",
			"icon" = "person-military-rifle",
			"products" = list(
				/obj/item/storage/belt/security/webbing = 4,
				/obj/item/clothing/accessory/cqd_holster = 8,
				/obj/item/flashlight/seclite = 8,
				/obj/item/storage/pouch/ammo = 4,
				/obj/item/shield/riot/tele = 4,
				/obj/item/shield/ballistic = 4,
				/obj/item/screwdriver = 8,
				/obj/item/wirecutters = 8,
				/obj/item/mod/module/jetpack = 4,
				/obj/item/mod/module/magboot = 4,
				/obj/item/firing_pin/implant/mindshield = 8
			),
		),
	)
	premium = list(
		/obj/item/stock_parts/power_store/cell/lead = 1
	)

// Вендор для ОБР RED. Сильное лазерное оружие и баллистика с уроном от выстрела/очереди >= 50 единиц

/obj/machinery/vending/ertvend/red
	name = "\improper ERT Equipment Vend - RED"
	icon_state = "ERTvend-red"
	product_categories = list(
		list(
			"name" = "Weapons",
			"icon" = "gun",
			"products" = list(
				/obj/item/gun/ballistic/automatic/pistol/deagle = 4,
				/obj/item/gun/ballistic/revolver/mateba = 4,
				/obj/item/gun/ballistic/automatic/ar = 2,
				/obj/item/gun/energy/laser/hellgun/blueshield = 2,
				/obj/item/gun/energy/laser/captain/scattershot = 2,
				/obj/item/gun/ballistic/automatic/lanca = 2,
				/obj/item/gun/ballistic/automatic/sniper_rifle/modular = 2
			),
		),
		list(
			"name" = "Ammo",
			"icon" = "box-archive",
			"products" = list(
				/obj/item/grenade/c4 = 3,
				/obj/item/grenade/frag = 3,
				/obj/item/ammo_box/magazine/m50 = 16,
				/obj/item/ammo_box/speedloader/c357 = 16,
				/obj/item/ammo_box/magazine/m223 = 16,
				/obj/item/ammo_box/magazine/lanca = 16,
				/obj/item/ammo_box/magazine/sniper_rounds = 16
			),
		),
		list(
			"name" = "Accessories",
			"icon" = "person-military-rifle",
			"products" = list(
				/obj/item/storage/belt/security/webbing = 4,
				/obj/item/clothing/accessory/cqd_holster = 8,
				/obj/item/flashlight/seclite = 8,
				/obj/item/storage/pouch/ammo = 4,
				/obj/item/shield/riot/tele = 4,
				/obj/item/shield/ballistic = 4,
				/obj/item/screwdriver = 8,
				/obj/item/wirecutters = 8,
				/obj/item/mod/module/jetpack = 4,
				/obj/item/mod/module/magboot = 4,
				/obj/item/firing_pin/implant/mindshield = 8
			),
		),
	)
	premium = list(
		/obj/item/stock_parts/power_store/cell/lead = 1,
		/obj/item/storage/belt/military/assault = 4
	)
// Вендор ЦКшной версии БЩ. Для тех случаев, когда нужна охрана для "личной беседы" с командованием на станции

/obj/machinery/vending/ertvend/srt
	name = "\improper Blueshield SRT Vend"
	icon_state = "ERTvend-srt"
	icon_deny = "ERTvend-srt-deny"
	product_categories = list(
	list(
			"name" = "Apparel",
			"icon" = "shirt",
			"products" = list(
				/obj/item/storage/bag/garment/blueshield = 4,
				/obj/item/clothing/shoes/combat/swat = 4,
				/obj/item/clothing/gloves/combat = 4,
				/obj/item/card/id/advanced/centcom/ert/security = 4,
				/obj/item/modular_computer/pda/blueshield = 4,
				/obj/item/radio/headset/headset_bs/alt = 4,
				/obj/item/clothing/glasses/hud/security/sunglasses/blue = 4,
				/obj/item/clothing/glasses/hud/security/sunglasses = 4,
				/obj/item/clothing/glasses/hud/health/sunglasses = 4,
				/obj/item/storage/backpack/blueshield = 4,
				/obj/item/storage/backpack/duffelbag/blueshield = 4,
				/obj/item/storage/backpack/messenger/blueshield = 4,
				/obj/item/storage/backpack/satchel/blueshield = 4,
				/obj/item/mod/control/pre_equipped/blueshield = 4,
				/obj/item/storage/box/survival/centcom = 4,
				/obj/item/storage/medkit/tactical/blueshield = 4,
				/obj/item/storage/belt/security/full = 4,
				/obj/item/implanter/mindshield = 4,
				/obj/item/clothing/under/syndicate/rus_army/cin_surplus/marine = 4,
				/obj/item/clothing/suit/armor/vest/peacekeeper/spacecoat = 4,
				/obj/item/clothing/suit/armor/vest/nt_police = 4
			),
		),
		list(
			"name" = "Weapons",
			"icon" = "gun",
			"products" = list(
				/obj/item/knife/combat = 8,
				/obj/item/book/granter/martial/cqc = 4,
				/obj/item/choice_beacon/blueshield = 4,
				/obj/item/gun/ballistic/automatic/proto/unrestricted = 4,
			),
		),
		list(
			"name" = "Ammo",
			"icon" = "box-archive",
			"products" = list(
			 	/obj/item/ammo_box/magazine/smgm9mm = 20,
				/obj/item/stock_parts/power_store/cell/bluespace = 20,
				/obj/item/ammo_box/magazine/smgm45 = 16,
				/obj/item/ammo_box/magazine/katyusha/empty = 16,
				/obj/item/ammo_box/advanced/s12gauge/rubber = 8,
				/obj/item/ammo_box/advanced/s12gauge/bean = 8,
				/obj/item/ammo_box/advanced/s12gauge/antitide = 8,
				/obj/item/ammo_box/advanced/s12gauge = 8,
				/obj/item/ammo_box/advanced/s12gauge/buckshot = 8,
				/obj/item/ammo_box/advanced/s12gauge/incendiary = 8,
				/obj/item/ammo_box/advanced/s12gauge/hunter = 8,
				/obj/item/ammo_box/advanced/s12gauge/flechette = 8
			),
		),
		list(
			"name" = "Accessories",
			"icon" = "person-military-rifle",
			"products" = list(
				/obj/item/storage/pouch/ammo = 4,
				/obj/item/storage/belt/security/webbing = 4,
				/obj/item/flashlight/seclite = 8,
				/obj/item/clothing/accessory/cqd_holster = 4,
				/obj/item/shield/riot/tele = 4,
				/obj/item/shield/ballistic = 4,
				/obj/item/screwdriver = 4,
				/obj/item/wirecutters = 4,
				/obj/item/slimepotion/speed= 4,
				/obj/item/mod/paint = 2,
				/obj/item/toy/crayon/spraycan = 2
			),
		)
	)
	premium = list(
		/obj/item/stock_parts/power_store/cell/lead = 2,
		/obj/item/autosurgeon/medical_hud = 2
	)

// Вендор оборудования для мехов. Вообще стоит сделать отдельные "preloaded" мехи в коде
/obj/machinery/vending/ertvend/sci
	name = "\improper ERT Equipment Vend - Mech"
	icon_state = "ERTvend-sci"
	icon_deny = "ERTvend-sci-deny"
	product_categories = list(
		list(
			"name" = "Weapons",
			"icon" = "gun",
			"products" = list(
				/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/heavy = 5,
				/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser = 5,
				/obj/item/mecha_parts/mecha_equipment/weapon/energy/ion = 5,
				/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot = 5,
				/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg = 5,
				/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/flashbang = 5
			),
		),
		list(
			"name" = "Ammo",
			"icon" = "box-archive",
			"products" = list(
			 	/obj/item/mecha_ammo/scattershot = 20,
				/obj/item/mecha_ammo/lmg = 20,
				/obj/item/mecha_ammo/flashbang = 20
			),
		),
		list(
			"name" = "Auxiliary Equipment",
			"icon" = "wrench",
			"products" = list(
				/obj/item/stock_parts/power_store/cell/bluespace = 8,
				/obj/item/mecha_parts/mecha_equipment/armor/anticcw_armor_booster = 5,
				/obj/item/mecha_parts/mecha_equipment/armor/antiproj_armor_booster = 5,
				/obj/item/mecha_parts/mecha_equipment/repair_droid = 5,
				/obj/item/mecha_parts/mecha_equipment/thrusters/ion = 5,
				/obj/item/mecha_parts/mecha_equipment/air_tank/full = 5,
				/obj/item/mecha_parts/mecha_equipment/radio = 5
			),
		)
	)
	premium = list(
		/obj/item/stock_parts/power_store/cell/lead = 2,
		/obj/item/toy/crayon/spraycan/roboticist = 2,
		/obj/item/weldingtool/experimental = 2,
		/obj/item/screwdriver/power = 2,
		/obj/item/crowbar/power = 2
	)
// Пополняшка для всех вышеперечисленных вендоров

/obj/item/vending_refill/ertvend
	machine_name = "ERT Equipment Vend"
	icon_state = "refill_centdrobe"

// Маяк вызова всех вышеперечисленных вендоров и пополняшки
// 'modular_nova/modules/modular_items/icons/remote.dmi'
// icon state = "self_delivery"

/obj/item/choice_beacon/ertvend
	name = "ERT Vendors choice beacon"
	desc = "A single-use beacon to deliver ERT vendors."
	icon_state = "self_delivery"
	inhand_icon_state = "electronic"
	icon = 'modular_nova/modules/modular_items/icons/remote.dmi'
	company_source = "Nanotrasen Rapid Equipment Deployment Division"
	company_message = span_bold("Supply Pod incoming, please stand by.")

/obj/item/choice_beacon/ertvend/generate_display_names()
	var/static/list/selectable_types = list(
		"ERT generic vending machine" = /obj/machinery/vending/ertvend,
		"ERT Code Blue" = /obj/machinery/vending/ertvend/blue,
		"ERT Code Amber" = /obj/machinery/vending/ertvend/amber,
		"ERT Code Red" = /obj/machinery/vending/ertvend/red,
		"ERT Mech Equipment" = /obj/machinery/vending/ertvend/sci,
		"ERT SRT Blueshield" = /obj/machinery/vending/ertvend/srt,
		"ERT Vending Refill" = /obj/item/vending_refill/ertvend,
	)
	return selectable_types
