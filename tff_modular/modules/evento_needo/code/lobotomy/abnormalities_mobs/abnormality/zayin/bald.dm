/mob/living/simple_animal/hostile/abnormality/bald
	name = "You’re Bald..."
	desc = "A helpful sphere, you think."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	icon_state = "bald1"
	icon_living = "bald1"
	maxHealth = 50
	health = 50
	damage_coeff = list(BURN = 2, BRAIN = 0, BRUTE = 2, TOX = 2)
	fear_level = ZAYIN_LEVEL
	melee_damage_lower = -1
	melee_damage_upper = -1
	melee_damage_type = BRUTE
	attack_verb_continuous = "balds"
	attack_verb_simple = "bald"

	ranged = TRUE
	ranged_message = "balds"
	projectiletype = /obj/projectile/beam/yang/bald
	projectilesound = 'sound/items/weapons/sear.ogg'

	ego_list = list(
		/datum/ego_datum/weapon/tough,
		/datum/ego_datum/armor/tough,
	)
	gift_type =  /datum/ego_gifts/tough
	gift_chance = 10
	gift_message = "Now we're feeling awesome!"

	secret_chance = TRUE
	secret_name = "Шампунь Жумайсынба"

	update_qliphoth = -1
	action_cooldown = 15 SECONDS

	var/bald_users = list()
	work_types = null

/mob/living/simple_animal/hostile/abnormality/bald/examine(mob/user)
	. = ..()
	. += "This abnormality is filled with dreams of bald people. Are you balding, or already bald?"

/mob/living/simple_animal/hostile/abnormality/bald/try_working(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	var/chance = 25
	if(HAS_TRAIT(user, TRAIT_BALD))
		chance = 45
		user.adjustSanityLoss(-user.maxSanity * 0.05) // Half of sanity restored for bald people
	if(prob(chance))
		user.apply_bald()
	if(!do_bald(user)) // Already bald
		return
	bald_users |= user.ckey
	update_icon()
	switch(length(bald_users))
		if(2)
			for(var/mob/living/carbon/human/H in view(18, user))
				if(prob(35))
					do_bald(H)
		if(4)
			for(var/mob/living/carbon/human/H in view(36, user))
				if(prob(35))
					do_bald(H)
		if(6) // Everyone is bald! Awesome!
			for(var/mob/living/carbon/human/H in GLOB.human_list)
				if(H.z == z)
					do_bald(H)

/mob/living/simple_animal/hostile/abnormality/bald/ZeroQliphoth(mob/living/carbon/human/user)
	can_breach = TRUE
	return ..()

/mob/living/simple_animal/hostile/abnormality/bald/proc/do_bald(mob/living/carbon/human/victim)
	if(!HAS_TRAIT(victim, TRAIT_BALD))
		ADD_TRAIT(victim, TRAIT_BALD, "ABNORMALITY_BALD")
		victim.set_hairstyle("Bald")
		victim.playsound_local(victim, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/bald/bald_special.ogg', 50, FALSE)
		victim.add_overlay(icon('tff_modular/modules/evento_needo/icons/Teguicons/tegu_effects.dmi', "bald_blast"))
		addtimer(CALLBACK(victim, TYPE_PROC_REF(/atom, cut_overlay), \
								icon('tff_modular/modules/evento_needo/icons/Teguicons/tegu_effects.dmi', "bald_blast")), 20)
		to_chat(victim, span_notice("You feel awesome!"))
		return TRUE
	return FALSE

/mob/living/simple_animal/hostile/abnormality/bald/update_icon_state()
	switch(length(bald_users))
		if(3 to 5)
			icon_state = "bald2"
		if(6 to INFINITY)
			icon_state = "bald3"
		else
			icon_state = "bald1"
	return ..()

/mob/living/simple_animal/hostile/abnormality/bald/ListTargets()
	. = ..()
	for(var/mob/living/carbon/human/not_bald in .)
		if(HAS_TRAIT(not_bald, TRAIT_BALD))
			. -= not_bald

/mob/living/simple_animal/hostile/abnormality/bald/AttackingTarget(atom/attacked_target)
	. = ..()
	if(ishuman(attacked_target))
		var/mob/living/carbon/human/H = attacked_target
		do_bald(H)

/mob/living/simple_animal/hostile/abnormality/bald/Login()
	. = ..()
	if(!.)
		return
	to_chat(src, span_userdanger("You do not do damage, your sole mission is to spread the glory of baldness to all."))

/obj/projectile/beam/yang/bald
	name = "bald beam"
	damage = 0

/obj/projectile/beam/yang/bald/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/victim = target
	if(!HAS_TRAIT(victim, TRAIT_BALD))
		to_chat(victim, span_notice("You feel awesome!"))
		ADD_TRAIT(victim, TRAIT_BALD, "ABNORMALITY_BALD")
		victim.set_hairstyle("Bald")
	return

//status effect - BALD IS AWESOME
/datum/status_effect/bald_heal
	id = "bald_heal"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 30 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/bald_heal

/atom/movable/screen/alert/status_effect/bald_heal
	name = "Bald is Awesome!"
	desc = "The power of baldness is renerating HP and SP. Having more bald people around helps!"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/status_sprites.dmi'
	icon_state = "bald"

/datum/status_effect/bald_heal/tick()
	. = ..()
	var/mob/living/carbon/human/status_holder = owner
	var/heal_amount = 1
	for(var/mob/living/carbon/potentiallybaldperson in view(7, owner))
		if(HAS_TRAIT(potentiallybaldperson, TRAIT_BALD))
			heal_amount += 1
	heal_amount = clamp(heal_amount, 1, 5) // We don't want people somehow figuring out 1 billion healing
	status_holder.adjustBruteLoss(-heal_amount)
	status_holder.adjustSanityLoss(-heal_amount)

//Mob Proc
/mob/living/proc/apply_bald()
	var/datum/status_effect/bald_heal/B = src.has_status_effect(/datum/status_effect/bald_heal)
	if(!B)
		src.apply_status_effect(/datum/status_effect/bald_heal)
	else
		B.refresh()
