/obj/item/mod/module/core_rnd
	name = "MOD core research module"
	desc = "The primary electronic systems operating within the suit. Utilizing outgoing signals, \
		and analyse users stats."
	icon_state = "infiltrator"
	complexity = 0
	removable = FALSE
	idle_power_cost = 0
	incompatible_modules = list(
		/obj/item/mod/module/core_rnd,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/projectile_dampener,
		/obj/item/mod/module/active_sonar,
		/obj/item/mod/module/shooting_assistant,
	)
	var/emaged = FALSE
	var/traits_to_add = list(TRAIT_REAGENT_SCANNER)

/obj/item/mod/module/core_rnd/on_activation(mob/activator)
	. = ..()
	activator.add_traits(traits_to_add, REF(src))
	mod.wearer.update_sight()

/obj/item/mod/module/core_rnd/on_install()
	. = ..()
	if(!mod)
		return
	RegisterSignal(mod, COMSIG_ATOM_EMAG_ACT, PROC_REF(on_control_emaged))
	RegisterSignal(mod, COMSIG_ATOM_EXAMINE, PROC_REF(on_control_examine))

/obj/item/mod/module/core_rnd/on_uninstall(deleting)
	. = ..()
	UnregisterSignal(mod, list(COMSIG_ATOM_EMAG_ACT, COMSIG_ATOM_EXAMINE))


/obj/item/mod/module/core_rnd/proc/on_control_emaged(obj/item/mod/control/emaged, mob/user)
	if(emaged)
		return
	incompatible_modules = list(/obj/item/mod/module/core_rnd)
	traits_to_add = list(TRAIT_REAGENT_SCANNER, TRAIT_MEDICAL_HUD, TRAIT_SECURITY_HUD, TRAIT_BOT_PATH_HUD)
	user.balloon_alert(user, "Scaners overloaded!")
	emaged = TRUE

/obj/item/mod/module/core_rnd/proc/on_control_examine(obj/item/mod/control/control, mob/user, list/examine_text)
	if(emaged)
		examine_text += span_warning("It's sefety protocols seems disabled!")

/obj/item/mod/module/core_rnd/on_deactivation(mob/activator, display_message, deleting)
	. = ..()
	activator.remove_traits(traits_to_add, REF(src))
	mod.wearer.update_sight()

/obj/item/mod/module/anomaly_locked/anomaly_neutralizer
	name = "MOD anomaly neutralizer module"
	desc = "A module installed in the core of the MOD suit, representing a portable anchor of reality \
			capable of drawing energy from the suit's core to stabilize local reality. It blocks abnormal \
			effects on the suit's user and also allows the reality anchor to be used on specific objects to stabilize them."
	module_type = MODULE_ACTIVE
	cooldown_time = 1 SECONDS
	accepted_anomalies = list(/obj/item/assembly/signaler/anomaly/ectoplasm)
	incompatible_modules = list(/obj/item/mod/module/anomaly_locked)
	required_slots = list(ITEM_SLOT_GLOVES, ITEM_SLOT_FEET, ITEM_SLOT_HEAD, ITEM_SLOT_OCLOTHING) // Для работы весь костюм должен быть развернут
	active_power_cost = POWER_CELL_USE_INSANE
	part_process = TRUE

	// Колдаун после использования модуля на аномалии
	var/neutralize_cooldown = 120 SECONDS
	// Колдаун на отражеие магических атак
	var/anti_magic_cooldown = 5 SECONDS
	// Трейты что пассивно будет получать носитель костюма
	var/traits_to_add = list(TRAIT_MADNESS_IMMUNE)

	// Максимальная дистанция на которой может работать нейтрализация
	var/maximum_range_to_target = 10
	// Время необходимое для первичного анализа цели
	var/time_to_analyze = 3 SECONDS
	// Время для подавления аномалии, в секундах
	var/supression_time = 10
	// Прогресс подавления аномалии
	var/supression_progress = 0
	// Текущая захваченная цель
	VAR_FINAL/atom/captured_target = null
	// Ссылка на луч нейтрализатора
	var/datum/beam/neutralizer_beam
	// Оврлей который мы устанавливаем захваченому атому
	var/mutable_appearance/neutralizer_icon
	// Ссылка на захват кусора для приследования цели
	var/atom/movable/screen/fullscreen/cursor_catcher/cursor_catcher


	var/static/list/aim_loss_warnings = list(
		"WARNING: TARGET OUT OF AIM! LOSING SUPRESSION PROGRESS!",
		"WARNING: AIM LOST! SUPPRESSION FIELD DESTABILIZING!",
		"ALERT: TARGET MISALIGNED — SUPPRESSION PROGRESS DECAYING!",
		"WARNING: LOCK LOST. REALITY ANCHOR LOSING GRIP!",
		"CAUTION: BEAM INTERRUPTED — SUPPRESSION INTEGRITY DROPPING!",
		"ERROR: TARGET DRIFT DETECTED. PROGRESS BLEEDING OUT!"
	)


	var/static/list/suppression_positive_messages = list(
		"SUPPRESSION BEAM STABLE — HOLDING LOCK.",
		"TARGET ACQUIRED. SUPPRESSION FIELD STRENGTHENING.",
		"GOOD LOCK — ANOMALY SUPPRESSION PROGRESSING STEADILY.",
		"BEAM ALIGNED. REALITY ANCHOR MAINTAINING GRIP.",
		"SUPPRESSION IN PROGRESS — STAY ON TARGET.",
		"LOCK CONFIRMED. ANOMALY DESTABILIZATION INCREASING.",
		"PERFECT ALIGNMENT — SUPPRESSION INTEGRITY RISING.",
		"TARGET TRACKING OPTIMAL. PROGRESS ACCELERATING.",
		"ANCHOR FIELD STRONG — CONTINUE SUPPRESSION.",
		"STABLE CONNECTION. ANOMALY WEAKENING AS PLANNED."
	)

	COOLDOWN_DECLARE(antimagic_cd)


/obj/item/mod/module/anomaly_locked/anomaly_neutralizer/can_install(obj/item/mod/control/mod)
	if(!locate(/obj/item/mod/module/core_rnd) in mod.modules)
		if(usr)
			balloon_alert(usr, "No core research module installed!")
		return FALSE
	return ..()

/obj/item/mod/module/anomaly_locked/anomaly_neutralizer/on_select_use(atom/target)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(begin_supression), target)

/obj/item/mod/module/anomaly_locked/anomaly_neutralizer/deactivate(mob/activator, display_message, deleting)
	. = ..()
	if(captured_target)
		clear_target()

/obj/item/mod/module/anomaly_locked/anomaly_neutralizer/on_part_activation()
	. = ..()
	mod.wearer.add_traits(traits_to_add, REF(src))
	register_antimagic()

/obj/item/mod/module/anomaly_locked/anomaly_neutralizer/on_part_deactivation(deleting)
	. = ..()
	mod.wearer.remove_traits(traits_to_add, REF(src))
	unregister_antimagic()

/obj/item/mod/module/anomaly_locked/anomaly_neutralizer/proc/register_antimagic()
	mod.wearer.AddComponent( \
		/datum/component/anti_magic, \
		check_blocking = CALLBACK(src, PROC_REF(can_block_magic)), \
		block_magic = CALLBACK(src, PROC_REF(on_magic_block)), \
		antimagic_flags = ALL_MAGIC_RESISTANCE, \
	)
	balloon_alert(mod.wearer, "Anti-magic granted!")

/obj/item/mod/module/anomaly_locked/anomaly_neutralizer/proc/unregister_antimagic()
	if(mod.wearer.GetComponent(/datum/component/anti_magic))
		qdel(mod.wearer.GetComponent(/datum/component/anti_magic))
		balloon_alert(mod.wearer, "Anti-magic lose!")

/obj/item/mod/module/anomaly_locked/anomaly_neutralizer/proc/can_block_magic()
	if(!COOLDOWN_FINISHED(src, antimagic_cd))
		return FALSE
	if(!drain_power(POWER_CELL_USE_INSANE))
		return FALSE
	return TRUE

/obj/item/mod/module/anomaly_locked/anomaly_neutralizer/proc/on_magic_block()
	COOLDOWN_START(src, antimagic_cd, anti_magic_cooldown)
	to_chat(mod.wearer, span_orange("WARNING: ANOMY PULSE DETECTED! RUNNING REALITY ANCHOR!"))
	new /obj/effect/temp_visual/reality_anchor(get_turf(mod.wearer))

/obj/item/mod/module/anomaly_locked/anomaly_neutralizer/proc/begin_supression(atom/target)
	if(!range_check(target))
		balloon_alert(mod.wearer, "To far!")
		deactivate(display_message = FALSE)
		start_cooldown(2 SECONDS)
		return
	var/obj/effect/beam/scaner_beam = mod.wearer.Beam(target, "rped_upgrade", maxdistance = maximum_range_to_target, emissive = TRUE)
	if(!do_after(mod.wearer, time_to_analyze, target, IGNORE_USER_LOC_CHANGE | IGNORE_HELD_ITEM | IGNORE_TARGET_LOC_CHANGE, max_interact_count = 1))
		balloon_alert(mod.wearer, "Stay still!")
		deactivate(display_message = FALSE)
		qdel(scaner_beam)
		start_cooldown(2 SECONDS)
		return
	qdel(scaner_beam)
	if(!try_capture(target))
		balloon_alert(mod.wearer, "Not anomaly!")
		deactivate(display_message = FALSE)
		start_cooldown(10 SECONDS)
		return
	to_chat(mod.wearer, span_orange("WARNING: ANOMALY DETECTED! RUNNING REALITY ANCHOR!"))
	set_target(target)

/obj/item/mod/module/anomaly_locked/anomaly_neutralizer/proc/finish_supression(atom/target)
	if(istype(target, /obj/effect/anomaly))
		var/obj/effect/anomaly/anomaly = target
		anomaly.anomalyNeutralize()
		return


/obj/item/mod/module/anomaly_locked/anomaly_neutralizer/proc/try_capture(atom/target)
	if(istype(target, /obj/effect/anomaly))
		return TRUE
	if(HAS_TRAIT(target, TRAIT_MAGICALLY_GIFTED))
		return TRUE
	return FALSE

/obj/item/mod/module/anomaly_locked/anomaly_neutralizer/proc/on_catcher_click(atom/source, location, control, params, user)
	SIGNAL_HANDLER

	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		clear_target()

/obj/item/mod/module/anomaly_locked/anomaly_neutralizer/proc/range_check(atom/target)
	if(!isturf(mod.wearer.loc))
		return FALSE
	if(ismovable(target) && !isturf(target.loc))
		return FALSE
	if(!can_see(mod.wearer, target, maximum_range_to_target))
		return FALSE
	return TRUE

/obj/item/mod/module/anomaly_locked/anomaly_neutralizer/proc/set_target(atom/target)
	balloon_alert(mod.wearer, "Lock on target!")
	if(isliving(target))
		to_chat(target, span_warning("You feel the cold piercing through you!"))
	captured_target = target
	neutralizer_icon = mutable_appearance(icon = 'icons/effects/effects.dmi', icon_state = "kinesis", layer = target.layer - 0.1, appearance_flags = RESET_ALPHA|RESET_COLOR|RESET_TRANSFORM|KEEP_APART)
	neutralizer_icon.overlays += emissive_appearance(icon = 'icons/effects/effects.dmi', icon_state = "chronofield", offset_spokesman = target)
	target.add_overlay(neutralizer_icon)
	target.add_filter("neutralize_filter", 2, wave_filter(x = 20, y = 20, size = 0.5, offset = rand(), flags = WAVE_BOUNDED))

	neutralizer_beam = mod.wearer.Beam(target, "light_beam")
	cursor_catcher = mod.wearer.overlay_fullscreen("anomaly", /atom/movable/screen/fullscreen/cursor_catcher, 0)
	cursor_catcher.assign_to_mob(mod.wearer)
	ADD_TRAIT(captured_target, TRAIT_UNDER_SUPRESSION, REF(src))
	RegisterSignal(cursor_catcher, COMSIG_SCREEN_ELEMENT_CLICK, PROC_REF(on_catcher_click))
	START_PROCESSING(SSfastprocess, src)

/obj/item/mod/module/anomaly_locked/anomaly_neutralizer/proc/clear_target()
	balloon_alert(mod.wearer, "Clear target!")
	if(!captured_target)
		return
	STOP_PROCESSING(SSfastprocess, src)
	cursor_catcher = null
	mod.wearer.clear_fullscreen("anomaly")
	captured_target.remove_filter("neutralize_filter")
	captured_target.cut_overlay(neutralizer_icon)
	animate(captured_target, alpha = 255, time = 2 SECONDS, flags = ANIMATION_PARALLEL)
	REMOVE_TRAIT(captured_target, TRAIT_UNDER_SUPRESSION, REF(src))
	QDEL_NULL(neutralizer_beam)
	captured_target = null
	supression_progress = 0

/obj/item/mod/module/anomaly_locked/anomaly_neutralizer/process(seconds_per_tick)
	if(!captured_target)
		return
	if(!range_check(captured_target))
		balloon_alert(mod.wearer, "out of range!")
		clear_target()
		return
	drain_power(use_energy_cost/10)
	if(cursor_catcher.mouse_params)
		cursor_catcher.calculate_params()
	if(!cursor_catcher.given_turf)
		return
	mod.wearer.setDir(get_dir(mod.wearer, captured_target))
	if(cursor_catcher.given_turf != get_turf(captured_target))
		if(SPT_PROB(25, seconds_per_tick))
			to_chat(mod.wearer, span_orange(pick(aim_loss_warnings)))
		supression_progress = max(supression_progress - 5 * seconds_per_tick, 0)
		return
	if(supression_progress >= 100)
		finish_supression(captured_target)
		clear_target()
		return
	var/progress_per_second = 100 / supression_time
	supression_progress = min(supression_progress + progress_per_second * seconds_per_tick, 100)
	var/target_alpha = lerp(255, 70, supression_progress / 100)
	animate(captured_target, alpha = target_alpha, time = 2 SECONDS, flags = ANIMATION_PARALLEL)
	if(prob(15))
		var/msg = span_green("SUPRESSION NOTICE: [pick(suppression_positive_messages)]")
		to_chat(mod.wearer, msg)

	if(prob(15))
		playsound(captured_target, 'sound/effects/empulse.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	if(SPT_PROB(20, seconds_per_tick))
		var/datum/effect_system/spark_spread/s = new
		s.set_up(3, 1, captured_target)
		s.start()

/obj/effect/temp_visual/reality_anchor
	duration = 1 SECONDS
	icon_state = "kinesis"
	color = COLOR_PURPLE
