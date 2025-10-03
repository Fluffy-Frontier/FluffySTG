#define STATUS_EFFECT_DANGLE /datum/status_effect/dangle
/mob/living/simple_animal/hostile/abnormality/dingledangle
	name = "Dingle-Dangle"
	desc = "A cone that goes up to the ceiling with a ribbon tied around it. Bodies are strung up around it, seeming to be tied to the ceiling."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x96.dmi'
	icon_state = "dangle"
	maxHealth = 600
	health = 600
	fear_level = TETH_LEVEL

	pixel_x = -16
	base_pixel_x = -16
	ego_list = list(
		/datum/ego_datum/weapon/lutemia,
		/datum/ego_datum/armor/lutemia
	)
	gift_type = /datum/ego_gifts/lutemis
	gift_message = "Let's all become fruits. Let's hang together. Your despair, sadness... Let's all dangle down."
	observation_prompt = "You pass by the containment cell and, in the corner of your eye, spy your comrades dangling from ribbons, furiously scratching at their necks in choked agony."

	var/static/list/generic_hallucinations = list(
		/datum/hallucination/bolts,
		/datum/hallucination/chat,
		/datum/hallucination/death,
		/datum/hallucination/fake_flood,
		/datum/hallucination/fire,
		/datum/hallucination/message,
		/datum/hallucination/oh_yeah,
		/datum/hallucination/xeno_attack,
	)

//Introduction to our hallucinations. This is a global hallucination, but it's all it really does.
/mob/living/simple_animal/hostile/abnormality/dingledangle/ZeroQliphoth(mob/living/carbon/human/user)
	var/list/hallucination_args = list(pick(generic_hallucinations), "mass hallucination")
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		H._cause_hallucination(hallucination_args)
	qliphoth_change(3)

/mob/living/simple_animal/hostile/abnormality/dingledangle/PostWorkEffect(mob/living/carbon/human/user, work_type, pe, work_time, canceled)
	. = ..()
	//if your prudence is low, give a short hallucination, apply the buff, and lower counter.
	if(user.get_clothing_class_level(CLOTHING_SCIENCE) < 3) // below level 3
		var/list/hallucination_args = list(pick(generic_hallucinations), "mass hallucination")
		user._cause_hallucination(hallucination_args)
		user.apply_status_effect(STATUS_EFFECT_DANGLE)
		qliphoth_change(-1)
		return

	if(user.get_clothing_class_level(CLOTHING_ENGINEERING) >= 4) // fort 4 or higher
		return

	//I mean it does this in wonderlabs
	//But here's the twist: You get a better ego.
	if(user && !canceled)
		var/location = get_turf(user)
		new /obj/item/clothing/suit/armor/ego_gear/he/lutemis(location)
	if(user?.stat != DEAD) //dusting sets you dead before the animation, we don't want to dust user twice after failing work
		user.gib(DROP_ALL_REMAINS)

/mob/living/simple_animal/hostile/abnormality/dingledangle/FailureEffect(mob/living/carbon/human/user)
	if(prob(50))
		//Yeah dust them too. No ego this time tho
		user.gib(DROP_ALL_REMAINS)

/atom/movable/screen/alert/status_effect/dangle
	name = "That Woozy Feeling"
	desc = "Your combat senses have sharpened even as you feel your mind dangling."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/status_sprites.dmi'
	icon_state = "rest"

//A simple 5 minute stat bonus increase
/datum/status_effect/dangle
	id = "dangle"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 5 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/dangle

/datum/status_effect/dangle/on_apply()
	. = ..()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/status_holder = owner
	status_holder.physiology.tox_mod += 0.15

/datum/status_effect/dangle/on_remove()
	. = ..()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/status_holder = owner
	status_holder.physiology.tox_mod -= 0.15
