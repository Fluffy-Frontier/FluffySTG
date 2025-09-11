//Coded by me, Kirie Saito!

//Remind me to give it contract features later.....
/mob/living/simple_animal/hostile/abnormality/contract
	name = "A Contract, Signed"
	desc = "A man with a flaming head sitting behind a desk."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x48.dmi'
	icon_state = "firstfold"
	fear_level = WAW_LEVEL

	pixel_x = -16
	base_pixel_x = -16
	ego_list = list(
		/datum/ego_datum/weapon/infinity,
		/datum/ego_datum/armor/infinity,
	)
	gift_type = /datum/ego_gifts/infinity

	observation_prompt = "Before you, sitting on a desk is a man with a flaming head. <br>\
		On the table sits a rather conspicuous piece of paper. <br>\
		\"As per our agreement, the signatory will recieve one E.G.O. gift.\" <br>\
		\"All you need to do is sign here.\" <br>\
		The paper is a jumbled mess of words, you can't make out anything on it. <br>\
		A pen appears in your hand. <br>\
		The seems to be running out of patience. <br>Will you sign?"


	var/list/total_havers = list()
	var/list/fort_havers = list()
	var/list/prud_havers = list()
	var/list/temp_havers = list()
	var/list/just_havers = list()
	var/list/spawnables = list()
	var/total_per_contract = 4
	var/breaching
	var/summon_count = 0
	var/summon_cooldown
	var/summon_cooldown_time = 60 SECONDS
	update_qliphoth_chance = 20
	work_types = null

/mob/living/simple_animal/hostile/abnormality/contract/Initialize()
	. = ..()
	//We need a list of all abnormalities that are TETH to HE level and Can breach.
	var/list/queue = subtypesof(/mob/living/simple_animal/hostile/abnormality)
	for(var/i in queue)
		var/mob/living/simple_animal/hostile/abnormality/abno = i
		if(!(initial(abno.can_spawn)) || !(initial(abno.can_breach)))
			continue

		if((initial(abno.fear_level)) <= WAW_LEVEL)
			spawnables += abno

/mob/living/simple_animal/hostile/abnormality/contract/Life()
	. = ..()
	if(!breaching)
		return
	if(summon_count > 4)
		return
	if((summon_cooldown < world.time) && !(HAS_TRAIT(src, TRAIT_GODMODE)))
		Summon()
		summon_cooldown = world.time + summon_cooldown_time

/mob/living/simple_animal/hostile/abnormality/contract/try_working(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	if(ContractedUser(user, user.get_major_clothing_class()) && .)
		if(user in total_havers)
			say("Yes, yes... I remember the contract.")
	if(user in total_havers)
		return
	//SARGASSUM CLOTHJING STUFF
	NewContract(user, user.get_major_clothing_class())

/mob/living/simple_animal/hostile/abnormality/contract/proc/ContractedUser(mob/living/carbon/human/user, clothing_class)
	. = FALSE
	if(!(user in total_havers))
		return

	switch(clothing_class)
		if(CLOTHING_ARMORED)
			if(user in fort_havers)
				return TRUE

		if(CLOTHING_SCIENCE)
			if(user in prud_havers)
				return TRUE

		if(CLOTHING_SERVICE)
			if(user in temp_havers)
				return TRUE

		if(CLOTHING_ARMORED)
			if(user in just_havers)
				return TRUE

/mob/living/simple_animal/hostile/abnormality/contract/proc/NewContract(mob/living/carbon/human/user)
	if((user in total_havers))
		return
	switch(user.get_major_clothing_class())
		if(CLOTHING_ENGINEERING)
			if(fort_havers.len < total_per_contract)
				user.physiology.burn_mod = (fort_havers.len - 4)*-1
				fort_havers |= user
			else
				return

		if(CLOTHING_SCIENCE)
			if(prud_havers.len < total_per_contract)
				user.physiology.brain_mod = (prud_havers.len - 4)*-1
				prud_havers |= user
			else
				return

		if(CLOTHING_SERVICE)
			if(temp_havers.len < total_per_contract)
				user.physiology.brute_mod = (temp_havers.len - 4)*-1
				temp_havers |= user
			else
				return

		if(CLOTHING_ARMORED)
			if(just_havers.len < total_per_contract)
				user.physiology.tox_mod = (just_havers.len - 4)*-1
				just_havers |= user
			else
				return

	total_havers |= user
	say("Just sign here on the dotted line... and I'll take care of the rest.")
	return


//Meltdown
/mob/living/simple_animal/hostile/abnormality/contract/ZeroQliphoth(mob/living/carbon/human/user)
	. = ..()
	Summon()
	qliphoth_change(2)

/mob/living/simple_animal/hostile/abnormality/contract/BreachEffect(mob/living/carbon/human/user)//causes a runtime
	breaching = TRUE

/mob/living/simple_animal/hostile/abnormality/contract/proc/Summon(mob/living/carbon/human/user)
	// Don't need to lazylen this. If this is empty there is a SERIOUS PROBLEM.
	var/mob/living/simple_animal/hostile/abnormality/spawning = pick(spawnables)
	var/mob/living/simple_animal/hostile/abnormality/spawned = new spawning(get_turf(src))
	spawned.BreachEffect()
	spawned.color = "#000000"	//Make it black to look cool
	spawned.name = "???"
	spawned.desc = "What is that thing?"
	spawned.faction = list("hostile")
	summon_count += 1
