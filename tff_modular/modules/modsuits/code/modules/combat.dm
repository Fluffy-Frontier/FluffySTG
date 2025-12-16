/**
 * Модуль энерго-пушки, потребляет заря МОДда для стрельбы.
 */

/obj/item/mod/module/energy_gun
	name = "MOD energy gun module"
	desc = "MOD module installed in the user's hand, consisting of a small \
			laser cannon with several firing modes. Powered by the suit's battery."
	icon = 'tff_modular/modules/modsuits/icons/mod_icons/mod_modules.dmi'
	icon_state = "mod_laser"
	cooldown_time = 1 SECONDS
	module_type = MODULE_ACTIVE

	incompatible_modules = list(
		/obj/item/mod/module/energy_gun,
		/obj/item/mod/module/holster,
	)
	required_slots = list(ITEM_SLOT_GLOVES)
	device = /obj/item/gun/energy/laser/mounted/modsuit

/obj/item/mod/module/energy_gun/on_install()
	. = ..()
	if(istype(device, /obj/item/gun/energy/laser/mounted/modsuit))
		var/obj/item/gun/energy/laser/mounted/modsuit/gun = device
		gun.mod = mod

/**
 * Модуль энерго-копья.
 */
/obj/item/mod/module/energy_spear
	name = "MOD energy spear module"
	desc = "MOD module installed in the users arm, when activated, uses the suit's energy to \
			create a short-lived energy beam in the form of a spear. It has extremely high speed and \
			penetration characteristics."
	cooldown_time = 10 SECONDS
	module_type = MODULE_USABLE

	use_energy_cost = POWER_CELL_USE_INSANE * 2
	icon = 'tff_modular/modules/modsuits/icons/mod_icons/mod_modules.dmi'
	icon_state = "module_energy_spear"
	incompatible_modules = list(
		/obj/item/mod/module/energy_spear,
	)
	required_slots = list(ITEM_SLOT_GLOVES)
	var/spear_type = /obj/item/energy_spear
	var/datum/weakref/spear_ref

/obj/item/mod/module/energy_spear/emag_act(mob/user, obj/item/card/emag/emag_card)
	. = ..()
	spear_type = /obj/item/energy_spear/hardlight // Более опасное, ЗНАЧИТЕЛЬНО
	user.balloon_alert(user, "Sefety protocol overriden!")

/obj/item/mod/module/energy_spear/on_use(mob/activator)
	. = ..()

	var/obj/item/energy_spear/spear = null
	if(spear_ref)
		spear = spear_ref.resolve()
	if(spear)
		activator.balloon_alert(mod.wearer, "Spear already deployed!")
		return
	spear = new spear_type(src)
	if(!activator.put_in_hands(spear))
		activator.balloon_alert(mod.wearer, "Hands occuped!")
		qdel(spear)
		return
	activator.balloon_alert(mod.wearer, "Spear materialized!")
	activator.visible_message(span_warning("[activator], materialize [spear.name] in [activator.p_they()], hand ready to throw!"), span_warning("You materialize energy spear in your hand."), span_hear("You hear energy clack."))
	register_spear(spear)
	playsound(get_turf(activator), 'tff_modular/modules/modsuits/sounds/energy_emit.ogg', 40)
	icon_state = "module_energy_spear_deploed"
	update_icon_state()

/obj/item/mod/module/energy_spear/proc/register_spear(obj/item/energy_spear/spear)
	RegisterSignal(spear, COMSIG_MOVABLE_PRE_THROW, PROC_REF(on_spear_throw))
	RegisterSignal(spear, COMSIG_QDELETING, PROC_REF(on_spear_delete))
	spear_ref = WEAKREF(spear)

/obj/item/mod/module/energy_spear/proc/unregister_spear()
	if(!spear_ref)
		return
	var/obj/item/energy_spear/spear = spear_ref.resolve()
	if(!spear)
		return
	UnregisterSignal(spear, COMSIG_MOVABLE_PRE_THROW, PROC_REF(on_spear_throw))
	UnregisterSignal(spear, COMSIG_QDELETING, PROC_REF(on_spear_delete))
	spear_ref = null

/obj/item/mod/module/energy_spear/proc/on_spear_delete()
	SIGNAL_HANDLER

	unregister_spear()
	icon_state = "module_energy_spear"
	update_icon_state()

/obj/item/mod/module/energy_spear/proc/on_spear_throw()
	SIGNAL_HANDLER

	unregister_spear()
	icon_state = "module_energy_spear"
	update_icon_state()

/**
 * Модуль клинка.
 */

/obj/item/mod/module/mob_blade
	name = "MOD blade module"
	desc = "Massive MOD blade built into the arm. Possesses monstrous strength."
	icon_state = "module_mod_blade"
	icon = 'tff_modular/modules/modsuits/icons/mod_icons/mod_modules.dmi'
	incompatible_modules = list(
		/obj/item/mod/module/mob_blade,
		/obj/item/mod/module/mob_blade/armblade,
	)

	complexity = 5
	module_type = MODULE_ACTIVE
	cooldown_time = 0.5 SECONDS
	required_slots = list(ITEM_SLOT_GLOVES)
	device = /obj/item/melee/mod_blade

/obj/item/mod/module/mob_blade/on_install()
	. = ..()
	if(istype(device, /obj/item/melee/mod_blade))
		var/obj/item/melee/mod_blade/blade = device
		blade.mod = mod


/obj/item/mod/module/mob_blade/armblade
	name = "MOD armblade module"
	icon_state = "module_mod_armblade"
	device = /obj/item/melee/mod_blade/armblade


/**
 * Модуль улучшенного энерго-щита.
 *
 * Отличается от обычного тем, что использует здоровье а не хиты. Т.е. вместо 3 хитов => 150 здоровья
 */
/obj/item/mod/module/advanced_energy_shield
	name = "MOD advanced energy shield module"
	desc = "A personal, protective forcefield typically seen in military applications. \
		This advanced deflector shield is essentially a scaled down version of those seen on starships, \
		and the power cost can be an easy indicator of this. However, it is capable of blocking nearly any incoming attack, \
		but only once every few seconds; a grim reminder of the users mortality."
	icon_state = "energy_shield"
	complexity = 4
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.5
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 5
	incompatible_modules = list(
		/obj/item/mod/module/energy_shield,
		/obj/item/mod/module/advanced_energy_shield)

	required_slots = list(ITEM_SLOT_BACK)
	// Максимальное здоровье щита
	var/max_health = 150
	// Время необходимое щиту для восстановления после разрушения
	var/recharge_start_delay = 20 SECONDS
	// Время нмеобходимое щиту после получения урона ля надчала восстановления
	var/recharge_evade_delay = 6 SECONDS
	// Пробивают ли лазеры этот щит
	var/strong_lasers = FALSE
	// Защищает ли этот щит только от атак дальнего боя
	var/ranged_only = FALSE
	// Цвет заряженого щита
	var/shield_color = COLOR_BRIGHT_ORANGE

	VAR_PRIVATE/datum/component/advanced_energy_shield/shield = null



/obj/item/mod/module/advanced_energy_shield/Destroy()
	. = ..()
	if(shield)
		QDEL_NULL(shield)

/obj/item/mod/module/advanced_energy_shield/on_part_activation()
	mod.AddComponent( \
		/datum/component/advanced_energy_shield, \
		shield_maxhealth = max_health, \
		damage_threshold = max_health, \
		evade_time = recharge_evade_delay, \
		regeneration_time = recharge_start_delay, \
		affect_emp = TRUE, \
		emp_damage = 50, \
		ranged_only = ranged_only, \
		powerful_lasers = strong_lasers, \
		fullhealth_color = shield_color, \
		overlay_shield = /obj/effect/overlay/void_shield, \
		overlay_charge = /obj/effect/overlay/void_shield_recharge, \
	)
	shield = mod.GetComponent(/datum/component/advanced_energy_shield)
	RegisterSignal(mod.wearer, COMSIG_LIVING_CHECK_BLOCK, PROC_REF(shield_reaction), TRUE)
	RegisterSignal(mod.wearer, COMSIG_ATOM_EXAMINE, PROC_REF(on_wearer_examine), TRUE)

/obj/item/mod/module/advanced_energy_shield/on_part_deactivation(deleting = FALSE)
	if(shield)
		QDEL_NULL(shield)
	UnregisterSignal(mod.wearer, list(COMSIG_LIVING_CHECK_BLOCK, COMSIG_ATOM_EXAMINE))


/obj/item/mod/module/advanced_energy_shield/proc/on_wearer_examine(mob/source, mob/user, list/examine_text)
	if(ranged_only)
		examine_text += span_notice("Blue light active — shield ignores melee completely, ranged only.")

	if(strong_lasers)
		examine_text += span_boldnotice("Red band visible — heavily resists powerful lasers and energy weapons.")


/obj/item/mod/module/advanced_energy_shield/proc/shield_reaction(mob/living/carbon/human/owner,
	atom/movable/hitby,
	damage = 0,
	attack_text = "the attack",
	attack_type = MELEE_ATTACK,
	armour_penetration = 0,
	damage_type = BRUTE
)
	SIGNAL_HANDLER
	if(!shield)
		return FAILED_BLOCK
	if(!drain_power(use_energy_cost))
		return FAILED_BLOCK
	if(mod.hit_reaction(owner, hitby, attack_text, 0, damage, attack_type))
		drain_power(use_energy_cost)
		return SUCCESSFUL_BLOCK
	return FAILED_BLOCK

/obj/item/mod/module/advanced_energy_shield/nanotrasen
	desc = "A personal, protective forcefield typically seen in military applications. \
		This advanced deflector shield is essentially a scaled down version of those seen on starships, \
		and the power cost can be an easy indicator of this. However, it is capable of blocking nearly any incoming attack, \
		but only once every few seconds; a grim reminder of the users mortality. This version protect only from ranged attacks."
	shield_color = COLOR_FRENCH_BLUE
	max_health = 75
	ranged_only = FALSE
	recharge_start_delay = 30 SECONDS
	recharge_evade_delay = 10 SECONDS


/**
 * Модуль riot щита.
 */

/obj/item/mod/module/mod_shield
	name = "MOD brace shield module"
	desc = "This MOD module is installed in the user's arm and provides a massive, \
			durable plastic shield that can become an impenetrable wall with the help of the suit's motors."
	icon_state = "mod_shield"
	icon = 'tff_modular/modules/modsuits/icons/items/mod_items.dmi'
	incompatible_modules = list(
		/obj/item/mod/module/mod_shield,
		/obj/item/mod/module/advanced_energy_shield,
		/obj/item/mod/module/energy_shield,
		)
	complexity = 3
	module_type = MODULE_ACTIVE
	cooldown_time = 1 SECONDS
	required_slots = list(ITEM_SLOT_GLOVES, ITEM_SLOT_FEET)
	device = /obj/item/shield/brace

/obj/item/mod/module/mod_shield/on_install()
	. = ..()
	if(istype(device, /obj/item/shield/brace))
		var/obj/item/shield/brace/shield = device
		shield.mod = mod


/**
 * Модуль стазиса о да!
 *
 * Работает так же, как стазис в игре Dead Space, выпускает проджектайл стазис шара, что взрывается при контакте
 * и накладывает эффект стазиса на ближайшие атомы. Этот эффект замедляет движение а так же значительно охлаждает
 * имеет большую задержку и не восстанавливается сам по себе - и требует химических реагентов.
 *
 * Для заправки по умолчанию требует /datum/reagent/cryostylane
 */


/obj/item/mod/module/stasis
	name = "MOD stasis field projector"
	desc = "A black-budget MOD module marked only with a dull crimson hazard trefoil and the designation «STASIS BURST». \
		Upon activation it fires a short-range, silent projectile that detonates in a spherical shock-pulse of absolute temporal compression. \
		Everything inside the burst radius is instantly slammed into near-frozen time: \
		people jerk forward in excruciatingly slow motion, blood droplets hang like sapphire beads, bullets drift lazily, \
		and the air itself turns visibly thick and blue as heat is ripped away in an instant. \
		Living tissue caught in the field flash cools so violently that exposed skin crackles with frost in seconds. \
		The effect lingers for several seconds—long enough to line up a perfect shot, step out of a blast radius, \
		or simply watch an enemy’s expression freeze in permanent, icy horror. \
		Security audit logs list more friendly-fire cryo-statues from this module than from any station-wide coolant leak in recorded history. \
		The etched warning on the casing reads: «Field collapse is instantaneous. Do not be inside when it ends.»"
	icon = 'tff_modular/modules/modsuits/icons/mod_icons/mod_modules.dmi'
	icon_state = "module_stasis"
	module_type = MODULE_ACTIVE
	complexity = 4
	use_energy_cost = POWER_CELL_USE_INSANE * 4
	incompatible_modules = list(/obj/item/mod/module/stasis)
	cooldown_time = 15 SECONDS
	required_slots = list(ITEM_SLOT_GLOVES)

	var/max_fuel = 20
	var/datum/reagent/requered_reagent = /datum/reagent/cryostylane
	var/datum/reagents/reagent_storage = null
	/// Duration of the stasis field when activated
	var/stasis_duration = 5 SECONDS

/obj/item/mod/module/stasis/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	if(!reagent_storage)
		balloon_alert(mod.wearer, "No fuel!")
		return FALSE
	if(!reagent_storage.has_reagent(requered_reagent, 5))
		balloon_alert(mod.wearer, "No [requered_reagent::name]!")
		return FALSE
	var/obj/projectile/statis_sphere/stasis = new(mod.wearer.loc)
	stasis.aim_projectile(target, mod.wearer)
	stasis.firer = mod.wearer
	playsound(src, 'sound/items/weapons/batonextend.ogg', 25, TRUE)
	INVOKE_ASYNC(stasis, TYPE_PROC_REF(/obj/projectile, fire))
	reagent_storage.remove_reagent(requered_reagent, 5)
	drain_power(use_energy_cost)

/obj/item/mod/module/stasis/on_part_activation()
	. = ..()
	RegisterSignal(mod.wearer, COMSIG_ATOM_ATTACKBY_SECONDARY, PROC_REF(on_wearer_attacked), TRUE)

/obj/item/mod/module/stasis/on_part_deactivation(deleting)
	. = ..()

/obj/item/mod/module/stasis/proc/on_wearer_attacked(datum/source, obj/item/weapon, mob/user, list/modifiers)
	SIGNAL_HANDLER

	if(!is_reagent_container(weapon) || !weapon.reagents)
		return
	if(user != mod.wearer)
		return
	INVOKE_ASYNC(src, PROC_REF(try_refil), user, weapon)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/mod/module/stasis/proc/try_refil(mob/user, obj/item/reagent_containers/store)
	if(!reagent_storage)
		reagent_storage = new(max_fuel)
	if(!reagent_storage.total_volume >= max_fuel)
		balloon_alert(user, "Full!")
		return
	if(store.reagents.has_reagent(requered_reagent, 5))
		return

	balloon_alert(user, "Refueling stasis module!")
	if(!do_after(user, 4 SECONDS))
		balloon_alert(user, "Interupted!")
		return
	balloon_alert(user, "Refueled!")
	store.reagents.trans_to(reagent_storage, 5, 1, requered_reagent)

/obj/item/mod/module/stasis/prefueled

/obj/item/mod/module/stasis/prefueled/Initialize(mapload)
	. = ..()
	reagent_storage = new(max_fuel)
	reagent_storage.add_reagent(requered_reagent, max_fuel)

/obj/item/mod/module/stasis/prefueled/advanced
	name = "MOD advanced stasis field projector"
	stasis_duration = 10 SECONDS


/obj/projectile/statis_sphere
	name = "stasis shpere"
	icon_state = "solarflare"
	damage = 0
	range = 10
	color = COLOR_BLUE
	speed = 0.70
	hitsound = 'sound/items/weapons/batonextend.ogg'
	hitsound_wall = 'sound/items/weapons/batonextend.ogg'
	suppressed = SUPPRESSED_VERY
	hit_threshhold = ABOVE_NORMAL_TURF_LAYER
	embed_type = null
	shrapnel_type = null

	var/explosion_range = 3
	var/stasis_time = 6 SECONDS

/obj/projectile/statis_sphere/Initialize(mapload)
	. = ..()
	add_filter("stasis_distort", 1, wave_filter(x = 20, y = 20, size = 1, offset = rand(0, 360), flags = WAVE_BOUNDED))

/obj/projectile/statis_sphere/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	stasis_explosion(target, explosion_range, stasis_time)

/proc/stasis_explosion(atom/target, range = 4, stasis_time = 6 SECONDS)
	new /obj/effect/temp_visual/statis_explosion(get_turf(target), range)
	for(var/atom/movable/AM in circle_range(target, range))
		AM.AddComponent(/datum/component/stasis, stasis_time)

/obj/effect/temp_visual/statis_explosion
	icon_state = "circle_wave"
	duration = 3 SECONDS
	pixel_x = -16
	pixel_y = -16
	layer = ABOVE_ALL_MOB_LAYER
	alpha = 200
	color = COLOR_BLUE

/obj/effect/temp_visual/statis_explosion/Initialize(mapload, range)
	. = ..()
	// Начинаем с малого масштаба для "расширения"
	transform.Scale(0.5, 0.5)
	// Добавляем искажение
	add_filter("stasis_distort", 1, wave_filter(x = 20, y = 20, size = 1, offset = rand(), flags = WAVE_BOUNDED))

	// Анимируем расширение: масштабируем до размера, соответствующего range
	var/matrix/final_transform = matrix(transform)
	final_transform.Scale(range * 2, range * 2)
	animate(src, transform = final_transform, time = duration, easing = QUAD_EASING | EASE_OUT)
	animate(alpha = 0, time = duration)
	animate(filters[filters.len], offset = 360, time = duration / 2, loop = 2, flags = ANIMATION_PARALLEL)

/datum/component/stasis
	dupe_mode = COMPONENT_DUPE_UNIQUE
	// Владелец компонента
	VAR_PRIVATE/atom/movable/atom_parent
	// Время которое владелец проведет в стазисе
	VAR_PRIVATE/stasis_time
	// Замедление движения для мобов
	VAR_PRIVATE/slowdown_amount = 5
	// Охлаждение в секунду для живых существ
	VAR_PRIVATE/cooling_per_second = 10
	// Задержка между движениями
	VAR_PRIVATE/move_delay = 2 SECONDS
	// Малый glide_size для пиксельного "медленного" движения
	VAR_PRIVATE/slow_glide_size = 1
	// Оригинальный glide_size для восстановления
	VAR_PRIVATE/original_glide_size
	// Оригинальный цвет для восстановления
	VAR_PRIVATE/original_color
	// Время начала стазиса
	VAR_PRIVATE/start_time

	VAR_PRIVATE/stasis_move_resist = 3000
	VAR_PRIVATE/original_move_resist

	//Трейты, что добавляются на цель при стазисе
	VAR_PRIVATE/list/stasis_traits = list(TRAIT_STASIS, TRAIT_SPACEWALK, TRAIT_NOBREATH, TRAIT_PULL_BLOCKED)

	COOLDOWN_DECLARE(move_cd)

/datum/component/stasis/Initialize(_stasis_time)
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE
	atom_parent = parent
	stasis_time = _stasis_time
	start_time = world.time

	RegisterSignal(parent, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(check_move))
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(on_moved))
	RegisterSignal(parent, COMSIG_MOVABLE_PRE_THROW, PROC_REF(slow_throw))
	RegisterSignal(parent, COMSIG_MOVABLE_UPDATE_GLIDE_SIZE, PROC_REF(force_slow_glide))

	original_glide_size = atom_parent.glide_size
	atom_parent.glide_size = slow_glide_size

	if(istype(parent, /mob/living))
		var/mob/living/L = parent
		L.add_movespeed_modifier(/datum/movespeed_modifier/stasis, update = TRUE)
		L.add_traits(stasis_traits, REF(src))

	original_color = atom_parent.color
	original_move_resist = atom_parent.move_resist
	atom_parent.move_resist = stasis_move_resist
	atom_parent.color = COLOR_BLUE
	atom_parent.add_filter("stasis_outline", 1, outline_filter(size = 1, color = COLOR_BLUE))
	atom_parent.add_filter("stasis_distort", 2, wave_filter(x = 0, y = 0, size = 0.5, offset = rand(0, 360), flags = WAVE_BOUNDED))

	START_PROCESSING(SSobj, src)

/datum/component/stasis/Destroy(force)
	UnregisterSignal(parent, list(
		COMSIG_MOVABLE_PRE_MOVE,
		COMSIG_MOVABLE_MOVED,
		COMSIG_MOVABLE_PRE_THROW,
		COMSIG_MOVABLE_UPDATE_GLIDE_SIZE,
	))

	if(ismovable(parent))
		var/atom/movable/AM = parent
		AM.glide_size = original_glide_size

	if(istype(parent, /mob/living))
		var/mob/living/L = parent
		L.remove_movespeed_modifier(/datum/movespeed_modifier/stasis, update = TRUE)
		L.remove_traits(stasis_traits, REF(src))

	atom_parent.move_resist = original_move_resist
	// Удаляем визуальные эффекты
	atom_parent.color = original_color
	atom_parent.remove_filter("stasis_outline")
	atom_parent.remove_filter("stasis_distort")
	STOP_PROCESSING(SSobj, src)
	return ..()

/datum/component/stasis/process(delta_time)
	if(istype(parent, /mob/living))
		var/mob/living/L = parent
		L.adjust_bodytemperature(-cooling_per_second * delta_time)

	if(world.time - start_time > stasis_time)
		qdel(src)

/datum/component/stasis/proc/check_move(datum/atom_source)
	SIGNAL_HANDLER
	if(!COOLDOWN_FINISHED(src, move_cd))
		return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

/datum/component/stasis/proc/on_moved(datum/atom_source)
	SIGNAL_HANDLER
	COOLDOWN_START(src, move_cd, move_delay)

/datum/component/stasis/proc/slow_throw(datum/atom_source, list/args)
	SIGNAL_HANDLER
	args[3] = max(1, args[3] / 2) // Замедляем скорость броска, но не до 0

/datum/component/stasis/proc/force_slow_glide(datum/atom_sourcess, new_glide_size)
	SIGNAL_HANDLER
	atom_parent.glide_size = slow_glide_size

/datum/movespeed_modifier/stasis
	multiplicative_slowdown = 7
