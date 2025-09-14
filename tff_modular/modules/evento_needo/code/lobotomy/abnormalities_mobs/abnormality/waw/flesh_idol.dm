/mob/living/simple_animal/hostile/abnormality/flesh_idol
	name = "Flesh Idol"
	desc = "A cross with flesh stapled in the middle."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x96.dmi'
	icon_state = "flesh_idol"
	maxHealth = 600
	health = 600
	fear_level = WAW_LEVEL
	pixel_x = -16
	base_pixel_x = -16

	ego_list = list(
		/datum/ego_datum/weapon/heart,
		/datum/ego_datum/armor/heart,
	)
	gift_type = /datum/ego_gifts/heart
	observation_prompt = "I've been praying for 7 days and 7 nights, my skin is taut from malnutrition, my eyes bloodshot from lack of sleep and my clothes soiled with my own filth. <br>\
		Though my throat is so dry I cannot even maintain the chants I move my lips anyway. <br>\
		Is anyone even listening? <br>Does my prayer reach Him? <br>All I ask for is a sign."


	var/counter_interval = 5 MINUTES
	var/next_counter_gain //What was the next time you gain Qlip?
	var/reset_time = 1 MINUTES
	var/damage_amount = 14
	var/run_num = 2		//How many things you breach

	var/list/blacklist = list(
		/mob/living/simple_animal/hostile/abnormality/melting_love,
		///mob/living/simple_animal/hostile/abnormality/distortedform,
		/mob/living/simple_animal/hostile/abnormality/white_night,
		/mob/living/simple_animal/hostile/abnormality/nihil,
		/mob/living/simple_animal/hostile/abnormality/galaxy_child,
		/mob/living/simple_animal/hostile/abnormality/fetus,
		/mob/living/simple_animal/hostile/abnormality/crying_children,
	)

/mob/living/simple_animal/hostile/abnormality/flesh_idol/Initialize()
	addtimer(CALLBACK(src, PROC_REF(counter_check)), counter_interval)
	return ..()

/mob/living/simple_animal/hostile/abnormality/flesh_idol/proc/counter_check()
	if(IsContained())
		qliphoth_change(1)

/mob/living/simple_animal/hostile/abnormality/flesh_idol/PostWorkEffect(mob/living/carbon/human/user)
	. = ..()
	//heal amount
	var/heal_amount = 10

	for(var/mob/living/carbon/human/H in GLOB.alive_player_list)
		if(H.stat != DEAD)
			H.adjustBruteLoss(-heal_amount) // It heals everyone by 50 or 100 points
			H.adjustSanityLoss(-heal_amount) // It heals everyone by 50 or 100 points
			new /obj/effect/temp_visual/healing(get_turf(H))

	var/list/damtypes = list(BRUTE, TOX, BRAIN, BURN)
	var/damage = pick(damtypes)
	user.apply_damage(damage_amount, damage) // take 5 random damage each time

//Meltdown
/mob/living/simple_animal/hostile/abnormality/flesh_idol/ZeroQliphoth(mob/living/carbon/human/user)
	addtimer(CALLBACK (src, PROC_REF(qliphoth_change), 4), reset_time)
	var/list/total_abnormalities = list()

	for(var/mob/living/simple_animal/hostile/abnormality/A in GLOB.abnormality_mob_list)
		if(A.datum_reference.qliphoth_meter > 0 && A.IsContained() && !(A.type in blacklist) && A.z == z)
			total_abnormalities += A

	if(!LAZYLEN(total_abnormalities))
		return

	var/mob/living/simple_animal/hostile/abnormality/processing = pick(total_abnormalities)
	processing.qliphoth_change(-200)
