//

#define RAVAGER_OUTLINE_EFFECT "ravager_endure_outline"
#define EVASION_VENTCRAWL_INABILTY_CD_PERCENTAGE 0.8
#define RUNNER_BLUR_EFFECT "runner_evasion"

// Наши личные нейротоксичные гланды, большую часть мехаана которых по хорошему бы на ТГ перенести, ведь у этих куда большая возможность настройки без боли
/datum/action/cooldown/alien/acid/tgmc
	name = "Spit Neurotoxin"
	desc = "Spits neurotoxin at someone, exhausting them."
	button_icon = 'tff_modular/modules/tgmc_xenos/icons/xeno_actions.dmi'
	button_icon_state = "neurospit_0"
	plasma_cost = 40
	/// A singular projectile? Use this one and leave acid_casing null
	var/acid_projectile = /obj/projectile/neurotoxin/tgmc
	/// You want it to be more like a shotgun style attack? Use this one and make acid_projectile null
	var/acid_casing
	/// Used in to_chat messages to the owner
	var/projectile_name = "neurotoxin"
	/// The base icon for the ability, so a red box can be put on it using _0 or _1
	var/button_base_icon = "neurospit"
	/// The sound that should be played when the xeno actually spits
	var/spit_sound = 'tff_modular/modules/tgmc_xenos/sound/alien_spitacid.ogg'
	shared_cooldown = MOB_SHARED_COOLDOWN_3
	cooldown_time = 5 SECONDS

/datum/action/cooldown/alien/acid/tgmc/IsAvailable(feedback = FALSE)
	return ..() && isturf(owner.loc)

/datum/action/cooldown/alien/acid/tgmc/set_click_ability(mob/on_who)
	. = ..()
	if(!.)
		return

	to_chat(on_who, span_notice("You prepare your [projectile_name] gland. <B>Left-click to fire at a target!</B>"))

	button_icon_state = "[button_base_icon]_1"
	build_all_button_icons()
	on_who.update_icons()

/datum/action/cooldown/alien/acid/tgmc/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	if(!.)
		return

	if(refund_cooldown)
		to_chat(on_who, span_notice("You empty your [projectile_name] gland."))

	button_icon_state = "[button_base_icon]_0"
	build_all_button_icons()
	on_who.update_icons()

/datum/action/cooldown/alien/acid/tgmc/InterceptClickOn(mob/living/clicker, params, atom/target)
	. = ..()
	if(!.)
		unset_click_ability(clicker, refund_cooldown = FALSE)
		return FALSE

	var/turf/user_turf = clicker.loc
	var/turf/target_turf = get_step(clicker, target.dir)
	if(!isturf(target_turf))
		return FALSE

	var/modifiers = params2list(params)
	clicker.visible_message(
		span_danger("[clicker] spits [projectile_name]!"),
		span_alertalien("You spit [projectile_name]."),
	)

	if(acid_projectile)
		var/obj/projectile/spit_projectile = new acid_projectile(clicker.loc)
		spit_projectile.aim_projectile(target, clicker, modifiers)
		spit_projectile.firer = clicker
		spit_projectile.fire()
		playsound(clicker, spit_sound, 100, TRUE, 5, 0.9)
		clicker.newtonian_move(get_dir(target_turf, user_turf))
		return TRUE

	if(acid_casing)
		var/obj/item/ammo_casing/casing = new acid_casing(clicker.loc)
		playsound(clicker, spit_sound, 100, TRUE, 5, 0.9)
		casing.fire_casing(target, clicker, null, null, null, ran_zone(), 0, clicker)
		clicker.newtonian_move(get_dir(target_turf, user_turf))
		return TRUE

	CRASH("Neither acid_projectile or acid_casing are set on [clicker]'s spit attack!")

/datum/action/cooldown/alien/acid/tgmc/Activate(atom/target)
	return TRUE


// Летальная версия плевка
/datum/action/cooldown/alien/acid/tgmc/lethal
	name = "Spit Acid"
	desc = "Spits neurotoxin at someone, burning them."
	acid_projectile = /obj/projectile/neurotoxin/tgmc/acid
	button_icon_state = "acidspit_0"
	projectile_name = "acid"
	button_base_icon = "acidspit"


// Версия плевка, котоырй работает как дробовик
/datum/action/cooldown/alien/acid/tgmc/spread
	name = "Spit Neurotoxin Spread"
	desc = "Spits a spread neurotoxin at someone, exhausting them."
	plasma_cost = 50
	acid_projectile = null
	acid_casing = /obj/item/ammo_casing/xenospit
	spit_sound = 'tff_modular/modules/tgmc_xenos/sound/alien_spitacid2.ogg'
	cooldown_time = 10 SECONDS

// Немного хренового кода, но блин, какой же прошлый кодер крутой, что нашел такой забавный способ)
/obj/item/ammo_casing/xenospit //This is probably really bad, however I couldn't find any other nice way to do this
	name = "big glob of neurotoxin"
	projectile_type = /obj/projectile/neurotoxin/tgmc/spitter_spread
	pellets = 3
	variance = 20

/obj/item/ammo_casing/xenospit/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/caseless)

/obj/item/ammo_casing/xenospit/tk_firing(mob/living/user, atom/fired_from)
	return FALSE


// Летальная версия дробовик-плевка
/datum/action/cooldown/alien/acid/tgmc/spread/lethal
	name = "Spit Acid Spread"
	desc = "Spits a spread of acid at someone, burning them."
	acid_projectile = null
	acid_casing = /obj/item/ammo_casing/xenospit/spread/lethal
	button_icon_state = "acidspit_0"
	projectile_name = "acid"
	button_base_icon = "acidspit"

/obj/item/ammo_casing/xenospit/spread/lethal
	name = "big glob of acid"
	projectile_type = /obj/projectile/neurotoxin/tgmc/acid/spitter_spread
	pellets = 4
	variance = 30


// Взмах хвоста дефендера + является базовым для взмахов хвоста королевы и равагера
/datum/action/cooldown/spell/aoe/repulse/xeno/tgmc_tailsweep
	name = "Crushing Tail Sweep"
	desc = "Throw back attackers with a sweep of your tail, likely breaking some bones in the process."

	cooldown_time = 60 SECONDS

	aoe_radius = 1

	button_icon = 'tff_modular/modules/tgmc_xenos/icons/xeno_actions.dmi'
	button_icon_state = "crush_tail"

	sparkle_path = /obj/effect/temp_visual/dir_setting/tailsweep/defender

	/// The sound that the tail sweep will make upon hitting something
	var/impact_sound = 'sound/effects/clang.ogg'
	/// How long mobs hit by the tailsweep should be knocked down for
	var/knockdown_time = 4 SECONDS
	/// How much damage tail sweep impacts should do to a mob
	var/impact_damage = 30
	/// What wound bonus should the tai sweep impact have
	var/impact_wound_bonus = 20
	/// What type of sharpness should this tail sweep have
	var/impact_sharpness = FALSE
	/// What type of damage should the tail sweep do
	var/impact_damage_type = BRUTE

/datum/action/cooldown/spell/aoe/repulse/xeno/tgmc_tailsweep/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/carbon/alien/adult/tgmc/owner_alien = owner
	if(!istype(owner_alien) || owner_alien.unable_to_use_abilities)
		return FALSE

/datum/action/cooldown/spell/aoe/repulse/xeno/tgmc_tailsweep/cast_on_thing_in_aoe(atom/movable/victim, atom/caster)
	if(!isliving(victim))
		return

	if(isalien(victim))
		return

	var/turf/throwtarget = get_edge_target_turf(caster, get_dir(caster, get_step_away(victim, caster)))
	var/dist_from_caster = get_dist(victim, caster)
	var/mob/living/victim_living = victim

	if(dist_from_caster <= 0)
		victim_living.Knockdown(knockdown_time)
		if(sparkle_path)
			new sparkle_path(get_turf(victim_living), get_dir(caster, victim_living))

	else
		victim_living.Knockdown(knockdown_time * 2) //They are on the same turf as us, or... somewhere else, I'm not sure how but they are getting smacked down

	victim_living.apply_damage(impact_damage, impact_damage_type, BODY_ZONE_CHEST, wound_bonus = impact_wound_bonus, sharpness = impact_sharpness)
	shake_camera(victim_living, 4, 3)
	playsound(victim_living, impact_sound, 100, TRUE, 8, 0.9)
	to_chat(victim_living, span_userdanger("[caster]'s tail slams into you, throwing you back!"))

	victim_living.safe_throw_at(throwtarget, ((clamp((max_throw - (clamp(dist_from_caster - 2, 0, dist_from_caster))), 3, max_throw))), 1, caster, force = repulse_force)

/obj/effect/temp_visual/dir_setting/tailsweep/defender
	icon = 'tff_modular/modules/tgmc_xenos/icons/xeno_actions.dmi'
	icon_state = "crush_tail_anim"


// Взмах хвоста преторианца
/datum/action/cooldown/spell/aoe/repulse/xeno/tgmc_tailsweep/hard_throwing
	name = "Flinging Tail Sweep"
	desc = "Throw back attackers with a sweep of your tail that is much stronger than other aliens."

	aoe_radius = 2
	repulse_force = MOVE_FORCE_OVERPOWERING //Fuck everyone who gets hit by this tail in particular

	button_icon_state = "throw_tail"

	sparkle_path = /obj/effect/temp_visual/dir_setting/tailsweep/praetorian

	impact_sound = 'sound/items/weapons/slap.ogg'
	impact_damage = 20
	impact_wound_bonus = 10

/obj/effect/temp_visual/dir_setting/tailsweep/praetorian
	icon = 'tff_modular/modules/tgmc_xenos/icons/xeno_actions.dmi'
	icon_state = "throw_tail_anim"


// Взмах хвоста равагера
/datum/action/cooldown/spell/aoe/repulse/xeno/tgmc_tailsweep/slicing
	name = "Slicing Tail Sweep"
	desc = "Throw back attackers with a swipe of your tail, slicing them with its sharpened tip."

	aoe_radius = 2

	button_icon_state = "slice_tail"

	sparkle_path = /obj/effect/temp_visual/dir_setting/tailsweep/ravager

	sound = 'tff_modular/modules/tgmc_xenos/sound/alien_tail_swipe.ogg' //The defender's tail sound isn't changed because its big and heavy, this isn't

	impact_sound = 'modular_nova/master_files/sound/weapons/bloodyslice.ogg'
	impact_damage = 40
	impact_sharpness = SHARP_EDGED

/obj/effect/temp_visual/dir_setting/tailsweep/ravager
	icon = 'tff_modular/modules/tgmc_xenos/icons/xeno_actions.dmi'
	icon_state = "slice_tail_anim"


// Хил-аура дрона
/datum/action/cooldown/alien/tgmc/heal_aura
	name = "Healing Aura"
	desc = "Friendly xenomorphs in a short range around yourself will receive passive healing."
	button_icon_state = "healaura"
	plasma_cost = 100
	cooldown_time = 90 SECONDS
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
	aura_healing_component = owner.AddComponent(/datum/component/aura_healing, range = aura_range, requires_visibility = TRUE, brute_heal = aura_healing_amount, burn_heal = aura_healing_amount, limit_to_trait = TRAIT_XENO_HEAL_AURA, healing_color = aura_healing_color)
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
	cooldown_time = 90 SECONDS
	aura_range = 7
	aura_healing_amount = 10
	aura_healing_color = COLOR_RED_LIGHT


// Все сказано в названии подтипа. Только равагер имеет такое
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


// Забавный код для руни
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
	RegisterSignal(owner, COMSIG_PROJECTILE_ON_HIT, PROC_REF(on_projectile_hit))
	REMOVE_TRAIT(owner, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	addtimer(CALLBACK(src, PROC_REF(give_back_ventcrawl)), (cooldown_time * EVASION_VENTCRAWL_INABILTY_CD_PERCENTAGE)) //They cannot ventcrawl until the defined percent of the cooldown has passed
	to_chat(owner, span_warning("We will be unable to crawl through vents for the next [(cooldown_time * EVASION_VENTCRAWL_INABILTY_CD_PERCENTAGE) / 10] seconds."))
	return TRUE

/// Handles deactivation of the xeno evasion ability, mainly unregistering the signal and giving a balloon alert
/datum/action/cooldown/alien/tgmc/evade/proc/evasion_deactivate()
	evade_active = FALSE
	owner.balloon_alert(owner, "evasion ended")
	UnregisterSignal(owner, COMSIG_PROJECTILE_ON_HIT)

/datum/action/cooldown/alien/tgmc/evade/proc/give_back_ventcrawl()
	ADD_TRAIT(owner, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	to_chat(owner, span_notice("We are rested enough to crawl through vents again."))

/// Handles if either BULLET_ACT_HIT or BULLET_ACT_FORCE_PIERCE happens to something using the xeno evade ability
/datum/action/cooldown/alien/tgmc/evade/proc/on_projectile_hit()
	if(owner.build_incapacitated(INCAPABLE_GRAB) || !isturf(owner.loc) || !evade_active)
		return BULLET_ACT_HIT

	owner.visible_message(span_danger("[owner] effortlessly dodges the projectile!"), span_userdanger("You dodge the projectile!"))
	playsound(get_turf(owner), pick('sound/items/weapons/bulletflyby.ogg', 'sound/items/weapons/bulletflyby2.ogg', 'sound/items/weapons/bulletflyby3.ogg'), 75, TRUE)
	owner.add_filter(RUNNER_BLUR_EFFECT, 2, gauss_blur_filter(5))
	addtimer(CALLBACK(owner, TYPE_PROC_REF(/datum, remove_filter), RUNNER_BLUR_EFFECT), 0.5 SECONDS)
	return BULLET_ACT_FORCE_PIERCE


// Одиночный чардж дефендера и вариора
/datum/action/cooldown/mob_cooldown/charge/basic_charge/defender
	name = "Charge Attack"
	desc = "Allows you to charge at a position, trampling anything in your path."
	cooldown_time = 15 SECONDS
	charge_delay = 0.3 SECONDS
	charge_distance = 5
	destroy_objects = FALSE
	charge_damage = 50
	button_icon = 'tff_modular/modules/tgmc_xenos/icons/xeno_actions.dmi'
	button_icon_state = "defender_charge"
	unset_after_click = TRUE

/datum/action/cooldown/mob_cooldown/charge/basic_charge/defender/do_charge_indicator(atom/charger, atom/charge_target)
	. = ..()
	playsound(charger, 'tff_modular/modules/tgmc_xenos/sound/alien_roar1.ogg', 100, TRUE, 8, 0.9)

/datum/action/cooldown/mob_cooldown/charge/basic_charge/defender/Activate(atom/target_atom)
	. = ..()
	return TRUE


// Тройной чардж равагера
/datum/action/cooldown/mob_cooldown/charge/triple_charge/ravager
	name = "Triple Charge Attack"
	desc = "Allows you to charge thrice at a location, trampling any in your path."
	cooldown_time = 30 SECONDS
	charge_delay = 0.3 SECONDS
	charge_distance = 7
	charge_past = 3
	destroy_objects = FALSE
	charge_damage = 25
	button_icon = 'tff_modular/modules/tgmc_xenos/icons/xeno_actions.dmi'
	button_icon_state = "ravager_charge"
	unset_after_click = TRUE

/datum/action/cooldown/mob_cooldown/charge/triple_charge/ravager/do_charge_indicator(atom/charger, atom/charge_target)
	playsound(charger, 'tff_modular/modules/tgmc_xenos/sound/alien_roar2.ogg', 100, TRUE, 8, 0.9)

/datum/action/cooldown/mob_cooldown/charge/triple_charge/ravager/Activate(atom/target_atom)
	. = ..()
	return TRUE


/// Способность вариора делать *что-то*
/datum/action/cooldown/alien/tgmc/warrior_agility
	name = "Agility Mode"
	desc = "Drop onto all fours, increasing your speed at the cost of damage and being unable to use most abilities."
	button_icon_state = "the_speed_is_alot"
	cooldown_time = 1 SECONDS
	can_be_used_always = TRUE
	/// Is the warrior currently running around on all fours?
	var/being_agile = FALSE

/datum/action/cooldown/alien/tgmc/warrior_agility/Activate()
	. = ..()
	if(!being_agile)
		begin_agility()
		return TRUE
	if(being_agile)
		end_agility()
		return TRUE

/// Handles the visual indication and code activation of the warrior agility ability (say that five times fast)
/datum/action/cooldown/alien/tgmc/warrior_agility/proc/begin_agility()
	var/mob/living/carbon/alien/adult/tgmc/agility_target = owner
	agility_target.balloon_alert(agility_target, "agility active")
	to_chat(agility_target, span_danger("We drop onto all fours, allowing us to move at much greater speed at expense of being able to use most abilities."))
	playsound(agility_target, 'tff_modular/modules/tgmc_xenos/sound/alien_hiss.ogg', 100, TRUE, 8, 0.9)
	agility_target.icon_state = "alien[agility_target.caste]_mobility"

	being_agile = TRUE
	agility_target.add_movespeed_modifier(/datum/movespeed_modifier/warrior_agility)
	agility_target.unable_to_use_abilities = TRUE

	agility_target.melee_damage_lower = 15
	agility_target.melee_damage_upper = 20

/// Handles the visual indicators and code side of deactivating the agility ability
/datum/action/cooldown/alien/tgmc/warrior_agility/proc/end_agility()
	var/mob/living/carbon/alien/adult/tgmc/agility_target = owner
	agility_target.balloon_alert(agility_target, "agility ended")
	playsound(agility_target, 'tff_modular/modules/tgmc_xenos/sound/alien_roar2.ogg', 100, TRUE, 8, 0.9) //Warrior runs up on all fours, stands upright, screams at you
	agility_target.icon_state = "alien[agility_target.caste]"

	being_agile = FALSE
	agility_target.remove_movespeed_modifier(/datum/movespeed_modifier/warrior_agility)
	agility_target.unable_to_use_abilities = FALSE

	agility_target.melee_damage_lower = initial(agility_target.melee_damage_lower)
	agility_target.melee_damage_upper = initial(agility_target.melee_damage_upper)

/datum/movespeed_modifier/warrior_agility
	multiplicative_slowdown = -2


#undef RAVAGER_OUTLINE_EFFECT
#undef EVASION_VENTCRAWL_INABILTY_CD_PERCENTAGE
#undef RUNNER_BLUR_EFFECT
