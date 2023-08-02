/**
 *  HUMAN_HOLDER
 *
 *  Этот компонент, нужен для безопасного нахождения человека внутри mob_holder.
 * 	Изначально создаен для того, чтобы ложить тешари в сумки..
 *
 * 	Переменные:
 *
 * 	held_human - человек, над которым мы в данный момент оперируем.
 * 	holder - холдер, в котором находится человек.
 * 	handle_environment - нужно ли нам потдерживать нормальное состояние среды.
 */

/datum/component/human_holder
	var/mob/living/carbon/human/held_human
	var/obj/item/clothing/head/mob_holder/human/holder
	var/handle_environment

/datum/component/human_holder/Initialize(obj/item/clothing/head/mob_holder/human/holder, mob/living/carbon/human/handle_human, handle_environment = TRUE)
	src.held_human = handle_human
	src.handle_environment = handle_environment
	src.holder = holder

	RegisterWithParent()

/datum/component/human_holder/Destroy(force, silent)
	. = ..()
	if(!parent)
		return

	UnregisterSignal(parent, list(COMSIG_HUMAN_ENTER_STORAGE, COMSIG_HUMAN_EXIT_STORAGE, COMSIG_CARBON_PRE_BREATHE))

/datum/component/human_holder/RegisterWithParent()
	if(!parent)
		return
	RegisterSignal(parent, COMSIG_HUMAN_ENTER_STORAGE, PROC_REF(enter_storage), override = TRUE)
	RegisterSignal(parent, COMSIG_HUMAN_EXIT_STORAGE, PROC_REF(exit_storage), override = TRUE)
	RegisterSignal(parent, COMSIG_CARBON_ATTEMPT_BREATHE, PROC_REF(handle_breathe), override = TRUE)

/**
 * Этот прок служит прослойкой между призывом к дыханию человека и самим дыханием. Порядкой следующий
 * - Начало дыхания.
 * - Дыхание(сигнал о подготовке дыхания)
 * 		- Этот прок(если его выполнение дойдет до последний строки, то тут порядок и остановится)
 * - Дыхание(остальной код)
 */
/datum/component/human_holder/proc/handle_breathe()
	SIGNAL_HANDLER
	if(!handle_environment)
		return
	if(held_human.health <= HEALTH_THRESHOLD_FULLCRIT)
		return
	if(held_human.get_breath_from_internal(BREATH_VOLUME))
		return

	var/turf/stand_turf = get_turf(holder.holding_bag)
	var/datum/gas_mixture/environment = stand_turf.return_air()
	// Если нет атмосферной среды - пропускаем.
	if(!environment)
		return

	held_human.failed_last_breath = FALSE
	held_human.handle_environment(environment)
	stand_turf.remove_air(BREATH_PERCENTAGE)

	//Отменяем вдох человека.
	return COMSIG_CARBON_BLOCK_BREATH

/datum/component/human_holder/proc/enter_storage(mob/living/carbon/human/user, obj/item/storage/backpack/bag)
	SIGNAL_HANDLER

	user.cure_blind(EYES_COVERED)
	user.overlay_fullscreen("tint", /atom/movable/screen/fullscreen/impaired, 2)
	//Увеличиваем размер холдера, дабы гарантировать, что в него не попадет много других существ.
	holder.w_class = WEIGHT_CLASS_HUGE

/datum/component/human_holder/proc/exit_storage(mob/living/carbon/human/user, obj/item/storage/backpack/bag)
	SIGNAL_HANDLER

	user.cure_blind(EYES_COVERED)
	user.clear_fullscreen("tint", 0 SECONDS)
	user.update_tint()
	Destroy()
