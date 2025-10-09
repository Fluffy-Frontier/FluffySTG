#define BIGBIRD_HYPNOSIS_COOLDOWN (16 SECONDS)

/mob/living/simple_animal/hostile/abnormality/big_bird
	name = "Big Bird"
	desc = "A large, many-eyed bird that patrols the dark forest with an everlasting lamp. \
	Unlike regular birds, it lacks wings and instead has long arms with which it can pick things up."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x64.dmi'
	icon_state = "big_bird"
	icon_living = "big_bird"
	faction = list("hostile", "Apocalypse")
	speak_emote = list("chirps")

	pixel_x = -16
	base_pixel_x = -16

	ranged = TRUE
	maxHealth = 2000
	health = 2000
	damage_coeff = list(BURN = 1, BRAIN = 0.8, BRUTE = 1.2, TOX = 0.5)
	see_in_dark = 10
	stat_attack = HARD_CRIT

	move_to_delay = 5
	fear_level = WAW_LEVEL
	can_breach = TRUE
	light_color = COLOR_ORANGE
	light_range = 5
	light_power = 7

	// This stuff is only done to non-humans and objects
	melee_damage_type = BRUTE
	melee_damage_lower = 100
	melee_damage_upper = 100

	ego_list = list(
		/datum/ego_datum/weapon/lamp,
		/datum/ego_datum/armor/lamp,
	)
	gift_type =  /datum/ego_gifts/lamp
	grouped_abnos = list(
		/mob/living/simple_animal/hostile/abnormality/judgement_bird = 3,
		/mob/living/simple_animal/hostile/abnormality/punishing_bird = 3,
	)

	observation_prompt = "Dozens of blazing eyes are looking at one place. <br>\
		The bird that lived in the forest didn't like creatures being eaten by monsters. <br>\
		\"If I kill creatures first, no creatures will be killed by the monster.\" <br>\
		Every time the bird saved a life, it got an eye. <br>The big bird could not close those eyes no matter how tired it got. <br>\
		For monsters could come, hurting creatures at any time. <br>By the time eyes covered the whole body of the big bird, no one was around for it to protect. <br>\
		To shine the light in this dark forest, the big bird burned every single feather it had to make an everlasting lamp. <br>\
		The big bird now could hardly be called a bird now, it has no feathers at all."


	var/bite_cooldown
	var/bite_cooldown_time = 8 SECONDS
	var/hypnosis_cooldown
	var/hypnosis_cooldown_time = 16 SECONDS

	//PLAYABLES ATTACKS
	attack_action_types = list(/datum/action/cooldown/big_bird_hypnosis)

/datum/action/cooldown/big_bird_hypnosis
	name = "Dazzle"
	button_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/actions_abnormality.dmi'
	button_icon_state = "big_bird"
	check_flags = AB_CHECK_CONSCIOUS
	transparent_when_unavailable = TRUE
	cooldown_time = BIGBIRD_HYPNOSIS_COOLDOWN //16 seconds

/datum/action/cooldown/big_bird_hypnosis/Trigger(trigger_flags, atom/target)
	if(!..())
		return FALSE
	if(!istype(owner, /mob/living/simple_animal/hostile/abnormality/big_bird))
		return FALSE
	var/mob/living/simple_animal/hostile/abnormality/big_bird/big_bird = owner
	if(big_bird.IsContained()) // No more using cooldowns while contained
		return FALSE
	StartCooldown()
	big_bird.hypnotize()
	return TRUE


/mob/living/simple_animal/hostile/abnormality/big_bird/OpenFire()
	if(client)
		return

	if(get_dist(src, target) > 2 && hypnosis_cooldown <= world.time)
		hypnotize()

/mob/living/simple_animal/hostile/abnormality/big_bird/Initialize()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_MOB_DEATH, PROC_REF(on_mob_death)) // Hell

/mob/living/simple_animal/hostile/abnormality/big_bird/Destroy()
	UnregisterSignal(SSdcs, COMSIG_GLOB_MOB_DEATH)
	return ..()

/mob/living/simple_animal/hostile/abnormality/big_bird/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()
	if(!(HAS_TRAIT(src, TRAIT_GODMODE))) // Whitaker nerf
		playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/bigbird/step.ogg', 50, 1)

/mob/living/simple_animal/hostile/abnormality/big_bird/CanAttack(atom/the_target)
	if(ishuman(the_target))
		if(bite_cooldown > world.time)
			return FALSE
		var/mob/living/carbon/human/H = the_target
		var/obj/item/bodypart/head/head = H.get_bodypart("head")
		if(!istype(head)) // You, I'm afraid, are headless
			return FALSE
	return ..()

/mob/living/simple_animal/hostile/abnormality/big_bird/AttackingTarget(atom/attacked_target)
	if(ishuman(attacked_target))
		if(bite_cooldown > world.time)
			return FALSE
		var/mob/living/carbon/human/H = attacked_target
		var/obj/item/bodypart/head/head = H.get_bodypart("head")
		if(QDELETED(head))
			return
		head.dismember()
		QDEL_NULL(head)
		H.regenerate_icons()
		visible_message(span_danger("\The [src] bites [H]'s head off!"))
		new /obj/effect/gibspawner/generic/silent(get_turf(H))
		playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/bigbird/bite.ogg', 50, 1, 2)
		flick("big_bird_chomp", src)
		bite_cooldown = world.time + bite_cooldown_time
		return
	return ..()

/mob/living/simple_animal/hostile/abnormality/big_bird/proc/hypnotize()
	if(hypnosis_cooldown > world.time)
		return
	hypnosis_cooldown = world.time + hypnosis_cooldown_time
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/bigbird/hypnosis.ogg', 50, 1, 2)
	for(var/mob/living/carbon/C in view(8, src))
		if(faction_check_atom(C, FALSE))
			continue
		if(!CanAttack(C))
			continue
		if(ismoth(C))
			pick(C.emote("scream"), C.visible_message(span_boldwarning("[C] lunges for the light!")))
			C.throw_at((src), 10, 2)
		if(prob(66))
			to_chat(C, span_warning("You feel tired..."))
			C.set_eye_blur_if_lower(5)
			addtimer(CALLBACK (src, PROC_REF(tired_effect), C), 2 SECONDS)
			var/new_overlay = mutable_appearance('tff_modular/modules/evento_needo/icons/Teguicons/tegu_effects.dmi', "enchanted", -HALO_LAYER)
			C.add_overlay(new_overlay)
			addtimer(CALLBACK (C, TYPE_PROC_REF(/atom, cut_overlay), new_overlay), 4 SECONDS)

/mob/living/simple_animal/hostile/abnormality/big_bird/proc/tired_effect(mob/living/user)
	user.adjust_temp_blindness(2 SECONDS)
	user.Stun(2 SECONDS)

/mob/living/simple_animal/hostile/abnormality/big_bird/proc/on_mob_death(datum/source, mob/living/died, gibbed)
	SIGNAL_HANDLER
	if(!IsContained()) // If it's breaching right now
		return FALSE
	if(!ishuman(died))
		return FALSE
	if(died.z != z)
		return FALSE
	if(!died.mind)
		return FALSE
	qliphoth_change(-1) // One death reduces it
	return TRUE

#undef BIGBIRD_HYPNOSIS_COOLDOWN
