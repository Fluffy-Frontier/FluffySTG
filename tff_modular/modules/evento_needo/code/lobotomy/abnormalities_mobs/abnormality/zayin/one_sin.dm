/mob/living/simple_animal/hostile/abnormality/onesin
	name = "One Sin and Hundreds of Good Deeds"
	desc = "A giant skull that is attached to a cross, it wears a crown of thorns."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	icon_state = "onesin"
	icon_living = "onesin"
	maxHealth = 777
	health = 777
	damage_coeff = list(BURN = 1.5, BRAIN = 1, BRUTE = 1, TOX = 2)
	melee_damage_lower = 8
	melee_damage_upper = 15
	melee_damage_type = BRUTE
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/onesin/onesin_attack.ogg'
	attack_verb_continuous = "smites"
	attack_verb_simple = "smite"
	fear_level = ZAYIN_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/penitence,
		/datum/ego_datum/armor/penitence
	)
	gift_type = /datum/ego_gifts/penitence
	gift_message = "From this day forth, you shall never forget his words."
	grouped_abnos = list(
		/mob/living/simple_animal/hostile/abnormality/white_night = 5,
	)
	observation_prompt = "It has great power. It is savior that will judge you, and executioner that will put you in your demise. <br>\
		In its eyes, you find... <br>(Technically, it has no eyes, so in its pitch-black holes you find...)"


	var/halo_status = "onesin_halo_normal" //used for changing the halo overlays

	update_qliphoth = -1
	update_qliphoth_chance = 10
	work_types = null

//Overlay stuff
/mob/living/simple_animal/hostile/abnormality/onesin/PostSpawn()
	..()
	update_icon()

/mob/living/simple_animal/hostile/abnormality/onesin/update_overlays()
	. = ..()
	. += "onesin" //by the nine this is too cursed

/mob/living/simple_animal/hostile/abnormality/onesin/try_working(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	var/chance = 20
	if(istype(user.ego_gift_list[HAT], gift_type))
		return chance + 20

	new /obj/effect/temp_visual/onesin_blessing(get_turf(user))
	user.adjustSanityLoss(-user.maxSanity * 0.5) // It's healing

	if(isapostle(user))
		for(var/mob/living/simple_animal/hostile/abnormality/white_night/WN in GLOB.mob_living_list)
			if(HAS_TRAIT(WN, TRAIT_GODMODE)) // Contained
				break
			WN.heretics = list()
			to_chat(WN, span_colossus("The twelfth has betrayed us..."))
			WN.loot = list() // No loot for you!
			var/curr_health = WN.health
			for(var/i = 1 to 12)
				sleep(1.5 SECONDS)
				WN.adjustBruteLoss(curr_health/12)
			WN.adjustBruteLoss(666666)
			sleep(5 SECONDS)
			for(var/mob/M in GLOB.alive_player_list)
				if(M.client)
					M.playsound_local(get_turf(M), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/onesin/confession_end.ogg', 50, 0)

		var/datum/antagonist/apostle/A = user.mind.has_antag_datum(/datum/antagonist/apostle, FALSE)
		if(!A.betrayed)
			A.betrayed = TRUE // So no spam happens
			for(var/mob/M in GLOB.player_list)
				if(M.client)
					M.playsound_local(get_turf(M), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/onesin/confession_start.ogg', 25, 0)
	else

		if(prob(chance))
			flick("onesin_halo_good", src)
			new /obj/effect/temp_visual/onesin_blessing(get_turf(user))
			user.adjustBruteLoss(-user.maxHealth)
			user.adjustSanityLoss(-user.maxSanity)
		else
			flick("onesin_halo_bad", src)
			new /obj/effect/temp_visual/onesin_punishment(get_turf(user))
			user.adjustSanityLoss(66)
			playsound(get_turf(user), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/thunderbird/tbird_bolt.ogg', 33, 1)

		playsound(get_turf(user), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/onesin/confession_end.ogg', 50, 0)

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(H.z != z)
			continue
		if(H == user)
			continue
		new /obj/effect/temp_visual/onesin_blessing(get_turf(H))
		var/heal_factor = 0.5
		if(H.sanity_lost)
			heal_factor = 0.25
		H.adjustSanityLoss(-H.maxSanity * heal_factor)

/mob/living/simple_animal/hostile/abnormality/onesin/BreachEffect(mob/living/carbon/human/user)
	can_breach = TRUE
	update_icon()
	return ..()

/mob/living/simple_animal/hostile/abnormality/onesin/AttackingTarget(atom/attacked_target)
	..()
	new /obj/effect/temp_visual/onesin_punishment(get_turf(attacked_target))
