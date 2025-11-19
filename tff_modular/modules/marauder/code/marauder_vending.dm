/obj/machinery/vending/liberationstation/armament
	name = "\improper Armament Station"
	desc = "An overwhelming amount of <b>G E A R</b> stored in the the machine."
	icon_state = "liberationstation"
	product_slogans = "Armament Station: Your one-stop shop for all murderous needs!"
	product_ads = "Float like an astronaut, sting like a bullet!;Express your second amendment today!;Guns don't kill people, but you can!;Who needs responsibilities when you have guns?"
	vend_reply = "Remember the name: Armament Station!"
	panel_type = "panel17"
	products = list(
		/obj/item/food/burger/plain = 5, //O say can you see, by the dawn's early light
		/obj/item/food/burger/baseball = 3, //What so proudly we hailed at the twilight's last gleaming
		/obj/item/food/fries = 5, //Whose broad stripes and bright stars through the perilous fight
		/obj/item/reagent_containers/cup/glass/bottle/beer/light = 10, //O'er the ramparts we watched, were so gallantly streaming?
		/obj/item/ammo_box/magazine/smgm45 = 5,
		/obj/item/ammo_box/magazine/m9mm_aps = 5,
		/obj/item/ammo_box/magazine/m10mm = 5,
		/obj/item/ammo_box/magazine/shitzu = 2, //so powercrept
		/obj/item/ammo_box/magazine/pulse = 5,
		/obj/item/ammo_box/pulse_cargo_box = 5,
		/obj/item/ammo_box/magazine/lanca = 5,
		/obj/item/ammo_box/magazine/c35sol_pistol/stendo = 5,
		/obj/item/ammo_box/magazine/c35sol_pistol = 5,
		/obj/item/ammo_box/magazine/c40sol_rifle = 5,
		/obj/item/ammo_box/magazine/m45 = 5,
		/obj/item/ammo_box/magazine/m9mm = 5,
		/obj/item/ammo_box/magazine/enforcer = 5,
		/obj/item/ammo_box/magazine/toy/smgm45/riot = 5,
		/obj/item/ammo_box/foambox/riot = 5,
		/obj/item/ammo_box/magazine/toy/m762/riot = 5,
		/obj/item/ammo_box/magazine/c585trappiste_pistol = 5,
		/obj/item/ammo_box/magazine/recharge/plasma_battery = 5,
	)
	premium = list(
		/obj/item/food/cheesyfries = 5,
		/obj/item/food/burger/baconburger = 5, //Premium burgers for the premium section
	)
	contraband = list(
		/obj/item/clothing/under/misc/patriotsuit = 3,
		/obj/item/bedsheet/patriot = 5,
		/obj/item/food/burger/superbite = 3,
	) //U S A
	armor_type = /datum/armor/vending_liberationstation
	resistance_flags = FIRE_PROOF
	default_price = PAYCHECK_COMMAND * 2.5
	extra_price = PAYCHECK_COMMAND * 2.5
	payment_department = ACCOUNT_SEC
	light_mask = "liberation-light-mask"

/datum/armor/vending_liberationstation
	melee = 100
	bullet = 100
	laser = 100
	energy = 100
	fire = 100
	acid = 50



