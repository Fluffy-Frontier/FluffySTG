/obj/effect/overlay/void_shield
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	vis_flags = VIS_INHERIT_DIR | VIS_INHERIT_PLANE | VIS_INHERIT_ID
	icon = 'tff_modular/master_files/icons/effects/shield.dmi'
	icon_state = "shield_on"
	layer = ABOVE_ALL_MOB_LAYER

/obj/effect/overlay/void_shield_recharge
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	vis_flags = VIS_INHERIT_DIR | VIS_INHERIT_PLANE | VIS_INHERIT_ID
	icon = 'tff_modular/master_files/icons/effects/shield.dmi'
	icon_state = "shield_charge"
	layer = ABOVE_ALL_MOB_LAYER + 0.1

/datum/component/advanced_energy_shield
	dupe_mode = COMPONENT_DUPE_UNIQUE
	// Текущее здоровье щита
	var/shield_health = 0
	// Максимальное здоровье щита
	var/shield_maxhealth = 150
	// Включен ли щит
	var/enabled = FALSE
	// Время необходимое щиту, для начала перезарядки
	var/evade_time = 5 SECONDS
	// Перезаряжается ли щит
	var/recharging = FALSE
	// Влияет ли ЭМИ на работу щита
	var/affect_emp = TRUE
	// Урон от ЭМИ по щиту, если affect_emp = TRUE
	var/emp_damage = 50
	// Защищает ли этот щит только от дальних атак
	var/ranged_only = TRUE
	// Количество очков здоровья, что восстаналивает щит, каждый тик
	var/recharge_rate = 10
	// Пробивают ли лазеры щит
	var/powerful_lasers = TRUE

	var/shield_inhand = FALSE

	// Максимальный возможный урон, что может поглатить щит за один хит
	var/damage_threshold = 100
	// Время необходимое щиту после разрушения для начала перезарядки
	var/regeneration_time = 30 SECONDS

	// Цвет щита при высоком здоровье
	var/fullhealth_color = COLOR_BLUE

	COOLDOWN_DECLARE(after_damage_cooldown)
	COOLDOWN_DECLARE(shield_recharge_cooldown)

	var/obj/effect/overlay/current_overlay

	var/obj/effect/overlay/shield_overlay

	var/obj/effect/overlay/recharge_overlay

	// Текущий пользователь щита
	var/mob/living/wearer

/datum/component/advanced_energy_shield/Initialize(shield_maxhealth = 200, \
damage_threshold = 100, \
evade_time = 3 SECONDS, \
regeneration_time = 30 SECONDS, \
affect_emp = TRUE, \
emp_damage = 50, \
ranged_only = TRUE, \
powerful_lasers = TRUE, \
shield_inhand = FALSE, \
fullhealth_color = COLOR_BLUE, \
starting_health = null, \
obj/effect/overlay/overlay_shield = /obj/effect/overlay/void_shield, \
obj/effect/overlay/overlay_charge = /obj/effect/overlay/void_shield_recharge)
	if(!isitem(parent) || shield_maxhealth <= 0)
		return COMPONENT_INCOMPATIBLE

	src.shield_maxhealth = shield_maxhealth
	src.damage_threshold = damage_threshold
	src.regeneration_time = regeneration_time
	src.evade_time = evade_time
	src.affect_emp = affect_emp
	src.emp_damage = emp_damage
	src.ranged_only = ranged_only
	src.shield_inhand = shield_inhand
	src.fullhealth_color = fullhealth_color
	src.powerful_lasers = powerful_lasers
	src.shield_overlay = new overlay_shield()
	src.recharge_overlay = new overlay_charge()

	shield_overlay.alpha = 0
	recharge_overlay.alpha = 0

	if(isnull(starting_health))
		shield_health = 0
	else
		shield_health = clamp(starting_health, 0, shield_maxhealth)



/datum/component/advanced_energy_shield/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equipped))
	RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(lost_wearer))
	RegisterSignal(parent, COMSIG_ITEM_HIT_REACT, PROC_REF(on_hit_react))
	if(affect_emp)
		RegisterSignal(parent, COMSIG_ATOM_EMP_ACT, PROC_REF(on_emp_act))
	var/obj/item/shield = parent
	if(ismob(shield.loc))
		var/mob/holder = shield.loc
		if(holder.is_holding(parent) && !shield_inhand)
			return
		set_wearer(holder)

/datum/component/advanced_energy_shield/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_DROPPED, COMSIG_ITEM_HIT_REACT))
	if(affect_emp)
		UnregisterSignal(parent, COMSIG_ATOM_EMP_ACT)
	var/obj/item/shield = parent
	if(shield.loc == wearer)
		lost_wearer(src, wearer)

/datum/component/advanced_energy_shield/proc/on_equipped(datum/source, mob/user, slot)
	SIGNAL_HANDLER
	if(user.is_holding(parent) && !shield_inhand)
		lost_wearer(source, user)
		return
	set_wearer(user)

/datum/component/advanced_energy_shield/proc/lost_wearer(datum/source, mob/user)
	SIGNAL_HANDLER
	if(wearer)
		wearer.vis_contents -= shield_overlay
		wearer.vis_contents -= recharge_overlay
		UnregisterSignal(wearer, COMSIG_QDELETING)
		wearer = null

/datum/component/advanced_energy_shield/proc/set_wearer(mob/user)
	if(wearer == user)
		return
	if(!isnull(wearer))
		CRASH("[type] called set_wearer with [user] but [wearer] was already the wearer!")
	wearer = user
	RegisterSignal(wearer, COMSIG_QDELETING, PROC_REF(lost_wearer))
	wearer.vis_contents += shield_overlay
	wearer.vis_contents += recharge_overlay
	START_PROCESSING(SSdcs, src)

/datum/component/advanced_energy_shield/Destroy(force)
	if(wearer)
		lost_wearer()
	qdel(shield_overlay)
	qdel(recharge_overlay)
	return ..()

/datum/component/advanced_energy_shield/proc/on_emp_act(datum/source, severity)
	SIGNAL_HANDLER
	handle_shield_damage(emp_damage * severity)

/datum/component/advanced_energy_shield/proc/handle_shield_damage(damage)
	if(damage <= 0)
		return TRUE
	if(recharging)
		if(wearer)
			wearer.balloon_alert(wearer, "Recharge interrupted!")
		set_shield_charging(FALSE)
	shield_health = max(0, shield_health - damage)
	if(shield_health == 0 || damage >= damage_threshold)
		break_shield()
		return FALSE

	COOLDOWN_START(src, after_damage_cooldown, evade_time)
	if(recharge_rate > 0)
		START_PROCESSING(SSdcs, src)
	return TRUE

/datum/component/advanced_energy_shield/proc/on_hit_react(
	datum/source,
	mob/living/owner,
	atom/movable/hitby,
	attack_text = "the attack",
	final_block_chance = 0,
	damage = 0,
	attack_type = MELEE_ATTACK,
	damage_type = BRUTE
)
	SIGNAL_HANDLER
	if(isnull(wearer))
		return
	if(owner != wearer)
		return
	if(!enabled)
		return
	if((attack_type == MELEE_ATTACK || attack_type == UNARMED_ATTACK) && ranged_only)
		return

	var/blocked = FALSE
	if(damage_type == BURN && powerful_lasers)
		handle_shield_damage(damage)
		damage_shield_effect()
	else
		if(handle_shield_damage(damage))
			blocked = TRUE
			playsound(get_turf(parent), 'tff_modular/master_files/sounds/effects/eshield_hit.ogg', 20)
			new /obj/effect/temp_visual/guardian/phase/out(get_turf(parent))
			if(current_overlay == shield_overlay)
				damage_shield_effect()
	update_shield_visual()
	if(blocked)
		return COMPONENT_HIT_REACTION_BLOCK

/datum/component/advanced_energy_shield/process(seconds_per_tick)
	if(shield_health >= shield_maxhealth)
		return
	if(!COOLDOWN_FINISHED(src, shield_recharge_cooldown) || !COOLDOWN_FINISHED(src, after_damage_cooldown))
		return

	if(!recharging)
		if(wearer)
			wearer.balloon_alert(wearer, "Shield recharging!")
		set_shield_charging(TRUE)
	if(!enabled)
		enabled = TRUE

	shield_health = min(shield_health + recharge_rate * seconds_per_tick, shield_maxhealth)
	update_shield_visual()
	if(shield_health >= shield_maxhealth)
		set_shield_charging(FALSE)
		playsound(get_turf(parent), 'tff_modular/master_files/sounds/effects/shield_recharge.ogg', 20)

/datum/component/advanced_energy_shield/proc/break_shield()
	enabled = FALSE
	break_shield_effect()
	new /obj/effect/temp_visual/cosmic_explosion(get_turf(parent))
	playsound(get_turf(parent), 'sound/effects/glass/glassbr3.ogg', 50, TRUE)
	COOLDOWN_START(src, shield_recharge_cooldown, regeneration_time)
	if(recharge_rate > 0)
		START_PROCESSING(SSdcs, src)

/datum/component/advanced_energy_shield/proc/break_shield_effect()
	if(!current_overlay)
		return
	animate(current_overlay, alpha = 0, time = 3, easing = SINE_EASING)
	current_overlay.filters += filter(type="wave", size=12, offset=0)
	animate(current_overlay.filters[length(current_overlay.filters)], size=0, offset=1, time=3, easing=SINE_EASING)
	addtimer(CALLBACK(src, PROC_REF(clear_shield_filters), current_overlay), 3)

/datum/component/advanced_energy_shield/proc/damage_shield_effect()
	if(!shield_overlay)
		return
	shield_overlay.clear_filters()
	shield_overlay.filters += filter(type="wave", size=8, offset=0)
	animate(shield_overlay.filters[1], size=0, offset=3, time=3, easing=SINE_EASING)
	animate(shield_overlay, alpha=255, time=2, easing=LINEAR_EASING)
	animate(alpha=50 + (shield_health / shield_maxhealth * 150), time=3, easing=LINEAR_EASING)
	addtimer(CALLBACK(src, PROC_REF(clear_shield_filters), shield_overlay), 3)

/datum/component/advanced_energy_shield/proc/clear_shield_filters(obj/effect/overlay/target)
	if(target)
		target.filters = null

/datum/component/advanced_energy_shield/proc/set_shield_charging(state)
	if(recharging == state)
		return
	recharging = state
	current_overlay = recharging ? recharge_overlay : shield_overlay
	animate(shield_overlay, alpha = recharging ? 0 : 200, time = 5, easing = SINE_EASING)
	animate(recharge_overlay, alpha = recharging ? 200 : 0, time = 5, easing = SINE_EASING)
	update_shield_visual()

/datum/component/advanced_energy_shield/proc/update_shield_visual()
	var/status = shield_health / shield_maxhealth
	var/target_color
	if(status >= 0.7)
		target_color = fullhealth_color
	else if(status >= 0.4)
		target_color = COLOR_YELLOW
	else if(status >= 0.01)
		target_color = COLOR_RED
	else
		target_color = fullhealth_color

	if(current_overlay)
		animate(current_overlay, color = target_color, time = 3, easing = LINEAR_EASING)

