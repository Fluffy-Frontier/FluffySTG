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
	button_icon_state = "web_sneak"
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"
	cooldown_time = 25 SECONDS
	melee_cooldown_time = 0 SECONDS
	click_to_activate = FALSE
	var/duration = 7 SECONDS
	var/inv_alpha = 1
	var/animation_time = 0.5

/datum/action/cooldown/mob_cooldown/invisibility/Activate()
	. = ..()
	var/mob/living/basic/spider/affecting = owner
	animate(affecting, alpha = inv_alpha, time = animation_time)
	affecting.balloon_alert(affecting, "you blend into the environment")
	ADD_TRAIT(affecting, TRAIT_SNEAK, ACTION_TRAIT)
	addtimer(CALLBACK(src, PROC_REF(deactivate), affecting), duration)

/datum/action/cooldown/mob_cooldown/invisibility/proc/deactivate(mob/living/basic/spider/affecting)
	if(QDELETED(affecting) || !HAS_TRAIT_FROM(affecting, TRAIT_SNEAK, ACTION_TRAIT))
		return

	REMOVE_TRAIT(affecting, TRAIT_SNEAK, ACTION_TRAIT)
	affecting.balloon_alert(affecting, "you reveal yourself")
	animate(owner, alpha = initial(owner.alpha), time = animation_time)

/datum/action/cooldown/mob_cooldown/charge/basic_charge/spider
	name = "Tarantula Charge"
	shake_duration = 0.5
	knockdown_duration = 1 SECONDS
	charge_delay = 1 SECONDS
	charge_distance = 6

/datum/component/member_of_hive

/datum/component/member_of_hive/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOB_TRY_SPEECH, PROC_REF(on_try_speech))
	RegisterSignal(parent, COMSIG_LIVING_DEATH, PROC_REF(on_death))

/datum/component/member_of_hive/proc/on_death(mob/living/spider, gibbed, message)
	SIGNAL_HANDLER
	spider.log_talk(message, LOG_SAY, tag = "Spider telepathy")
	var/rendered = span_hierophant("<b>\[Spider Telepathy\] [spider.name]</b> has died in [get_area(spider)]!")
	relay_to_list_and_observers(rendered, GLOB.spider_telepathy_mobs, src, MESSAGE_TYPE_RADIO)

/datum/component/member_of_hive/proc/on_try_speech(mob/living/spider, message, ignore_spam, forced)
	SIGNAL_HANDLER
	spider.log_talk(message, LOG_SAY, tag = "Spider telepathy")
	var/spanned_message = spider.say_quote(message)
	var/rendered = span_hierophant("<b>\[Spider Telepathy\] [spider.name]</b> [spanned_message]")
	relay_to_list_and_observers(rendered, GLOB.spider_telepathy_mobs, spider, MESSAGE_TYPE_RADIO)
	return COMPONENT_CANNOT_SPEAK

/datum/action/cooldown/spell/guard_rage
	name = "Rage Mode"
	desc = "Prevents you from regenerating and you begin to take passive damage, but increases damage by 5 and descreases melee attack cooldown. 10 Seconds duration."
	button_icon = 'tff_modular/modules/spiderbuff/icons/icons.dmi'
	button_icon_state = "Eye"
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"
	cooldown_time = 30 SECONDS
	melee_cooldown_time = 0 SECONDS
	click_to_activate = FALSE
	spell_requirements = NONE
	var/duration = 10 SECONDS

/datum/action/cooldown/spell/guard_rage/Activate(atom/target)
	. = ..()
	var/mob/living/basic/spider/affecting = owner
	affecting.regeneration_per_tick += 4
	affecting.melee_damage_lower += 5
	affecting.melee_damage_upper += 5
	affecting.melee_attack_cooldown -= 1
	addtimer(CALLBACK(src, PROC_REF(deactivate), affecting), duration)
	ADD_TRAIT(affecting, TRAIT_EVIL, ACTION_TRAIT)

/datum/action/cooldown/spell/guard_rage/proc/deactivate(mob/living/basic/spider/affecting)
	if(QDELETED(affecting) || !HAS_TRAIT_FROM(affecting, TRAIT_EVIL, ACTION_TRAIT))
		return

	REMOVE_TRAIT(affecting, TRAIT_EVIL, ACTION_TRAIT)
	affecting.regeneration_per_tick -= 4
	affecting.melee_damage_lower -= 5
	affecting.melee_damage_upper -= 5
	affecting.melee_attack_cooldown += 1

/datum/action/cooldown/mob_cooldown/lay_web/strong

/datum/action/cooldown/mob_cooldown/lay_web/strong/plant_web(turf/target_turf, obj/structure/spider/stickyweb/existing_web)
	if (existing_web)
		qdel(existing_web)
		new /obj/structure/spider/stickyweb/sealed/strong(target_turf)
		return
	new /obj/structure/spider/stickyweb/strong(target_turf)


/obj/structure/spider/stickyweb/strong
	max_integrity = 20

/obj/structure/spider/stickyweb/strong/Initialize(mapload)
	. = ..()
	add_filter("brown_web", 10, list("type" = "outline", "color" = "#c7974eff", "size" = 0.1))

/obj/structure/spider/stickyweb/sealed/strong
	max_integrity = 20

/obj/structure/spider/stickyweb/sealed/strong/Initialize(mapload)
	. = ..()
	add_filter("brown_web", 10, list("type" = "outline", "color" = "#c7974eff", "size" = 0.1))

