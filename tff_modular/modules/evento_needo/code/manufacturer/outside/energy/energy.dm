/obj/item/gun/energy/e_gun/hades
	name = "SL AL-655 'Hades' energy rifle"
	desc = "The standard issue rifle of Nanotrasen's Security Forces. Most have been put in long term storage following the ICW, and usually aren't issued to low ranking security divisions."
	icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/onmob.dmi'
	icon_state = "energytac"
	ammo_x_offset = 2
	charge_sections = 5
	ammo_type = list(/obj/item/ammo_casing/energy/laser/assault/sharplite, /obj/item/ammo_casing/energy/disabler/sharplite)

	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	wield_slowdown = HEAVY_LASER_RIFLE_SLOWDOWN
	spread_unwielded = 20

/obj/item/gun/energy/e_gun/hades/update_icon_state()
	. = ..()
	inhand_icon_state = "energytac[istype(ammo_type[select], /obj/item/ammo_casing/energy/laser/assault/sharplite) ? "kill" : "disable"][cell.charge]"

/obj/item/gun/energy/e_gun/old
	name = "prototype energy gun"
	desc = "NT-P:01 Prototype Energy Gun. Early stage development of a unique laser rifle that has a multifaceted energy lens, allowing the gun to alter the form of projectile it fires on command. The project was a dud, and Nanotrasen later acquired Sharplite to suit its laser weapon needs."

	icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/onmob.dmi'
	icon_state = "protolaser"
	ammo_x_offset = 2
	ammo_type = list(/obj/item/ammo_casing/energy/laser/sharplite, /obj/item/ammo_casing/energy/electrode/old)

/obj/item/gun/energy/e_gun/hos/shiptest
	name = "\improper X-01 MultiPhase Energy Gun"
	desc = "This is an expensive, modern recreation of an antique laser gun. This gun has several unique firemodes, but lacks the ability to recharge over time."

	icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/onmob.dmi'
	icon_state = "hoslaser"
	force = 10
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/sharplite/hos, /obj/item/ammo_casing/energy/laser/sharplite/hos, /obj/item/ammo_casing/energy/ion/hos, /obj/item/ammo_casing/energy/electrode/hos)
	shaded_charge = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/gun/energy/e_gun/hos/shiptest/brazil
	name = "modified antique laser gun"
	desc = "It's somehow modified to have more firemodes."
	icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/onmob.dmi'
	icon_state = "capgun_brazil_hos"

/obj/item/gun/energy/e_gun/hos/shiptest/brazil/true
	desc = "This genuine antique laser gun, modified with an experimental suite of alternative firing modes based on the X-01 MultiPhase Energy Gun, is now truly one of the finest weapons in the frontier."
	icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/onmob.dmi'
	icon_state = "capgun_hos"
	selfcharge = TRUE


/obj/item/gun/energy/e_gun/nuclear/shiptest
	name = "advanced energy gun"
	desc = "An energy gun with an experimental miniaturized nuclear reactor that automatically charges the internal power cell."

	icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/onmob.dmi'
	icon_state = "nucgun"

	charge_delay = 10
	can_charge = FALSE
	internal_magazine = TRUE
	ammo_x_offset = 2
	ammo_type = list(/obj/item/ammo_casing/energy/laser, /obj/item/ammo_casing/energy/disabler)
	selfcharge = TRUE

/obj/item/gun/energy/e_gun/nuclear/process(seconds_per_tick)
	if(fail_tick > 0)
		fail_tick -= seconds_per_tick * 0.5
	..()

/obj/item/gun/energy/e_gun/nuclear/shoot_live_shot(mob/living/user, pointblank = 0, atom/pbtarget = null, message = 1)
	failcheck()
	update_appearance()
	..()

/obj/item/gun/energy/e_gun/nuclear/failcheck()
	if(prob(fail_chance) && isliving(loc))
		var/mob/living/M = loc
		switch(fail_tick)
			if(0 to 200)
				fail_tick += (2*(fail_chance))
				SSradiation.irradiate(M)
				to_chat(M, span_userdanger("Your [name] feels warmer."))
			if(201 to INFINITY)
				SSobj.processing.Remove(src)
				SSradiation.irradiate(M)
				reactor_overloaded = TRUE
				to_chat(M, span_userdanger("Your [name]'s reactor overloads!"))

/obj/item/gun/energy/e_gun/nuclear/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	fail_chance = min(fail_chance + round(15/severity), 100)

/obj/item/gun/energy/e_gun/nuclear/update_overlays()
	. = ..()
	if(reactor_overloaded)
		. += "[icon_state]_fail_3"
		return
	switch(fail_tick)
		if(0)
			. += "[icon_state]_fail_0"
		if(1 to 150)
			. += "[icon_state]_fail_1"
		if(151 to INFINITY)
			. += "[icon_state]_fail_2"

/obj/item/gun/energy/e_gun/rdgun
	name = "research director's PDW"
	desc = "A energy revolver made from the power of science, but more importantly booze. Only has 6 shots."
	icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/onmob.dmi'
	icon_state = "rdpdw"
	inhand_icon_state = "gun"
	worn_icon_state = "gun"
	ammo_x_offset = 2
	charge_sections = 6
	wield_slowdown = LASER_PISTOL_SLOWDOWN

	spread = 2
	spread_unwielded = 5

	ammo_type = list(/obj/item/ammo_casing/energy/disabler/hitscan, /obj/item/ammo_casing/energy/ion/cheap)

/obj/item/gun/energy/e_gun/adv_stopping
	name = "advanced stopping revolver"
	desc = "An advanced energy revolver with the capacity to shoot both disabler and lethal lasers, as well as futuristic safari nets."
	icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/onmob.dmi'
	icon_state = "bsgun"
	inhand_icon_state = "gun"
	worn_icon_state = "gun"
	force = 7
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/sharplite/hos, /obj/item/ammo_casing/energy/laser/sharplite/hos, /obj/item/ammo_casing/energy/trap)
	ammo_x_offset = 1
	shaded_charge = TRUE

/obj/item/gun/energy/e_gun/smg
	name = "\improper E-TAR SMG"
	desc = "A dual-mode energy gun capable of discharging weaker shots at a much faster rate than the standard energy gun."
	icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/onmob.dmi'
	icon_state = "esmg"
	inhand_icon_state = "gun"
	worn_icon_state = "gun"
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/sharplite/smg, /obj/item/ammo_casing/energy/laser/sharplite/smg)
	ammo_x_offset = 2
	charge_sections = 3
	weapon_weight = WEAPON_LIGHT

	wield_slowdown = LASER_SMG_SLOWDOWN

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)

/obj/item/gun/energy/e_gun/iot
	name = "\improper E-SG 500 Second Edition"
	desc = "A improved version of the E-SG 255. It now includes two firing modes, disable and kill, while still keeping that sweet integrated computer. Please note that the screen is right next to the switch mode button."

	icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'icons/mob/inhands/weapons/64x_guns_right.dmi'

	inhand_x_dimension = 64
	inhand_y_dimension = 64
	icon_state = "iotshotgun"
	inhand_icon_state = "shotgun_combat"
	shaded_charge = TRUE
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/scatter/ultima, /obj/item/ammo_casing/energy/laser/ultima)
	w_class = WEIGHT_CLASS_BULKY
