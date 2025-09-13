#define STATUS_EFFECT_LUNAR /datum/status_effect/lunar
//I will remind you all that this technically does NOT breach.	-Kirie
/mob/living/simple_animal/hostile/abnormality/luna
	name = "\proper Il Pianto della Luna"
	desc = "A piano, with a woman sitting on the stool next to it"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/96x48.dmi'
	icon_state = "dellaluna"
	maxHealth = 4000
	health = 4000
	damage_coeff = list(BURN = 1.2, BRAIN = 0, BRUTE = 1, TOX = 2)
	fear_level = WAW_LEVEL
	can_breach = TRUE
	pixel_x = -32
	base_pixel_x = -32
	ego_list = list(
		/datum/ego_datum/weapon/moonlight,
		/datum/ego_datum/armor/moonlight,
	)
	gift_type =  /datum/ego_gifts/moonlight
	observation_prompt = "You enter the containment unit as respectfully as you can, the woman by the piano does not acknowledge your presence, merely clutching her cane tighter. <br>\
		\"Begin.\" She commands, her lips a tight thin line. <br>It's the first time she's ever spoken. <br>\
		The piano waits for you expectantly."


	var/performance = FALSE
	var/performance_length = 60 SECONDS
	var/breach_length = 404 SECONDS		//How long the song is (when I finally finish it)
	var/has_breached = FALSE
	var/breached_monster
	var/killspawn
	update_qliphoth = 0
	neutral_chance = 50
	work_types = null

/mob/living/simple_animal/hostile/abnormality/luna/Move()
	return FALSE

/mob/living/simple_animal/hostile/abnormality/luna/CanAttack(atom/the_target)
	return FALSE

/mob/living/simple_animal/hostile/abnormality/luna/death(gibbed)
	if(breached_monster)
		qdel(breached_monster)
	..()

/mob/living/simple_animal/hostile/abnormality/luna/ZeroQliphoth(mob/living/carbon/human/user)
	. = ..()
	icon_state = "dellaluna_breach"
	//Normal breach
	var/turf/W = get_turf(pick(GLOB.generic_event_spawns))
	var/area/A = get_area(W)
	show_global_blurb(6 SECONDS, "Аномальная активность обнаружена в [A.name]", 2 SECONDS, "white", "black")
	var/mob/living/simple_animal/hostile/luna/spawningmonster = new(get_turf(W))
	breached_monster = spawningmonster
	addtimer(CALLBACK(src, PROC_REF(BreachEnd), user), breach_length)
	has_breached = TRUE
	if(client)
		mind.transfer_to(breached_monster) //For playable abnormalities, directly lets the playing currently controlling pianto get control of the spawned mob
	return

/mob/living/simple_animal/hostile/abnormality/luna/PostWorkEffect(mob/living/carbon/human/user)
	. = ..()
	qliphoth_change(-1)
	if(user.get_clothing_class_level(CLOTHING_SCIENCE) < 3)
		user.adjustSanityLoss(-500) // It's not stated in game but performing with level 3 prudence and lower make them instantly panic
	//and half your HP.
	user.adjustBruteLoss(user.maxHealth*0.5)

/mob/living/simple_animal/hostile/abnormality/luna/try_working(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	to_chat(user, span_nicegreen("Please wait until the performance is completed."))
	addtimer(CALLBACK(src, PROC_REF(PerformanceEnd), user), performance_length)
	for(var/mob/living/carbon/human/L in GLOB.player_list)
		L.apply_status_effect(STATUS_EFFECT_LUNAR)
	if(!performance)
		performance = TRUE
		playsound(user, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/luna/moonlight_sonata.ogg', 100, FALSE, 28)	//Let the people know.
	if(has_breached)	//You will have to start a new performance to delete the has_breached abno.
		killspawn = TRUE

/mob/living/simple_animal/hostile/abnormality/luna/proc/BreachEnd(mob/living/carbon/human/user)
	qliphoth_change(3)
	has_breached = FALSE
	icon_state = "dellaluna"
	qdel(breached_monster)


/mob/living/simple_animal/hostile/abnormality/luna/proc/PerformanceEnd(mob/living/carbon/human/user)
	if(has_breached && killspawn)
		BreachEnd()

	killspawn = FALSE
	performance = FALSE
	to_chat(user, span_nicegreen("The performance is completed."))

/* Monster Half */
/mob/living/simple_animal/hostile/luna
	name = "La Luna"
	desc = "A tall, cloaked figure."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x64.dmi'
	icon_state = "luna"
	base_pixel_x = -8
	pixel_x = -8
	health = 2600
	maxHealth = 2600
	melee_damage_type = BRUTE
	damage_coeff = list(BURN = 1.2, BRAIN = 0, BRUTE = 1, TOX = 2)
	melee_damage_lower = 32
	melee_damage_upper = 41
	rapid_melee = 2
	robust_searching = TRUE
	ranged = TRUE
	stat_attack = HARD_CRIT
	del_on_death = TRUE
	attack_verb_continuous = "beats"
	attack_verb_simple = "beat"
	wander = TRUE
	var/aoeactive
	var/canaoe = TRUE
	var/aoerange = 5
	var/aoedamage = 60

//mob/living/simple_animal/hostile/luna/Initialize()
//Cannot figure out how to make this stop
//	..()
//	playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/luna/mvmt3.ogg', 180, FALSE, 28)	//Let the people know.

/mob/living/simple_animal/hostile/luna/Move()
	if(aoeactive)
		return FALSE
	..()

/mob/living/simple_animal/hostile/luna/OpenFire()
	if(!canaoe)
		return
	aoeactive = TRUE
	canaoe = FALSE
	playsound(src, 'sound/effects/magic/wandodeath.ogg', 200, FALSE, 9)
	addtimer(CALLBACK(src, PROC_REF(AOE)), 9)
	addtimer(CALLBACK(src, PROC_REF(Reset)), 7 SECONDS)


/mob/living/simple_animal/hostile/luna/proc/AOE()
	for(var/turf/T in view(aoerange, src))
		new /obj/effect/temp_visual/revenant(T)
		HurtInTurf(T, list(), aoedamage, BRUTE, check_faction = TRUE, hurt_mechs = TRUE)
	aoeactive = FALSE

/mob/living/simple_animal/hostile/luna/proc/Reset()
	canaoe = TRUE

//Lunar
//Just the classic La Luna buff
/datum/status_effect/lunar
	id = "lunar"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 60 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/lunar

/atom/movable/screen/alert/status_effect/lunar
	name = "Lunar Blessing"
	desc = "Your temperance is buffed for a short period of time."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/status_sprites.dmi'
	icon_state = "lunar"

/datum/status_effect/lunar/on_apply()
	. = ..()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/status_holder = owner
	status_holder.physiology.tox_mod -= 0.1
	status_holder.physiology.brute_mod -= 0.1

/datum/status_effect/lunar/on_remove()
	. = ..()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/status_holder = owner
	status_holder.physiology.tox_mod += 0.1
	status_holder.physiology.brute_mod += 0.1

#undef STATUS_EFFECT_LUNAR
