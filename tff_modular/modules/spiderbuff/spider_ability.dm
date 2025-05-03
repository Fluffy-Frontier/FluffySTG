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
