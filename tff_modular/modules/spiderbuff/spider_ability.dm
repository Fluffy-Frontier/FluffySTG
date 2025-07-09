#define isvent(A) (istype(A, /obj/machinery/atmospherics/components/unary/vent_pump))

// Лечебная Аура, используется нурсами
/datum/action/cooldown/heal_aura_spider
	name = "Healing Aura"
	desc = "Friendly spiders in a short range around yourself will receive passive healing."
	button_icon = 'tff_modular/modules/tgmc_xenos/icons/xeno_actions.dmi'
	button_icon_state = "healaura_juiced"
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"
	cooldown_time = 120 SECONDS
	/// Is the healing aura currently active or not
	var/aura_active = FALSE
	/// How long the healing aura should last
	var/aura_duration = 125
	/// We need to see our target to heal.
	var/requires_visibility = TRUE
	/// How far away the healing aura should reach
	var/aura_range = 8
	/// How much brute/burn individually the healing aura should heal each time it fires
	var/aura_healing_amount = 5
	/// What color should the + particles caused by the healing aura be
	var/aura_healing_color = COLOR_BUBBLEGUM_RED
	/// The healing aura component itself that the ability uses
	var/datum/component/aura_healing/aura_healing_component

/datum/action/cooldown/heal_aura_spider/Activate()
	. = ..()
	if(aura_active)
		owner.balloon_alert(owner, "already healing")
		return FALSE
	owner.balloon_alert(owner, "healing aura started")
	to_chat(owner, span_danger("We emit pheromones that encourage sisters near us to heal themselves for the next [aura_duration / 10] seconds."))
	addtimer(CALLBACK(src, PROC_REF(aura_deactivate)), aura_duration)
	aura_active = TRUE
	aura_healing_component = owner.AddComponent(/datum/component/aura_healing, range = aura_range, requires_visibility = TRUE, brute_heal = aura_healing_amount, burn_heal = aura_healing_amount, limit_to_trait = TRAIT_WEB_SURFER, healing_color = aura_healing_color)
	return TRUE

/datum/action/cooldown/heal_aura_spider/proc/aura_deactivate()
	if(!aura_active)
		return
	aura_active = FALSE
	QDEL_NULL(aura_healing_component)
	owner.balloon_alert(owner, "healing aura ended")

/obj/projectile/toxin
	damage = 15
	damage_type = TOX
	hit_prone_targets = TRUE
	ignore_range_hit_prone_targets = TRUE
	dismemberment = 0
	armour_penetration = 100
	icon_state = "neurotoxin"

/obj/projectile/toxin/viper
	damage = 20

/obj/projectile/toxin/midwife
	damage = 25

/datum/action/cooldown/mob_cooldown/invisibility
	name = "Invisibility"
	desc = "Makes you invisible for 7 seconds"
	button_icon = 'icons/mob/actions/actions_animal.dmi'
	button_icon_state = "sniper_zoom"
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"
	cooldown_time = 25 SECONDS
	melee_cooldown_time = 0 SECONDS
	click_to_activate = FALSE

/datum/action/cooldown/mob_cooldown/invisibility/Activate()
	. = ..()
	var/mob/living/basic/affecting = owner
	affecting.apply_status_effect(/datum/status_effect/invisibility)

/datum/status_effect/invisibility
	id = "Invisible"
	duration = 7 SECONDS
	alert_type = null
	remove_on_fullheal = TRUE
	var/inv_alpha = 1
	var/animation_time = 0.5 SECONDS

/datum/status_effect/invisibility/on_apply()
	animate(owner, alpha = inv_alpha, time = animation_time)
	owner.balloon_alert(owner, "you blend into the environment")
	ADD_TRAIT(owner, TRAIT_SNEAK, ACTION_TRAIT)

/datum/status_effect/invisibility/on_remove()
	animate(owner, alpha = initial(owner.alpha), time = animation_time)
	owner.balloon_alert(owner, "you reveal yourself")
	REMOVE_TRAIT(owner, TRAIT_SNEAK, ACTION_TRAIT)

/datum/action/cooldown/mob_cooldown/charge/basic_charge/spider
	name = "Tarantula Charge"
	shake_duration = 0.5
	knockdown_duration = 1 SECONDS
	charge_delay = 1 SECONDS
	charge_distance = 6

/datum/action/cooldown/spell/scream
	name = "Spider's Scream"
	desc = "Spider emits a loud scream, that confuses and deafens humans, may overload cyborgs sensors."
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "emp"
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"
	cooldown_time = 25 SECONDS
	sound = 'sound/effects/screech.ogg'
	spell_requirements = NONE

/datum/action/cooldown/spell/scream/cast(atom/cast_on)
	. = ..()
	for(var/mob/living/M in get_hearers_in_view(4, owner))
		if(iscarbon(M))
			var/mob/living/carbon/C = M
			var/obj/item/organ/ears/ears = C.get_organ_slot(ORGAN_SLOT_EARS)
			if(ears)
				ears.adjustEarDamage(0, 30)
			C.adjust_confusion(25 SECONDS)
			C.set_jitter_if_lower(100 SECONDS)

		if(issilicon(M))
			SEND_SOUND(M, sound('sound/items/weapons/flash.ogg'))
			M.Paralyze(rand(100,200))
	return TRUE

/datum/component/member_of_hive

/datum/component/member_of_hive/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOB_TRY_SPEECH, PROC_REF(on_try_speech))

/datum/component/member_of_hive/proc/on_try_speech(mob/living/spider, message, ignore_spam, forced)
	SIGNAL_HANDLER
	spider.log_talk(message, LOG_SAY, tag = "blob hivemind telepathy")
	var/spanned_message = spider.say_quote(message)
	var/rendered = span_hierophant("<b>\[Spider Telepathy\] [spider.name]</b> [spanned_message]")
	relay_to_list_and_observers(rendered, GLOB.spider_telepathy_mobs, spider, MESSAGE_TYPE_RADIO)
	return COMPONENT_CANNOT_SPEAK

#undef isvent
