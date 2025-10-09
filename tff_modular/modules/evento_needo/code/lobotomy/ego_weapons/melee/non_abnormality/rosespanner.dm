//Like this so we can add a charge mechanic to one of them and have it carry down.
/obj/item/ego_weapon/city/rosespanner
	name = "rosespanner template"
	desc = "A template for the rosespanner workshop"
	icon_state = "rosespanner"
	inhand_icon_state = "rosespanner"
	force = 18
	damtype = BRUTE

	attack_verb_continuous = list("bashes", "crushes")
	attack_verb_simple = list("bash", "crush")

	charge = TRUE
	allow_ability_cancel = FALSE // could break things with overcharge
	charge_cost = 15
	charge_effect = "spend charge to deal an AOE in the current damage type."
	successfull_activation = "You release your charge, dealing a massive burst of damage!"

	var/overcharged
	var/charged

/obj/item/ego_weapon/city/rosespanner/examine(mob/user)
	. = ..()
	. += "Overcharging it will result in explosive aftereffects."

/obj/item/ego_weapon/city/rosespanner/attackby(obj/item/I, mob/living/user, params)
	..()
	if(!istype(I, /obj/item/rosespanner_gear))
		return

	to_chat(user, span_notice("You apply a gear to your weapon, changing its damage type."))
	damtype = I.damtype
	charged = TRUE
	qdel(I)

/obj/item/ego_weapon/city/rosespanner/HandleCharge(added_charge, mob/target)
	. = ..()
	if(!.)
		return FALSE

	if(charge_amount == charge_cap)
		overcharged = TRUE
		currently_charging = TRUE

/obj/item/ego_weapon/city/rosespanner/ChargeAttack(mob/living/target, mob/living/user)
	. = ..()
	target.apply_damage(force, damtype, null, target.run_armor_check(null, damtype), spread_damage = TRUE)

	if(overcharged)
		to_chat(user, span_danger("You overcharged your weapon!."))

	for(var/turf/T in view(2, target))
		new /obj/effect/temp_visual/small_smoke/halfsecond(get_turf(T))
		for(var/mob/living/L in T)
			if(!overcharged && (L == user || ishuman(L)))
				continue
			L.apply_damage(force, damtype, null, L.run_armor_check(null, damtype), spread_damage = TRUE)

	overcharged = FALSE
	charged = FALSE
	damtype = initial(damtype)

//Grade 5
/obj/item/ego_weapon/city/rosespanner/minihammer
	name = "rosespanner mini hammer"
	desc = "A hammer from the rosespanner workshop. Fits in your EGO belt."
	icon_state = "rosespanner_minihammer"
	inhand_icon_state = "rosespanner_minihammer"
	force = 44
	attack_speed = 6

	charge_cost = 7	//Takes fucking forever, you can charge it a little faster

//Grade 5
/obj/item/ego_weapon/city/rosespanner/hammer
	name = "rosespanner hammer"
	desc = "A hammer from the rosespanner workshop"
	icon_state = "rosespanner_hammer"
	inhand_icon_state = "rosespanner_hammer"
	force = 88	//Slow but rosespanners a detriment, so
	attack_speed = 7
	charge_cost = 10	//Takes fucking forever, you can charge it a little faster

//Grade 5
/obj/item/ego_weapon/city/rosespanner/spear
	name = "rosespanner spear"
	desc = "A spear from the rosespanner workshop"
	icon_state = "rosespanner_spear"
	inhand_icon_state = "rosespanner_spear"
	force = 60	//Slow but rosespanners a detriment, so
	attack_speed = CLICK_CD_MELEE
	reach = 2
	stuntime = 5
	charge_cost = 14	//slow weapon, you can charge it faster

//Gears that give the weapons a damage type
/obj/item/rosespanner_gear
	name = "rosespanner red gear"
	desc = "A gear used by Rosespanner workshop. Use them on a rosespanner weapon to augment the weapon."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/lc13_weapons.dmi'
	icon_state = "redgear"
	lefthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/lc13_left.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/lc13_right.dmi'
	damtype = BRUTE


/obj/item/rosespanner_gear/white
	name = "rosespanner white gear"
	icon_state = "whitegear"
	damtype = BRUTE


/obj/item/rosespanner_gear/black
	name = "rosespanner black gear"
	icon_state = "blackgear"
	damtype = BRUTE


/obj/item/rosespanner_gear/pale
	name = "rosespanner pale gear"
	icon_state = "palegear"
	damtype = BRUTE

