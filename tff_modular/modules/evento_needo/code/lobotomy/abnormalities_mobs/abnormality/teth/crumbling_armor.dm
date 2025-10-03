#define STATUS_EFFECT_COWARDICE /datum/status_effect/cowardice
/mob/living/simple_animal/hostile/abnormality/crumbling_armor
	name = "Crumbling Armor"
	desc = "A thoroughly aged suit of samurai style armor with a V shaped crest on the helmet. It appears desuetude."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x48.dmi'
	icon_state = "crumbling"
	maxHealth = 600
	health = 600
	fear_level = TETH_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/daredevil,
		/datum/ego_datum/armor/daredevil,
	)
	gift_type = null
	gift_chance = 100
	secret_chance = TRUE
	secret_icon_state = "megalovania"

	observation_prompt = "The armor that took away many people's lives is sitting in front of you. <br>You can put it on, if you wish."


	var/buff_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegu_effects.dmi'
	var/user_armored
	var/numbermarked
	var/meltdown_cooldown //no spamming the meltdown effect
	var/meltdown_cooldown_time = 30 SECONDS
	var/armor_dispensed

/mob/living/simple_animal/hostile/abnormality/crumbling_armor/SuccessEffect(mob/living/carbon/human/user)
	qliphoth_change(1)
	var/datum/ego_gifts/recklessCourage/R = new
	user.Apply_Gift(R)
	if(!armor_dispensed) // You only get one of these. Ever.
		new /obj/item/clothing/suit/armor/ego_gear/he/crumbling_armor(get_turf(user))
		armor_dispensed = TRUE

/mob/living/simple_animal/hostile/abnormality/crumbling_armor/proc/Cut_Head(datum/source, datum/abnormality/datum_sent, mob/living/carbon/human/user, work_type)
	SIGNAL_HANDLER
	if(istype(user.ego_gift_list[HAT], /datum/ego_gifts/courage) || istype(user.ego_gift_list[HAT], /datum/ego_gifts/recklessCourage) || istype(user.ego_gift_list[HAT], /datum/ego_gifts/recklessFoolish) || istype(user.ego_gift_list[HAT], /datum/ego_gifts/foolish) || istype(user.ego_gift_list[HAT], /datum/ego_gifts/phase1) || istype(user.ego_gift_list[HAT], /datum/ego_gifts/phase2) || istype(user.ego_gift_list[HAT], /datum/ego_gifts/phase3) || istype(user.ego_gift_list[HAT], /datum/ego_gifts/phase4))
		if (work_type != ABNORMALITY_WORK_ATTACHMENT)
			return
		var/obj/item/bodypart/head/head = user.get_bodypart("head")
		//Thanks Red Queen
		if(!istype(head))
			return FALSE
		if(!isnull(user.ego_gift_list[HAT]) && istype(user.ego_gift_list[HAT], /datum/ego_gifts))
			var/datum/ego_gifts/removed_gift = user.ego_gift_list[HAT]
			removed_gift.Remove(user)
			//user.ego_gift_list[HAT].Remove(user)
		head.dismember()
		user.adjustBruteLoss(500)
		qliphoth_change(-1)
		return TRUE
	UnregisterSignal(user, COMSIG_WORK_STARTED)
	return FALSE

/mob/living/simple_animal/hostile/abnormality/crumbling_armor/PostWorkEffect(mob/living/carbon/human/user)
	. = ..()
	if (user.get_clothing_class_level(CLOTHING_ENGINEERING) < 2)
		var/obj/item/bodypart/head/head = user.get_bodypart("head")
		//Thanks Red Queen
		if(!istype(head))
			return
		head.dismember()
		user.adjustBruteLoss(500)
		qliphoth_change(-1)
		return
	if(user.stat != DEAD && user.get_major_clothing_class() == CLOTHING_ARMORED)
		if (src.icon_state == "megalovania")
			if(istype(user.ego_gift_list[HAT], /datum/ego_gifts/phase1)) // From Courage to Recklessness
				playsound(get_turf(user), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/crumbling/megalovania.ogg', 50, 0, 2)
				var/datum/ego_gifts/phase2/CAEG = new
				CAEG.datum_reference = datum_reference
				user.Apply_Gift(CAEG)
				to_chat(user, span_userdanger("How much more will it take?"))
				return
			if(istype(user.ego_gift_list[HAT], /datum/ego_gifts/phase2)) // From Recklessness to Foolishness
				playsound(get_turf(user), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/crumbling/megalovania.ogg', 50, 0, 2)
				var/datum/ego_gifts/phase3/CAEG = new
				CAEG.datum_reference = datum_reference
				user.Apply_Gift(CAEG)
				to_chat(user, span_userdanger("You need more strength!"))
				return
			if(istype(user.ego_gift_list[HAT], /datum/ego_gifts/phase3)) // From Foolishness to Suicidal
				playsound(get_turf(user), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/crumbling/megalovania.ogg', 50, 0, 2)
				var/datum/ego_gifts/phase4/CAEG = new
				CAEG.datum_reference = datum_reference
				user.Apply_Gift(CAEG)
				to_chat(user, span_userdanger("DETERMINATION."))
				return
			if(istype(user.ego_gift_list[HAT], /datum/ego_gifts/phase4)) // You can progress no further down this fool-hardy path
				return
			playsound(get_turf(user), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/crumbling/megalovania.ogg', 50, 0, 2)
			var/datum/ego_gifts/phase1/CAEG = new
			CAEG.datum_reference = datum_reference
			user.Apply_Gift(CAEG)
			RegisterSignal(user, COMSIG_WORK_STARTED, PROC_REF(Cut_Head))
			to_chat(user, span_userdanger("Just a drop of blood is what it takes..."))
		else
			if(istype(user.ego_gift_list[HAT], /datum/ego_gifts/courage)) // From Courage to Recklessness
				playsound(get_turf(user), 'sound/effects/magic/cosmic_expansion.ogg', 50, 0, 2)
				var/datum/ego_gifts/recklessCourage/CAEG = new
				CAEG.datum_reference = datum_reference
				user.Apply_Gift(CAEG)
				to_chat(user, span_userdanger("Your muscles flex with strength!"))
				return
			if(istype(user.ego_gift_list[HAT], /datum/ego_gifts/recklessCourage)) // From Recklessness to Foolishness
				playsound(get_turf(user), 'sound/effects/magic/cosmic_expansion.ogg', 50, 0, 2)
				var/datum/ego_gifts/recklessFoolish/CAEG = new
				CAEG.datum_reference = datum_reference
				user.Apply_Gift(CAEG)
				to_chat(user, span_userdanger("You feel like you could take on the world!"))
				return
			if(istype(user.ego_gift_list[HAT], /datum/ego_gifts/recklessFoolish)) // From Foolishness to Suicidal
				playsound(get_turf(user), 'sound/effects/magic/cosmic_expansion.ogg', 50, 0, 2)
				var/datum/ego_gifts/foolish/CAEG = new
				CAEG.datum_reference = datum_reference
				user.Apply_Gift(CAEG)
				to_chat(user, span_userdanger("You are a God among men!"))
				return
			if(istype(user.ego_gift_list[HAT], /datum/ego_gifts/foolish)) // You can progress no further down this fool-hardy path
				return
			playsound(get_turf(user), 'sound/effects/magic/cosmic_expansion.ogg', 50, 0, 2)
			var/datum/ego_gifts/courage/CAEG = new
			CAEG.datum_reference = datum_reference
			user.Apply_Gift(CAEG)
			RegisterSignal(user, COMSIG_WORK_STARTED, PROC_REF(Cut_Head))
			to_chat(user, span_userdanger("A strange power flows through you!"))
	return

/mob/living/simple_animal/hostile/abnormality/crumbling_armor/ZeroQliphoth(mob/living/carbon/human/user)
	qliphoth_change(3) //no need for qliphoth to be stuck at 0
	if(meltdown_cooldown > world.time)
		return
	meltdown_cooldown = world.time + meltdown_cooldown_time
	MeltdownEffect()
	return ..()

/mob/living/simple_animal/hostile/abnormality/crumbling_armor/proc/MeltdownEffect(mob/living/carbon/human/user)
	var/list/potentialmarked = list()
	var/list/marked = list()
	sound_to_playing_players(sound('tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/crumbling/globalwarning.ogg', volume = 25))
	for(var/mob/living/carbon/human/L in GLOB.player_list)
		if(faction_check_atom(L, FALSE) || L.stat >= HARD_CRIT || L.sanity_lost || z != L.z) // Dead or in hard crit, insane, or on a different Z level.
			continue
		potentialmarked += L
		to_chat(L, span_userdanger("You feel an overwhelming sense of dread."))

	numbermarked = 1 + round(LAZYLEN(potentialmarked) / 5, 1) //1 + 1 in 5 potential players, to the nearest whole number
	SLEEP_CHECK_DEATH(10 SECONDS, src)
	sound_to_playing_players(sound('tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/crumbling/warning.ogg', volume = 100))
	var/mob/living/Y
	for(var/i = numbermarked, i>=1, i--)
		if(potentialmarked.len <= 0)
			break
		Y = pick(potentialmarked)
		potentialmarked -= Y
		if(Y.stat == DEAD) //they chose to die instead of facing the fear
			continue
		marked+=Y
		playsound(get_turf(Y), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/crumbling/warning.ogg', 50, FALSE, -1)

	SLEEP_CHECK_DEATH(1 SECONDS, src)
	for(Y in marked)
		to_chat(Y, span_userdanger("Show me that you can stand your ground!"))
		new /obj/effect/temp_visual/markedfordeath(get_turf(Y))
		Y.apply_status_effect(STATUS_EFFECT_COWARDICE)

//status
/datum/status_effect/cowardice
	id = "cowardice"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 1 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/cowardice
	var/punishment_damage = 25

/atom/movable/screen/alert/status_effect/cowardice
	name = "Cowardice"
	desc = "Show me that you can stand your ground!"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/status_sprites.dmi'
	icon_state = "crumbling"

/datum/status_effect/cowardice/on_apply()
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(Punishment))
	return..()

/datum/status_effect/cowardice/on_remove()
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	return..()

/datum/status_effect/cowardice/proc/Punishment()
	SIGNAL_HANDLER
	var/mob/living/carbon/human/status_holder = owner
	if(!istype(status_holder))
		return
	var/obj/item/bodypart/head/holders_head = owner.get_bodypart("head")
	if(!istype(holders_head))
		return FALSE
	playsound(get_turf(status_holder), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/crumbling/attack.ogg', 50, FALSE)
	status_holder.apply_damage(punishment_damage, BRUTE)
	if(status_holder.health < 0)
		holders_head.dismember()
	new /obj/effect/temp_visual/slice(get_turf(status_holder))
	qdel(src)


//gifts
/datum/ego_gifts/courage
	name = "Inspired Courage"
	icon_state = "courage"
	slot = HAT

/datum/ego_gifts/recklessCourage
	name = "Reckless Courage"
	icon_state = "recklessFirst"
	slot = HAT

/datum/ego_gifts/recklessFoolish
	name = "Reckless Foolishness"
	icon_state = "recklessSecond"
	slot = HAT

/datum/ego_gifts/foolish
	name = "Reckless Foolishness"
	icon_state = "foolish"
	slot = HAT

/datum/ego_gifts/phase1
	name = "Lv 4"
	icon_state = "phase1"
	slot = HAT

/datum/ego_gifts/phase2
	name = "Lv 10"
	icon_state = "phase2"
	slot = HAT

/datum/ego_gifts/phase3
	name = "Lv 15"
	icon_state = "phase3"
	slot = HAT

/datum/ego_gifts/phase4
	name = "Lv 19"
	icon_state = "phase4"
	slot = HAT

#undef STATUS_EFFECT_COWARDICE
