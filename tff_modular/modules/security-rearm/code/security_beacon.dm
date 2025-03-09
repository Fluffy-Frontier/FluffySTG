/obj/item/choice_beacon/sec_officer
	name = "security officer weapon delivery beacon"
	desc = "Weapon delivery beacon, containing the service weapon for a security officer"
	icon_state = "self_delivery"
	w_class = WEIGHT_CLASS_TINY

/obj/item/choice_beacon/sec_officer/generate_display_names()
	var/static/list/security_kits
	if(!security_kits)
		security_kits = list()
		var/list/possible_weapons = list(
			/obj/item/gun/ballistic/automatic/type213 = /obj/item/storage/toolbox/guncase/nova/pistol/trappiste_small_case/type213,
			/obj/item/gun/energy/e_gun/advtaser = /obj/item/gun/energy/e_gun/advtaser,
			/obj/item/gun/energy/disabler/smg = /obj/item/gun/energy/disabler/smg
		)
		for(var/obj/item/weapon as anything in possible_weapons)
			security_kits[initial(weapon.name)] = possible_weapons[weapon]

	return security_kits
