//A tribute to, and Designed mostly by InsightfulParasite, our lovely spriter. Coded by Kirie Saito.
/mob/living/simple_animal/hostile/abnormality/shrimp_exec
	name = "Shrimp Association Executive"
	desc = "A shrimp in a snazzy suit."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "executive"
	icon_living = "executive"
	faction = list("neutral")
	speak_emote = list("burbles")
	fear_level = WAW_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/executive,
		/datum/ego_datum/armor/executive,
	)
	gift_type =  /datum/ego_gifts/executive

	grouped_abnos = list(
		///mob/living/simple_animal/hostile/abnormality/wellcheers = 1.5, // I... if you ever get a zayin this far in, good luck.
	)

	observation_prompt = "You sit in an office decorated with shrimp-related memorabilia. <br>\
		Various trophies and medals and other trinkets with shrimp on them. <br>A PHD in shrimpology printed on printer paper is displayed prominantly on the wall. <br>\
		\"Enjoying my collection? <br>I played college ball in Shrimp-Corp's nest, you know.\" <br>\
		A delicious looking shrimp in a snazzy suit sits before you in an immaculate office chair. <br>\
		\"But where are my manners... <br>Why don't you enjoy some of our finest locally produced champagne?\" <br>\
		The shrimp offers you a champagne glass full of... Something. <br>\
		It looks and smells like wellcheers grape soda. It's soda. <br>\
		You can even see the can's label torn off and stuck on the side. <br>Will you drink it?"


	var/liked
	var/happy = TRUE
	var/hint_cooldown
	var/hint_cooldown_time = 30 SECONDS
	var/list/cooldown = list(
		"Stop meandering around and get to work!",
		"I can be quite patient at times, but you are beginning to test me!",
		"The service here can be dreadful at times. Why don't you just make yourself useful?",
	)

	var/list/instinct = list(
		"I am getting quite old, and my back is hurting me. Could you send a chiropractor to my office immediately?",
		"I am quite peckish, could you send me a charcuterie board?",
		"Could you get me a glass of pinot noir, please?",
		"Fetch me a bowl of shrimp fried rice? I'm looking to try this delicacy made by your finest shrimp chefs.",
		"Ah, I forgot to take my daily medication, could you bring it to me?",
	)

	var/list/insight = list(
		"Get me my phonograph, I would like to listen to Moonlight Sonata, 1st Movement.",
		"The plants in my office are dying, could you water them please?",
		"It is rather dull, with all the negotiations that we have been doing. Could you get me the morning crossword?",
		"I've noticed some dust collecting on the bookshelves, could you get someone to dust it?",
		"Ah, I seem to have spilt my wine, could you get it cleaned up?",
		"I think my suit needs to be dry-cleaned. Take it and go.",

	)

	var/list/attachment = list(
		"You know, I had this brand new deal that I am setting up. Care to listen sometime?",
		"I was wondering if YOU had any good business offers. It would be nice to hear from a fellow intellectual. Stop by and tell me sometime.",
		"Come, pull up a glass, old friend. Let's drink to a good deal!",
		"I'm thinking about buying stocks for my portfolio, what do you recommend I invest in?",
		"Got a moment to chat about something important? Let's catch up over a cup of coffee and discuss some potential business moves. Your insights are always valuable to me.",
		"I was wondering if you might be available to join me for a brief tête-à-tête over a cup of tea. Come on by when you are available.",
	)

	//A list of shit that it can create. Yes, it includes ego. How did a shrimp get ego? IDFK. I guess his company makes it.
	//Could diversify clerks I guess.
	var/list/dispenseitem= list(
		/obj/item/grenade/spawnergrenade/shrimp,
		/obj/item/grenade/spawnergrenade/shrimp/super,
		/obj/item/ego_weapon/ranged/pistol/soda,
		/obj/item/ego_weapon/ranged/sodasmg,
		/obj/item/ego_weapon/ranged/sodashotty,
		/obj/item/ego_weapon/ranged/sodarifle,
		/obj/item/clothing/suit/armor/ego_gear/zayin/soda,
		///obj/item/reagent_containers/cup/soda_cans/wellcheers_red,
		///obj/item/reagent_containers/cup/soda_cans/wellcheers_white,
	)

/mob/living/simple_animal/hostile/abnormality/shrimp_exec/SuccessEffect(mob/living/carbon/human/user)
	var/turf/dispense_turf = get_step(src, pick(1,2,4,5,6,8,9,10))
	var/gift = pick(dispenseitem)
	new gift(dispense_turf)
	say("Here you are, my dear friend. High-quality firepower courtesy of shrimpcorp.")
	return

/mob/living/simple_animal/hostile/abnormality/shrimp_exec/FailureEffect(mob/living/carbon/human/user)
	qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/shrimp_exec/ZeroQliphoth(mob/living/carbon/human/user)
	pissed()
	qliphoth_change(1)
	return

/mob/living/simple_animal/hostile/abnormality/shrimp_exec/BreachEffect(mob/living/carbon/human/user)
	pissed()
	addtimer(CALLBACK(src, PROC_REF(pissed)), 20 SECONDS)

/mob/living/simple_animal/hostile/abnormality/shrimp_exec/try_working(mob/living/carbon/human/user)
	if(user.get_major_clothing_class() == liked || !liked)
		happy = TRUE
	else
		happy = FALSE
	return ..()

/mob/living/simple_animal/hostile/abnormality/shrimp_exec/PostWorkEffect(mob/living/carbon/human/user)
	liked = pick(CLOTHING_ENGINEERING, CLOTHING_SCIENCE, CLOTHING_SERVICE)
	switch(liked)
		if(CLOTHING_ENGINEERING)
			say(pick(instinct))
		if(CLOTHING_SCIENCE)
			say(pick(insight))
		if(CLOTHING_SERVICE)
			say(pick(attachment))

/mob/living/simple_animal/hostile/abnormality/shrimp_exec/proc/pissed()
	var/turf/W = get_turf(pick(GLOB.generic_event_spawns))
	for(var/turf/T in orange(1, W))
		var/obj/structure/closet/supplypod/extractionpod/pod = new()
		pod.explosionSize = list(0,0,0,0)
		if(prob(70))
			new /mob/living/simple_animal/hostile/shrimp(pod)
		else
			new /mob/living/simple_animal/hostile/shrimp_soldier(pod)

		new /obj/effect/pod_landingzone(T, pod)
		stoplag(2)

/* Shrimpo boys */
/mob/living/simple_animal/hostile/shrimp
	name = "wellcheers corp liquidation intern"
	desc = "A shrimp that is extremely hostile to you."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "wellcheers"
	icon_living = "wellcheers"
	icon_dead = "wellcheers_dead"
	faction = list("shrimp")
	health = 400
	maxHealth = 400
	melee_damage_type = BRUTE
	damage_coeff = list(BURN = 0.8, BRAIN = 1.5, BRUTE = 1.2, TOX = 2)
	melee_damage_lower = 24
	melee_damage_upper = 27
	robust_searching = TRUE
	stat_attack = HARD_CRIT
	del_on_death = TRUE
	attack_verb_continuous = "punches"
	attack_verb_simple = "punches"
	attack_sound = 'sound/items/weapons/bite.ogg'
	speak_emote = list("burbles")
	butcher_results = list(/obj/item/stack/spacecash/c50 = 1)
	guaranteed_butcher_results = list(/obj/item/stack/spacecash/c10 = 1)

//You can put these guys about to guard an area.
/mob/living/simple_animal/hostile/shrimp_soldier
	name = "wellcheers corp hired liquidation officer"
	desc = "A shrimp that is there to guard an area."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "wellcheers_bad"
	icon_living = "wellcheers_bad"
	icon_dead = "wellcheers_bad_dead"
	faction = list("shrimp")
	health = 500	//They're here to help
	maxHealth = 500
	melee_damage_type = BRUTE
	damage_coeff = list(BURN = 0.6, BRAIN = 0.7, BRUTE = 1.2, TOX = 2)
	melee_damage_lower = 14
	melee_damage_upper = 18
	robust_searching = TRUE
	stat_attack = HARD_CRIT
	del_on_death = TRUE
	attack_verb_continuous = "punches"
	attack_verb_simple = "punches"
	attack_sound = 'sound/items/weapons/bite.ogg'
	speak_emote = list("burbles")
	ranged = 1
	retreat_distance = 2
	minimum_distance = 3
	casingtype = /obj/item/ammo_casing/caseless/ego_shrimpsoldier
	projectilesound = 'sound/items/weapons/gun/pistol/shot_alt.ogg'
	butcher_results = list(/obj/item/stack/spacecash/c50 = 1)
	guaranteed_butcher_results = list(/obj/item/stack/spacecash/c20 = 1, /obj/item/stack/spacecash/c1 = 5)

/mob/living/simple_animal/hostile/shrimp_soldier/friendly
	name = "wellcheers corp assault officer"
	icon_state = "wellcheers_soldier"
	icon_living = "wellcheers_soldier"
	icon_dead = "wellcheers_soldier_dead"
	faction = list("neutral", "shrimp")

/obj/item/grenade/spawnergrenade/shrimp
	name = "instant shrimp task force grenade"
	desc = "A grenade used to call for a shrimp task force."
	icon_state = "shrimpnade"
	spawner_type = /mob/living/simple_animal/hostile/shrimp_soldier/friendly
	deliveryamt = 3

/obj/item/grenade/spawnergrenade/shrimp/super
	deliveryamt = 7	//Just randomly get double money.

/obj/item/grenade/spawnergrenade/shrimp/hostile
	spawner_type = list(/mob/living/simple_animal/hostile/shrimp, /mob/living/simple_animal/hostile/shrimp_soldier) //Gacha Only, just put it here with the other shrimp grenades.
