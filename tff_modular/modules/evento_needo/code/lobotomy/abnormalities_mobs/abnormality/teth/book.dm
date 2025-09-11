/mob/living/simple_animal/hostile/abnormality/book
	name = "Book Without Pictures or Dialogue"
	desc = "An old, dusty tome. There is a pen within the folded pages."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "book_0"
	maxHealth = 600
	health = 600
	blood_volume = 0
	fear_level = TETH_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/page,
		/datum/ego_datum/armor/page,
	)
	gift_type = /datum/ego_gifts/page
	observation_prompt = "It's just a stupid rumour. <br>\"If you fill it in whatever way, then the book will grant one wish!\" <br>\
		All the newbies crow, waiting for their chance to fill the pages with their wishes. <br>\
		You open the book and read through every wish, splotched with ink and tears, every employee had, living and dead, wrote..."


	var/wordcount = 0
	var/list/oddities = list() //List gets populated with friendly animals
	var/list/nasties = list( //Todo: Eventually make a list of custom threats possibly
		/mob/living/simple_animal/hostile/ordeal/green_bot,
		/mob/living/simple_animal/hostile/ordeal/indigo_dawn,
		/mob/living/simple_animal/hostile/ordeal/violet_fruit,
	)
	var/meltdown_cooldown //no spamming the meltdown effect
	var/meltdown_cooldown_time = 30 SECONDS
	var/breaching = FALSE
	var/summon_count = 0
	var/summon_amount = 0//defaults to between 3 and 5


/mob/living/simple_animal/hostile/abnormality/book/PostWorkEffect(mob/living/carbon/human/user)
	if(user.get_major_clothing_class() == CLOTHING_ARMORED)
		if(wordcount)
			if(Approach(user))
				visible_message(span_warning("[user] starts ripping pages out of [src]!"))
				playsound(get_turf(src), 'sound/items/poster/poster_ripped.ogg', 50, 1, FALSE)
				RipPages()
				wordcount = 0
				icon_state = "book_[wordcount]"
	else
		if(wordcount < 3)
			if(Approach(user))
				visible_message(span_warning("[user] begins writing in [src]!"))
				playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/book/scribble.ogg', 90, 1, FALSE)
				SLEEP_CHECK_DEATH(3 SECONDS, src)
				if(wordcount < 3)
					wordcount ++
				icon_state = "book_[wordcount]"
	return ..()

/mob/living/simple_animal/hostile/abnormality/book/proc/Approach(mob/living/carbon/human/user)
	if(user.sanity_lost || user.stat >= SOFT_CRIT)
		return FALSE
	icon_state = "book_[wordcount]"
	user.Stun(5 SECONDS)
	step_towards(user, src)
	sleep(0.5 SECONDS)
	if(QDELETED(user))
		return FALSE
	step_towards(user, src)
	sleep(0.5 SECONDS)
	return TRUE

//Special breach-related stuff, pretty much copied off a contract signed
/mob/living/simple_animal/hostile/abnormality/book/Initialize()
	//We'll use the global_friendly_animal_types list. It's empty by default, so we need to populate it.
	if(!GLOB.friendly_animal_types.len)
		for(var/T in typesof(/mob/living/simple_animal))
			var/mob/living/simple_animal/SA = T
			if(initial(SA.gold_core_spawnable) == FRIENDLY_SPAWN)
				GLOB.friendly_animal_types += SA
	oddities += GLOB.friendly_animal_types

	//We need a list of all abnormalities that are TETH and can breach
	var/list/queue = subtypesof(/mob/living/simple_animal/hostile/abnormality)
	for(var/i in queue)
		var/mob/living/simple_animal/hostile/abnormality/abno = i
		if(!(initial(abno.can_spawn)) || !(initial(abno.can_breach)))
			continue
		if((initial(abno.fear_level)) <= TETH_LEVEL)
			nasties += abno
	return ..()

/mob/living/simple_animal/hostile/abnormality/book/Life()
	. = ..()
	if(!breaching)
		return
	if(summon_count > 10)
		qdel(src)
		return
	if(meltdown_cooldown < world.time)
		meltdown_cooldown = world.time + meltdown_cooldown_time
		MeltdownEffect(summon_amount)

/mob/living/simple_animal/hostile/abnormality/book/Move()
	return FALSE

/mob/living/simple_animal/hostile/abnormality/book/CanAttack(atom/the_target)
	return FALSE

/mob/living/simple_animal/hostile/abnormality/book/proc/RipPages()
	var/mob/living/simple_animal/newspawn
	if(wordcount >= 3)
		newspawn = pick(oddities)
		SpawnMob(newspawn)
		return
	else
		qliphoth_change(-wordcount)

/mob/living/simple_animal/hostile/abnormality/book/proc/SpawnMob(mob/living/simple_animal/newspawn)
	var/mob/living/simple_animal/spawnedmob = new newspawn(get_turf(src))
	if(isabnormalitymob(spawnedmob))
		var/mob/living/simple_animal/hostile/abnormality/abno = spawnedmob
		abno.BreachEffect()
	if(spawnedmob.butcher_results)
		spawnedmob.butcher_results = list(/obj/item/paper = 1)
	spawnedmob.loot = list(/obj/item/paper = 1)
	var/inverted_icon
	var/icon/papericon = icon("[spawnedmob.icon]", spawnedmob.icon_state) //create inverted colors icon
	papericon.MapColors(0.8,0.8,0.8, 0.2,0.2,0.2, 0.8,0.8,0.8, 0,0,0)
	inverted_icon = papericon
	spawnedmob.icon = inverted_icon
	spawnedmob.desc = "It looks like a [spawnedmob.name] but made of paper."
	spawnedmob.name = "Paper [initial(spawnedmob.name)]"
	spawnedmob.faction = list("hostile")
	spawnedmob.maxHealth = (spawnedmob.maxHealth / 10)
	spawnedmob.health = spawnedmob.maxHealth
	spawnedmob.death_message = "collapses into a bunch of writing material."
	spawnedmob.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=0, color=rgb(0, 0, 0))
	spawnedmob.blood_volume = 0
	src.visible_message(span_warning("Pages of [src] fold into [spawnedmob]!"))
	playsound(get_turf(src), 'sound/items/handling/paper_pickup.ogg', 90, 1, FALSE)

/mob/living/simple_animal/hostile/abnormality/book/ZeroQliphoth(mob/living/carbon/human/user)
	if(meltdown_cooldown > world.time)
		return
	meltdown_cooldown = world.time + meltdown_cooldown_time
	MeltdownEffect()

/mob/living/simple_animal/hostile/abnormality/book/proc/MeltdownEffect(spawn_num)
	if(!spawn_num)
		spawn_num = rand(3,5)
	for(var/i=1, i<=spawn_num, i++)
		addtimer(CALLBACK(src, PROC_REF(MeltdownEffect_second)), 0.5 SECONDS)

/mob/living/simple_animal/hostile/abnormality/book/proc/MeltdownEffect_second()
	var/mob/living/simple_animal/newspawn
	newspawn = pick(nasties)
	SpawnMob(newspawn)
	if(breaching)
		summon_count += 1

/mob/living/simple_animal/hostile/abnormality/book/BreachEffect(mob/living/carbon/human/user)
	breaching = TRUE
	summon_amount = 2
