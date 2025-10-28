// Общие Пассивные эффекты:
// Датум отвечающий за пассивные эффекты
/datum/vampire_passive
	var/mob/living/carbon/owner = null

/datum/vampire_passive/proc/on_apply(datum/antagonist/vampire/V)
	return owner.update_sight()

/datum/vampire_passive/proc/on_remove(datum/antagonist/vampire/V)
	return owner.update_sight()

// Пассивные эффекты зрения
// Ночное зрение
/datum/vampire_passive/night_vision/on_apply(datum/antagonist/vampire/V)
	. = ..()
	ADD_TRAIT(owner, TRAIT_NIGHT_VISION, VAMPIRE_TRAIT)

/datum/vampire_passive/night_vision/on_remove(datum/antagonist/vampire/V)
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_NIGHT_VISION, VAMPIRE_TRAIT)

// Термальное зрение
/datum/vampire_passive/thermal_vision/on_apply(datum/antagonist/vampire/V)
	. = ..()
	ADD_TRAIT(owner, TRAIT_THERMAL_VISION, VAMPIRE_TRAIT)

/datum/vampire_passive/thermal_vision/on_remove(datum/antagonist/vampire/V)
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_THERMAL_VISION, VAMPIRE_TRAIT)

// Иксрей зрение
/datum/vampire_passive/xray/on_apply(datum/antagonist/vampire/V)
	. = ..()
	ADD_TRAIT(owner, TRAIT_XRAY_VISION, VAMPIRE_TRAIT)

/datum/vampire_passive/xray/on_remove(datum/antagonist/vampire/V)
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_XRAY_VISION, VAMPIRE_TRAIT)

// Пассивные эффекты способностей
// Улучшает Rejuvenate, теперь активация помимо стамины восстанавливает и здоровье.
/datum/vampire_passive/regen

// Гаргантюа:
// Пассивка улучшающая blood swell, удары с пассивкой наносят увеличенный урон
/datum/vampire_passive/blood_swell_upgrade

