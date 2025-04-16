/obj/item/choice_beacon/blueshield
	name = "bodyguard weapon delivery beacon"
	desc = "Weapon delivery beacon designed specially for picky Blueshield Agents."
	icon_state = "self_delivery"
	w_class = WEIGHT_CLASS_TINY

/obj/item/choice_beacon/blueshield/generate_display_names()
	var/static/list/blueshield_weapons
	if(!blueshield_weapons)
		blueshield_weapons = list()
		var/list/possible_weapons = list(
			// Пример для своего значения:
			// путь_оружия = путь_набор_с_оружием,
			// При такой записи в списке будет отображаться название оружия,
			// а доставкой прилетит набор с оружием.
			/obj/item/gun/energy/blueshield = /obj/item/storage/belt/holster/energy/blueshield,
			/obj/item/gun/ballistic/automatic/sol_smg = /obj/item/storage/toolbox/guncase/nova/carwo_large_case/sindano,
			/obj/item/gun/ballistic/automatic/xhihao_smg = /obj/item/storage/toolbox/guncase/nova/xhihao_large_case/bogseo,
			/obj/item/gun/ballistic/automatic/wt550 = /obj/item/storage/toolbox/guncase/nova/wt550,
			/obj/item/gun/ballistic/automatic/nt20 = /obj/item/storage/toolbox/guncase/nova/nt20,
			/obj/item/gun/ballistic/shotgun/katyusha = /obj/item/storage/toolbox/guncase/nova/katyusha,
		)
		for(var/obj/item/weapon as anything in possible_weapons)
			blueshield_weapons[initial(weapon.name)] = possible_weapons[weapon]

	return blueshield_weapons
