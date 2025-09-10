/mob/living/simple_animal/hostile/abnormality/skub
	name = "Skub"
	desc = "It's skub."
	health = 500
	maxHealth = 500
	icon = 'icons/obj/maintenance_loot.dmi'
	icon_state = "skub"
	icon_living = "skub"
	wander = FALSE

	ego_list = list(
		/datum/ego_datum/weapon/pro_skub,
		/datum/ego_datum/weapon/anti_skub,
		/datum/ego_datum/armor/pro_skub,
		/datum/ego_datum/armor/anti_skub,
	)
	//gift_type =  /datum/ego_gifts/skub
	var/list/currently_insane = list()
	var/insanity_counter
	var/riot_cooldown
	var/riot_cooldown_time = 60 SECONDS
	var/list/skub_list = list("PRO_SKUB" = list(), "ANTI_SKUB" = list())
	var/skub_type = "skub"
	var/riot_time = 30 SECONDS

//work stuff
/mob/living/simple_animal/hostile/abnormality/skub/attackby(obj/item/attacking_item, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(!.)
		return
	for(var/mob/living/carbon/human/H in GLOB.alive_player_list)
		if(H.z != z)
			continue
		UpdateSkub(H)
	if(prob(25))
		qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/skub/ZeroQliphoth(mob/living/carbon/human/user)
	..()
	riot_cooldown = world.time + riot_cooldown_time
	var/list/target_list = list()
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(H.z != z)
			continue
		if(H.stat == DEAD)
			continue
		target_list += H
		UpdateSkub(H)
		if(IsProSkub(H))
			to_chat(H, span_boldwarning("Your dedication to [skub_type] reaches a fever pitch!"))
		else
			to_chat(H, span_boldwarning("You can't stop thinking about how much you hate [skub_type]!"))
	//sleep(3 SECONDS)
	for(var/mob/living/carbon/human/H in target_list)
		H.adjustSanityLoss(500)
		QDEL_NULL(H.ai_controller)
		if(IsProSkub(H))
			H.ai_controller = /datum/ai_controller/insane/murder/skub
			H.apply_status_effect(/datum/status_effect/panicked_type/skub)
		else
			H.ai_controller = /datum/ai_controller/insane/murder/anti_skub
			H.apply_status_effect(/datum/status_effect/panicked_type/anti_skub)

		H.InitializeAIController()
	addtimer(CALLBACK(src, PROC_REF(StopRiot)), riot_time)

/mob/living/simple_animal/hostile/abnormality/skub/proc/UpdateSkub(mob/living/carbon/human/skubber)
	if(!skubber)
		return
	if(skubber in skub_list["PRO_SKUB"])
		return
	if(skubber in skub_list["ANTI_SKUB"])
		return
	if(LAZYLEN(skub_list["PRO_SKUB"]) <= LAZYLEN(skub_list["ANTI_SKUB"]))
		skub_list["PRO_SKUB"] |= skubber
		to_chat(skubber, span_boldwarning("You've become pro-[skub_type]!"))
	else
		skub_list["ANTI_SKUB"] |= skubber
		to_chat(skubber, span_boldwarning("You've become anti-[skub_type]!"))
		return

/mob/living/simple_animal/hostile/abnormality/skub/proc/IsProSkub(mob/living/skubber)
	if(!(skubber in skub_list))
		UpdateSkub(skubber)
	if(skubber in skub_list["PRO_SKUB"])
		return TRUE
	return FALSE

/mob/living/simple_animal/hostile/abnormality/skub/proc/StopRiot()
	for(var/mob/living/carbon/human/H in skub_list["PRO_SKUB"])
		H.adjustSanityLoss(-500)
	for(var/mob/living/carbon/human/H in skub_list["ANTI_SKUB"])
		H.adjustSanityLoss(-500)
	qliphoth_change(3)

/datum/status_effect/panicked_type/skub
	icon = "murder"

/datum/ai_controller/insane/murder/skub
	lines_type = /datum/ai_behavior/say_line/skub

/datum/ai_behavior/say_line/skub
	lines = list(
		"I LOVE SKUB!",
		"THAT'S MY SKUB!!!",
		"I stand with skub!",
		"Protect skub!",
	)

/datum/ai_controller/insane/murder/skub/CanTarget(atom/movable/thing)
	. = ..()
	var/mob/living/living_thing = thing
	if(. && istype(living_thing))
		if(ishuman(living_thing))
			var/mob/living/carbon/human/H = living_thing
			if(HAS_AI_CONTROLLER_TYPE(H, src))
				return FALSE

/datum/ai_controller/insane/murder/skub/on_Crossed(datum/source, atom/movable/AM)
	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		if(HAS_AI_CONTROLLER_TYPE(H, src))
			return
	..()

/datum/status_effect/panicked_type/anti_skub
	icon = "murder"

/datum/ai_controller/insane/murder/anti_skub
	lines_type = /datum/ai_behavior/say_line/anti_skub

/datum/ai_behavior/say_line/anti_skub
	lines = list(
		"I HATE FUCKING SKUB!",
		"GIVE ME THAT!",
		"I'll destroy that skub myself!",
		"Down with skub!",
	)

/datum/ai_controller/insane/murder/anti_skub/CanTarget(atom/movable/thing)
	. = ..()
	var/mob/living/living_thing = thing
	if(. && istype(living_thing))
		if(ishuman(living_thing))
			var/mob/living/carbon/human/H = living_thing
			if(HAS_AI_CONTROLLER_TYPE(H, src))
				return FALSE

/datum/ai_controller/insane/murder/anti_skub/on_Crossed(datum/source, atom/movable/AM)
	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		if(HAS_AI_CONTROLLER_TYPE(H, src))
			return
	..()
