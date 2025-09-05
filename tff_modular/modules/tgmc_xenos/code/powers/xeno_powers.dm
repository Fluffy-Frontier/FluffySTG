/// TGMC_XENOS (old nova sector xenos)

/datum/action/cooldown/alien/tgmc
	button_icon = 'tff_modular/modules/tgmc_xenos/icons/xeno_actions.dmi'
	/// Some xeno abilities block other abilities from being used, this allows them to get around that in cases where it is needed
	var/can_be_used_always = FALSE

/datum/action/cooldown/alien/tgmc/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE

	if(can_be_used_always)
		return TRUE

	var/mob/living/carbon/alien/adult/tgmc/owner_alien = owner
	if(!istype(owner_alien) || owner_alien.unable_to_use_abilities)
		return FALSE


// Хил-аура дрона
/datum/action/cooldown/alien/tgmc/heal_aura
	name = "Healing Aura"
	desc = "Friendly xenomorphs in a short range around yourself will receive passive healing."
	button_icon_state = "healaura"
	plasma_cost = 100
	cooldown_time = 60 SECONDS
	/// Is the healing aura currently active or not
	var/aura_active = FALSE
	/// How long the healing aura should last
	var/aura_duration = 30 SECONDS
	/// How far away the healing aura should reach
	var/aura_range = 5
	/// How much brute/burn individually the healing aura should heal each time it fires
	var/aura_healing_amount = 5
	/// What color should the + particles caused by the healing aura be
	var/aura_healing_color = COLOR_BLUE_LIGHT
	/// The healing aura component itself that the ability uses
	var/datum/component/aura_healing/aura_healing_component

/datum/action/cooldown/alien/tgmc/heal_aura/Activate()
	. = ..()
	if(aura_active)
		owner.balloon_alert(owner, "already healing")
		return FALSE
	owner.balloon_alert(owner, "healing aura started")
	to_chat(owner, span_danger("We emit pheromones that encourage sisters near us to heal themselves for the next [aura_duration / 10] seconds."))
	addtimer(CALLBACK(src, PROC_REF(aura_deactivate)), aura_duration)
	aura_active = TRUE
	aura_healing_component = owner.AddComponent( \
		/datum/component/aura_healing, \
		range = aura_range, \
		requires_visibility = TRUE, \
		brute_heal = aura_healing_amount, \
		burn_heal = aura_healing_amount, \
		limit_to_trait = TRAIT_XENO_HEAL_AURA, \
		healing_color = aura_healing_color, \
	)
	return TRUE

/datum/action/cooldown/alien/tgmc/heal_aura/proc/aura_deactivate()
	if(!aura_active)
		return
	aura_active = FALSE
	QDEL_NULL(aura_healing_component)
	owner.balloon_alert(owner, "healing aura ended")


// Чуть более сильная хил-аура преторианца
/datum/action/cooldown/alien/tgmc/heal_aura/juiced
	name = "Strong Healing Aura"
	desc = "Friendly xenomorphs in a longer range around yourself will receive passive healing."
	button_icon_state = "healaura_juiced"
	plasma_cost = 100
	aura_range = 7
	aura_healing_amount = 10
	aura_healing_color = COLOR_RED_LIGHT


// Все сказано в названии подтипа. Только равагер имеет такое
#define RAVAGER_OUTLINE_EFFECT "ravager_endure_outline"

/datum/action/cooldown/alien/tgmc/literally_too_angry_to_die
	name = "Endure"
	desc = "Imbue your body with unimaginable amounts of rage (and plasma) to allow yourself to ignore all pain for a short time."
	button_icon_state = "literally_too_angry"
	plasma_cost = 250 //This requires full plasma to do, so there can be some time between armstrong moments
	/// If the endure ability is currently active or not
	var/endure_active = FALSE
	/// How long the endure ability should last when activated
	var/endure_duration = 20 SECONDS

/datum/action/cooldown/alien/tgmc/literally_too_angry_to_die/Activate()
	. = ..()
	if(endure_active)
		owner.balloon_alert(owner, "already enduring")
		return FALSE
	owner.balloon_alert(owner, "endure began")
	playsound(owner, 'tff_modular/modules/tgmc_xenos/sound/alien_roar1.ogg', 100, TRUE, 8, 0.9)
	to_chat(owner, span_danger("We numb our ability to feel pain, allowing us to fight until the very last for the next [endure_duration/10] seconds."))
	addtimer(CALLBACK(src, PROC_REF(endure_deactivate)), endure_duration)
	owner.add_filter(RAVAGER_OUTLINE_EFFECT, 4, outline_filter(1, COLOR_RED_LIGHT))
	ADD_TRAIT(owner, TRAIT_STUNIMMUNE, TRAIT_XENO_ABILITY_GIVEN)
	ADD_TRAIT(owner, TRAIT_NOSOFTCRIT, TRAIT_XENO_ABILITY_GIVEN)
	ADD_TRAIT(owner, TRAIT_NOHARDCRIT, TRAIT_XENO_ABILITY_GIVEN)
	endure_active = TRUE
	return TRUE

/datum/action/cooldown/alien/tgmc/literally_too_angry_to_die/proc/endure_deactivate()
	endure_active = FALSE
	owner.balloon_alert(owner, "endure ended")
	owner.remove_filter(RAVAGER_OUTLINE_EFFECT)
	REMOVE_TRAIT(owner, TRAIT_STUNIMMUNE, TRAIT_XENO_ABILITY_GIVEN)
	REMOVE_TRAIT(owner, TRAIT_NOSOFTCRIT, TRAIT_XENO_ABILITY_GIVEN)
	REMOVE_TRAIT(owner, TRAIT_NOHARDCRIT, TRAIT_XENO_ABILITY_GIVEN)

#undef RAVAGER_OUTLINE_EFFECT


#define EVASION_VENTCRAWL_INABILTY_CD_PERCENTAGE 0.8
#define RUNNER_BLUR_EFFECT "runner_evasion"

/datum/action/cooldown/alien/tgmc/evade
	name = "Evade"
	desc = "Allows you to evade any projectile that would hit you for a few seconds."
	button_icon_state = "evade"
	plasma_cost = 50
	cooldown_time = 60 SECONDS
	/// If the evade ability is currently active or not
	var/evade_active = FALSE
	/// How long evasion should last
	var/evasion_duration = 10 SECONDS

/datum/action/cooldown/alien/tgmc/evade/Activate()
	. = ..()
	if(evade_active) //Can't evade while we're already evading.
		owner.balloon_alert(owner, "already evading")
		return FALSE

	owner.balloon_alert(owner, "evasive movements began")
	playsound(owner, 'tff_modular/modules/tgmc_xenos/sound/alien_hiss.ogg', 100, TRUE, 8, 0.9)
	to_chat(owner, span_danger("We take evasive action, making us impossible to hit with projectiles for the next [evasion_duration / 10] seconds."))
	addtimer(CALLBACK(src, PROC_REF(evasion_deactivate)), evasion_duration)
	evade_active = TRUE
	RegisterSignal(owner, COMSIG_ATOM_PRE_BULLET_ACT, PROC_REF(on_projectile_hit))
	REMOVE_TRAIT(owner, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	addtimer(CALLBACK(src, PROC_REF(give_back_ventcrawl)), (cooldown_time * EVASION_VENTCRAWL_INABILTY_CD_PERCENTAGE)) //They cannot ventcrawl until the defined percent of the cooldown has passed
	to_chat(owner, span_warning("We will be unable to crawl through vents for the next [(cooldown_time * EVASION_VENTCRAWL_INABILTY_CD_PERCENTAGE) / 10] seconds."))
	return TRUE

/// Handles deactivation of the xeno evasion ability, mainly unregistering the signal and giving a balloon alert
/datum/action/cooldown/alien/tgmc/evade/proc/evasion_deactivate()
	evade_active = FALSE
	owner.balloon_alert(owner, "evasion ended")
	UnregisterSignal(owner, COMSIG_ATOM_PRE_BULLET_ACT)

/datum/action/cooldown/alien/tgmc/evade/proc/give_back_ventcrawl()
	ADD_TRAIT(owner, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	to_chat(owner, span_notice("We are rested enough to crawl through vents again."))

/// Handles if either BULLET_ACT_HIT or BULLET_ACT_FORCE_PIERCE happens to something using the xeno evade ability
/datum/action/cooldown/alien/tgmc/evade/proc/on_projectile_hit()
	SIGNAL_HANDLER

	if(owner.build_incapacitated(INCAPABLE_GRAB) || !isturf(owner.loc) || !evade_active)
		return

	owner.visible_message(span_danger("[owner] effortlessly dodges the projectile!"), span_userdanger("You dodge the projectile!"))
	playsound(get_turf(owner), pick('sound/items/weapons/bulletflyby.ogg', 'sound/items/weapons/bulletflyby2.ogg', 'sound/items/weapons/bulletflyby3.ogg'), 75, TRUE)
	owner.add_filter(RUNNER_BLUR_EFFECT, 2, gauss_blur_filter(5))
	addtimer(CALLBACK(owner, TYPE_PROC_REF(/datum, remove_filter), RUNNER_BLUR_EFFECT), 0.5 SECONDS)
	return COMPONENT_BULLET_PIERCED

#undef EVASION_VENTCRAWL_INABILTY_CD_PERCENTAGE
#undef RUNNER_BLUR_EFFECT


// Способность дефендера становиться настоящей крепостью
/datum/action/cooldown/alien/fortify
	name = "Fortify"
	desc = "Plant yourself for a large defensive boost."
	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED
	cooldown_time = 2 SECONDS
	button_icon = 'tff_modular/modules/tgmc_xenos/icons/xeno_actions.dmi'
	button_icon_state = "fortify"
	active_overlay_icon_state = "ab_goldborder"

	var/mob/living/carbon/alien/adult/tgmc/xeno_owner
	var/datum/armor/fortify_armor_type = /datum/armor/fortify_armor

/datum/armor/fortify_armor
	bomb = 40
	bullet = 75
	laser = 75
	fire = 75
	melee = 50

/datum/action/cooldown/alien/fortify/Destroy()
	set_fortify(FALSE)
	return ..()

/datum/action/cooldown/alien/fortify/Grant(mob/granted_to)
	. = ..()
	xeno_owner = owner

/datum/action/cooldown/alien/fortify/Activate(atom/target)
	. = ..()
	if(xeno_owner.fortify)
		set_fortify(FALSE)
		return

	set_fortify(TRUE)

/datum/action/cooldown/alien/fortify/is_action_active(atom/movable/screen/movable/action_button/current_button)
	return (xeno_owner && xeno_owner.fortify)

/datum/action/cooldown/alien/fortify/proc/set_fortify(on)
	if(xeno_owner.fortify == on)
		return
	if(on && xeno_owner.body_position == LYING_DOWN)
		xeno_owner.set_resting(FALSE, instant = TRUE)

	if(on)
		ADD_TRAIT(xeno_owner, TRAIT_IMMOBILIZED, TRAIT_XENO_FORTIFY)
		to_chat(xeno_owner, span_alertalien("We tuck ourselves into a defensive stance."))
		xeno_owner.set_armor(xeno_owner.get_armor().add_other_armor(fortify_armor_type))
	else
		REMOVE_TRAIT(xeno_owner, TRAIT_IMMOBILIZED, TRAIT_XENO_FORTIFY)
		to_chat(xeno_owner, span_alertalien("We resume our normal stance."))
		xeno_owner.set_armor(xeno_owner.get_armor().subtract_other_armor(fortify_armor_type))

	xeno_owner.anchored = on
	xeno_owner.fortify = on
	xeno_owner.resist_heavy_hits = on
	playsound(xeno_owner, 'sound/effects/stonedoor_openclose.ogg', 30, TRUE)
	build_all_button_icons(UPDATE_BUTTON_OVERLAY)
	xeno_owner.update_icons()
