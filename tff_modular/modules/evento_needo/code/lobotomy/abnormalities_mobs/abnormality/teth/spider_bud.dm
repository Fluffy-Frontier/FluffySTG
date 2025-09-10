/mob/living/simple_animal/hostile/abnormality/spider
	name = "Spider Bud"
	desc = "An abnormality that resembles a massive spider. Tread carefully"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x48.dmi'
	icon_state = "spider_closed"
	maxHealth = 1500
	health = 1500
	fear_level = TETH_LEVEL
	pixel_x = -8
	base_pixel_x = -8
	damage_coeff = list(BURN = 1.2, BRAIN = 2, BRUTE = 0.8, TOX = 2)
	good_hater = TRUE
	ego_list = list(
		/datum/ego_datum/weapon/eyes,
		/datum/ego_datum/armor/eyes,
	)
	gift_type =  /datum/ego_gifts/redeyes
	var/summon_count = 0
	var/summon_cooldown
	var/summon_cooldown_time = 30 SECONDS
	var/summon_group_size = 2
	var/summon_maximum = 0
	observation_prompt = "I am a spider. <br>I eat anything my web catches. <br>I am starving. <br>\
		I haven't eaten anything for days. <br>There is a big prey hanging on my web. <br>\
		My starvation could kill me if I don't eat something."


	/// Filled with ckeys of people who broke our cocoons, they need to pay if they dare mess with us
	var/list/metagame_list = list()

/mob/living/simple_animal/hostile/abnormality/spider/Move()
	return FALSE

/mob/living/simple_animal/hostile/abnormality/spider/Destroy()
	metagame_list = null
	return ..()

/mob/living/simple_animal/hostile/abnormality/spider/Life()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_GODMODE))
		return
	if(summon_count >= summon_maximum)
		return
	if(summon_cooldown < world.time)
		SummonGuys()

/mob/living/simple_animal/hostile/abnormality/spider/PostWorkEffect(mob/living/carbon/human/user)
	// If you do insight or have low prudence, fuck you and die for stepping on a spider
	if(user.get_major_clothing_class() == CLOTHING_SCIENCE )
		balloon_alert(user, "too smart for me")
		return

	turn_into_burger(user)

/mob/living/simple_animal/hostile/abnormality/spider/proc/turn_into_burger(mob/living/carbon/human/user, skip_waiting = FALSE)
	icon_state = "spider_open"
	if(HAS_TRAIT(user, TRAIT_GODMODE))
		manual_emote("stares at [user], visibly annoyed.")
		icon_state = "spider_closed"
		return

	var/obj/structure/spider/cocoon/spider_bud/casing = SpawnConnectedStructure(/obj/structure/spider/cocoon/spider_bud, rand(-1, 1), rand(-1, 1))
	casing.spooder = src
	user.forceMove(casing)

	user.death()

	icon_state = "spider_closed"

/mob/living/simple_animal/hostile/abnormality/spider/BreachEffect(mob/living/carbon/human/user, breach_type)
	icon_state = "spider_active"
	summon_maximum = 12
	SummonGuys()
	if(breach_type == BREACH_MINING)
		summon_maximum = 6

/mob/living/simple_animal/hostile/abnormality/spider/proc/SummonGuys(summon_type)
	summon_cooldown = world.time + summon_cooldown_time
	for(var/i = 1 to summon_group_size)
		var/turf/target_turf = get_turf(src)
		new /mob/living/simple_animal/hostile/bud_spider(target_turf)
		summon_count += 1

/obj/structure/spider/cocoon/spider_bud
	desc = "Something wrapped in silky spider web. You should probably not destroy this."

	/// Whoever controls us, meant for spider bud
	var/mob/living/simple_animal/hostile/abnormality/spider/spooder

/obj/structure/spider/cocoon/spider_bud/Initialize()
	. = ..()
	pixel_x = rand(-16, 16)
	pixel_y = rand(-10, 20)
	icon_state = "cocoon_large[rand(1, 3)]"

/obj/structure/spider/cocoon/spider_bud/Destroy()
	if(!istype(spooder))
		return ..()

	for(var/mob/living/carbon/human/sinner in oview(2, src))
		if(sinner.stat == DEAD || isnull(sinner.ckey))
			continue

		if(!spooder.metagame_list[sinner.ckey])
			spooder.metagame_list += sinner.ckey
			spooder.metagame_list[sinner.ckey] = 0

		spooder.metagame_list[sinner.ckey] += 1
		sinner.apply_damage(50 * spooder.metagame_list[sinner.ckey], BRUTE)
		to_chat(sinner, span_userdanger("As the cocoon breaks tiny spiders swarm you and tear out some of your flesh before returning to [spooder]!"))
		if(sinner.stat == DEAD) // if they are dead after our attack, burger them
			spooder.turn_into_burger(sinner, TRUE)

	return ..()

/mob/living/simple_animal/hostile/bud_spider
	name = "Spiderling"
	desc = "The offspring of spider bud."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x64.dmi'
	icon_state = "spider_minion"
	icon_living = "spider_minion"
	base_pixel_x = -8
	maxHealth = 300
	health = 300
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	damage_coeff = list(BURN = 1, BRAIN = 1, BRUTE = 1.2, TOX = 0.8, BRUTE = 2)
	faction = list("hostile", "spider")
	melee_damage_lower = 3
	melee_damage_upper = 7
	melee_damage_type = BRUTE
	obj_damage = 3
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/amber/dawn_dead.ogg'
	density = TRUE
	move_to_delay = 2
	del_on_death = TRUE
	stat_attack = DEAD
