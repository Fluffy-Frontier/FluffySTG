/mob/living/simple_animal/hostile/abnormality/kikimora
	name = "Kikimora"
	desc = "A beaked woman with one leg idly sweeping the floor with a broom."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x48.dmi'
	icon_state = "kikimora"
	icon_living = "kikimora"
	icon_dead = "kikimora"
	maxHealth = 1300
	health = 1300
	rapid_melee = 1
	melee_queue_distance = 2
	move_to_delay = 3
	damage_coeff = list(BURN = 1, BRAIN = 1, BRUTE = 1, TOX = 1.5, BRUTE = 2)
	fear_level = TETH_LEVEL
	death_message = "falls over."
	ego_list = list(
	/datum/ego_datum/weapon/kikimora,
	/datum/ego_datum/armor/kikimora,
	)
	gift_type = null

	//envy due to being a curse
/mob/living/simple_animal/hostile/abnormality/kikimora/ZeroQliphoth(mob/living/carbon/human/user)
	. = ..()
	if(GLOB.generic_event_spawns.len)
		var/turf/W = get_turf(pick(GLOB.start_landmarks_list))
		W = locate(W.x + rand(1,3), W.y + rand(1,3), W.z)
		var/obj/effect/decal/cleanable/crayon/cognito/kikimora/K = new (get_turf(W))
		K.dir = pick(WEST, EAST)
	qliphoth_change(2)

/mob/living/simple_animal/hostile/abnormality/kikimora/examine(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.apply_status_effect(/datum/status_effect/kikimora)
		to_chat(H, span_mind_control("Kikimora."))

//Graffiti
/obj/effect/decal/cleanable/crayon/cognito/kikimora
	name = "graffiti"
	desc = "Kikimora?"
	icon_state = "kikimora"
	mergeable_decal = TRUE
	var/inflicted_effect = /datum/status_effect/kikimora
	var/uses_left = 2

/obj/effect/decal/cleanable/crayon/cognito/kikimora/Initialize(mapload, main, type, e_name, graf_rot, alt_icon, desc_override)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/effect/decal/cleanable/crayon/cognito/kikimora/proc/on_entered(datum/source, atom/movable/entered)
	if(!ishuman(entered))
		return
	var/mob/living/carbon/human/user = entered
	if(user.has_status_effect(inflicted_effect))
		return
	user.apply_status_effect(inflicted_effect)
	uses_left--
	if(!uses_left)
		qdel(src)

//Status Effect
/datum/status_effect/kikimora
	id = "kikimora"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 10 MINUTES
	alert_type = null
	on_remove_on_mob_delete = TRUE
	var/words_per_say = 1
	var/static/spread_cooldown = 0
	var/spread_cooldown_delay = 5 SECONDS
	var/static/words_taken = list()

/datum/status_effect/kikimora/on_apply()
	. = ..()
	RegisterSignal(owner, COMSIG_MOB_SAY, PROC_REF(CorruptWords))
	RegisterSignal(owner, COMSIG_LIVING_STATUS_SLEEP, PROC_REF(Bedtime))

/datum/status_effect/kikimora/proc/Bedtime()
	SIGNAL_HANDLER
	var/turf/T = get_turf(owner)
	var/obj/item/food/offering = locate(/obj/item/food) in T
	if(offering)
		if(!(offering.foodtypes & JUNKFOOD) && !(offering.foodtypes & RAW) && !(offering.foodtypes & GROSS) && !(offering.foodtypes & TOXIC))
			playsound(get_turf(owner),'sound/items/eatfood.ogg', 50, TRUE)
			qdel(offering)
			qdel(src)
		else
			to_chat(owner, span_notice("You sense something examined your offering of food."))

/datum/status_effect/kikimora/proc/CorruptWords(datum/source, list/speech_args)
	SIGNAL_HANDLER
	var/words_to_take = words_per_say
	var/words_said = 0

	var/message = speech_args[SPEECH_MESSAGE]
	var/list/split_message = splittext(message, " ") //List each word in the message
	for (var/i in 1 to length(split_message))
		if(findtext(split_message[i], "*") || findtext(split_message[i], ";") || findtext(split_message[i], ":") || findtext(split_message[i], "kiki") || findtext(split_message[i], "mora"))
			continue
		var/standardize_text = uppertext(split_message[i])
		if(standardize_text in words_taken)
			split_message[i] = pick("kiki", "mora")
			//Higher chance of spreading if the user said kiki or mora alot.
			words_said++
			continue
		//Unsure if this is processor intensive.
		if(prob(25) && words_to_take > 0)
			words_taken += standardize_text
			words_to_take--

	message = jointext(split_message, " ")
	speech_args[SPEECH_MESSAGE] = message

	//Infection Mechanic
	if(ishuman(owner))
		var/mob/living/carbon/human/L = owner
		if(spread_cooldown <= world.time)
			for(var/mob/living/carbon/human/H in hearers(7, L))
				if(prob(5 * words_said))
					H.apply_status_effect(/datum/status_effect/kikimora)
			spread_cooldown = world.time + spread_cooldown_delay
