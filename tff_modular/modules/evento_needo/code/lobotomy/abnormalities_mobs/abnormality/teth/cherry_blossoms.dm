#define STATUS_EFFECT_MARKEDFORDEATH /datum/status_effect/markedfordeath
/mob/living/simple_animal/hostile/abnormality/cherry_blossoms
	name = "Grave of Cherry Blossoms"
	desc = "A beautiful cherry tree."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/128x128.dmi'
	icon_state = "graveofcherryblossoms_3"
	pixel_x = -48
	base_pixel_x = -48
	pixel_y = -16
	base_pixel_y = -16
	maxHealth = 600
	health = 600
	fear_level = TETH_LEVEL
	good_hater = TRUE

	ego_list = list(
		/datum/ego_datum/weapon/blossom,
		/datum/ego_datum/armor/blossom,
	)
	gift_type = /datum/ego_gifts/blossom
	observation_prompt = "The tree is adorned with beautiful leaves growing here and there. <br>\
		The kind of sight you could never even hope to see in this dark and dreary place. <br>\
		You can take a moment to take in the beauty before you begin to work."


	var/number_of_marks = 5

/mob/living/simple_animal/hostile/abnormality/cherry_blossoms/Move()
	return FALSE

/mob/living/simple_animal/hostile/abnormality/cherry_blossoms/CanAttack(atom/the_target)
	return FALSE

/mob/living/simple_animal/hostile/abnormality/cherry_blossoms/PostWorkEffect(mob/living/carbon/human/user)
	if(user.sanity_lost)
		qliphoth_change(-1)

/mob/living/simple_animal/hostile/abnormality/cherry_blossoms/SuccessEffect(mob/living/carbon/human/user)
	if(prob(70))
		qliphoth_change(-1)
	if(datum_reference.qliphoth_meter !=3)
		icon_state = "graveofcherryblossoms_[datum_reference.qliphoth_meter]"

/mob/living/simple_animal/hostile/abnormality/cherry_blossoms/ZeroQliphoth(mob/living/carbon/human/user)
	INVOKE_ASYNC(src, PROC_REF(mark_for_death))
	icon_state = "graveofcherryblossoms_0"
	qliphoth_change(3)

/mob/living/simple_animal/hostile/abnormality/cherry_blossoms/proc/mark_for_death()
	var/list/potentialmarked = list()
	var/list/marked = list()

	for(var/mob/living/carbon/human/L in GLOB.player_list)
		if(L.stat >= HARD_CRIT || L.sanity_lost || z != L.z) // Dead or in hard crit, insane, or on a different Z level.
			continue
		potentialmarked += L
		to_chat(L, span_danger("It's cherry blossom season."))

	SLEEP_CHECK_DEATH(10 SECONDS, src)
	for(var/blossoming in 1 to number_of_marks)
		var/mob/living/Y = pick(potentialmarked)
		if(faction_check_atom(Y, FALSE) || Y.z != z || Y.stat == DEAD)
			continue
		if(Y in marked)
			continue
		marked += Y
		new /obj/effect/temp_visual/markedfordeath(get_turf(Y))
		to_chat(Y, span_userdanger("You feel like you're going to die!"))
		Y.apply_status_effect(STATUS_EFFECT_MARKEDFORDEATH)

//Mark for Death
//A very quick, frantic 10 seconds of instadeath.
/datum/status_effect/markedfordeath
	id = "markedfordeath"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 10 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/marked

/atom/movable/screen/alert/status_effect/marked
	name = "Marked For Death"
	desc = "You are marked for death. You will die when struck."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/status_sprites.dmi'
	icon_state = "marked_for_death"

/datum/status_effect/markedfordeath/on_apply()
	. = ..()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/status_holder = owner
	status_holder.physiology.burn_mod *= 3
	status_holder.physiology.brain_mod *= 3
	status_holder.physiology.brute_mod *= 3
	status_holder.physiology.tox_mod *= 3

/datum/status_effect/markedfordeath/tick()
	var/mob/living/carbon/human/status_holder = owner
	if(status_holder.sanity_lost)
		status_holder.death()
	if(owner.stat != DEAD)
		return
	for(var/mob/living/carbon/human/affected_human in GLOB.player_list)
		if(affected_human.stat == DEAD)
			continue
		affected_human.adjustBruteLoss(-500) // It heals everyone to full
		affected_human.adjustSanityLoss(-500) // It heals everyone to full
		affected_human.remove_status_effect(STATUS_EFFECT_MARKEDFORDEATH)

/datum/status_effect/markedfordeath/on_remove()
	. = ..()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/status_holder = owner
	status_holder.physiology.burn_mod /= 3
	status_holder.physiology.brain_mod /= 3
	status_holder.physiology.brute_mod /= 3
	status_holder.physiology.tox_mod /= 3

#undef STATUS_EFFECT_MARKEDFORDEATH
