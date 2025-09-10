//Grade 3, the only hana weapon right now.
/obj/item/ego_weapon/city/hana
	name = "hana weapon system"
	desc = "The weapons system used by hana association"
	special = "Use this weapon to change its mode between spear, sword and fist."	//like a different rabbit knife. No black though
	icon_state = "hana_sword"
	force = 50
	damtype = BRUTE

	attack_verb_continuous = list("cuts", "slices")
	attack_verb_simple = list("cuts", "slices")
	hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/fixer/hana_slash.ogg'
	var/mode = 1

/obj/item/ego_weapon/city/hana/attack_self(mob/living/user)
	var/message
	switch(mode)
		if(1)
			mode = 2
			icon_state = "hana_spear"
			message = "This weapon is now in spear mode, and has extra reach and damage at the cost of stunning you."
			hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/fixer/hana_pierce.ogg'
			attack_verb_continuous = list("stabs", "pierces")
			attack_verb_simple = list("stab", "pierce")

			reach = 2
			force = 60
			stuntime = 5

		if(2)
			mode = 3
			icon_state = "hana_fist"
			message = "This weapon is now in gauntlet mode, and does more damage per hit, and lower attack speed."
			hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/fixer/hana_blunt.ogg'
			attack_verb_continuous = list("smashes", "beats")
			attack_verb_simple = list("smash", "beat")

			reach = 1
			force = 70
			attack_speed = 5.5
			stuntime = 0

		if(3)
			mode = 1
			icon_state = "hana_sword"
			message = "This weapon is now in sword mode, and does more damage per second."
			hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/fixer/hana_slash.ogg'
			attack_verb_continuous = list("cuts", "slices")
			attack_verb_simple = list("cuts", "slices")

			force = 50
			attack_speed = 1
			stuntime = 0

	to_chat(user, span_notice("[message]"))
	playsound(src, 'sound/items/tools/screwdriver2.ogg', 50, TRUE)
