/// Школа энергетики. 6 спеллов
/// Spark - создаёт искры в указанном месте
/// Discharge - разряжает АПЦ/Батарейку. Даёт ману в зависимости от кол-ва энергии
/// Laser - стрелеят концентрированным пучком фотонов, пусть и не самым сильным.
/// Distrupt - создаёт ЭМИ с небольшим радиусом.
/// Elecrocute - добавляет мутацию shock touch
/// Freeze - заковывает моба в лёд на небольшой промежуток.

// Разрядка АПЦ или батареек в обмен на ману
/datum/action/cooldown/spell/touch/psionic/psionic_discharge
	name = "Psionic Discharge"
	desc = "Try to discharge battery and convert electricity into raw psionic energy."
	button_icon = 'modular_nova/modules/aesthetics/cells/icons/cell.dmi'
	button_icon_state = "icell"
	cooldown_time = 30 SECONDS
	mana_cost = 0
	stamina_cost = 15
	hand_path = /obj/item/melee/touch_attack/psionic_mending
	draw_message = span_notice("You ready your hand to discharge an energy source.")
	drop_message = span_notice("You lower your hand.")
	can_cast_on_self = FALSE

/datum/action/cooldown/spell/touch/psionic/psionic_discharge/is_valid_target(atom/cast_on)
	return isatom(cast_on)

/datum/action/cooldown/spell/touch/psionic/psionic_discharge/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/mendicant)
	if(HAS_TRAIT(mendicant, TRAIT_MINDSHIELD)) // Womp womp
		to_chat(mendicant, span_warning("As soon as you touch [victim], your energy dissipates without a trace. Mindshield implant messes up your concentration."))
		return FALSE
	if(istype(victim, /obj/item/stock_parts/power_store) || istype(victim, /obj/machinery/power/apc))
		owner.visible_message(span_warning("[owner] presses his hands against [victim]."),
							  span_notice("You press your hands against [victim]."),
							  blind_message = span_hear("You hear electrical crackling."))
		if(do_after(mendicant, 2.5 SECONDS, victim, IGNORE_SLOWDOWNS, TRUE))
			var/datum/psionic/psi_holder = mendicant.get_psionic()
			if(!psi_holder)
				return FALSE
			if(istype(victim, /obj/item/stock_parts/power_store))
				var/obj/item/stock_parts/power_store/batt = victim
				var/to_charge = (batt.charge / STANDARD_CELL_VALUE)
				batt.use(batt.charge(), TRUE)
				psi_holder.mana_level = clamp(psi_holder.mana_level + to_charge, 0, psi_holder.max_mana)
			else if(istype(victim, /obj/machinery/power/apc))
				var/obj/machinery/power/apc/target_apc = victim
				var/obj/item/stock_parts/power_store/batt = target_apc.cell
				if(!batt)
					to_chat(owner, span_notice("There is no battery in this APC."))
					return FALSE
				var/to_charge = (batt.charge() / (STANDARD_BATTERY_CHARGE/10))
				batt.use(batt.charge(), TRUE)
				psi_holder.mana_level = clamp(psi_holder.mana_level + to_charge, 0, psi_holder.max_mana)
			else
				to_chat(owner, span_notice("You've failed to discharge energy."))
		return TRUE
	else
		return FALSE

// Создаёт искры в указанном месте
/datum/action/cooldown/spell/pointed/psionic/psionic_spark
	name = "Psionic Spark"
	desc = "Cause some sparks to appear at a place of your choice."
	button_icon = 'icons/effects/effects.dmi'
	button_icon_state = "blessed"
	cooldown_time = 1 SECONDS
	mana_cost = 10
	active_msg = "You prepare to create sparks..."

/datum/action/cooldown/spell/pointed/psionic/psionic_spark/is_valid_target(atom/cast_on)
	if(!isturf(cast_on))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/psionic_spark/cast(turf/cast_on)
	. = ..()
	var/mob/living/carbon/human/caster = owner
	caster.emote_snap()
	var/datum/effect_system/basic/spark_spread/sparks = new (src, 1, FALSE)
	sparks.attach(cast_on)
	sparks.start()
	drain_mana()
	return TRUE

// Стреляет по направлению куклы псионика фотонной пушкой. Считайте аналог флешки
/datum/action/cooldown/spell/basic_projectile/psionic_laser
	name = "Photon Laser"
	desc = "Channels psionic energy into a weak concentrated photon laser."
	button_icon = 'icons/obj/weapons/guns/projectiles.dmi'
	button_icon_state = "solarflare"
	cooldown_time = 0 SECONDS
	spell_requirements = NONE
	mana_cost = 10
	projectile_type = /obj/projectile/energy/photon

/datum/action/cooldown/spell/basic_projectile/psionic_laser/cast(atom/cast_on)
	var/mob/living/carbon/human/caster = owner
	var/datum/psionic/psi_holder = caster.get_psionic()
	if(!(psi_holder && (psi_holder.mana_level - mana_cost) >= 0))
		return FALSE
	else
		psi_holder.mana_level -= mana_cost
	..()

// Создаёт ЕМП в месте удара руки
/datum/action/cooldown/spell/touch/psionic/psionic_emp
	name = "Psionic EMP"
	desc = "Try to cause a small local EMP."
	button_icon = 'icons/obj/weapons/grenade.dmi'
	button_icon_state = "emp"
	cooldown_time = 15 SECONDS
	mana_cost = 40
	stamina_cost = 40
	hand_path = /obj/item/melee/touch_attack/psionic_mending
	draw_message = span_notice("You ready your hand to cause an EMP.")
	drop_message = span_notice("You lower your hand.")
	can_cast_on_self = TRUE

/datum/action/cooldown/spell/touch/psionic/psionic_emp/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/mendicant)
	if(isatom(victim))
		empulse(victim, 1, cast_power/2)
		drain_mana()
		return TRUE
	else
		return FALSE

// Даёт мутацию Shock Touch
/datum/action/cooldown/spell/psionic/psionic_electrocute
	name = "Psionic Shock Touch"
	desc = "Force yourself to recieve shock touch mutation."
	cooldown_time = 60 SECONDS
	mana_cost = 60
	stamina_cost = 60

/datum/action/cooldown/spell/psionic/psionic_electrocute/is_valid_target(atom/cast_on)
	return !issynthetic(cast_on)

/datum/action/cooldown/spell/psionic/psionic_electrocute/cast(mob/living/cast_on)
	. = ..()
	if(!ishuman(cast_on))
		return FALSE
	var/mob/living/carbon/human/to_mutate = cast_on
	if(!to_mutate.can_mutate())
		return FALSE
	to_mutate.dna.add_mutation(/datum/mutation/shock, MUTATION_SOURCE_ACTIVATED)
	drain_mana()
	return TRUE
