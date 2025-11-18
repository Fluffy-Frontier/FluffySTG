/// TGMC_XENOS (old nova sector xenos)

/mob/living/carbon/alien/adult/tgmc
	name = "rare bugged alien"
	icon = 'tff_modular/modules/tgmc_xenos/icons/big_xenos.dmi'
	hud_possible = list(ANTAG_HUD, XENO_HUD, XENOPLASMA_HUD)
	rotate_on_lying = FALSE
	base_pixel_w = -16
	layer = LARGE_MOB_LAYER //above most mobs, but below speechbubbles
	maptext_height = 64
	maptext_width = 64
	pressure_resistance = 200

	armor_type = /datum/armor/tgmc_xeno

	bodyparts = list(
		/obj/item/bodypart/chest/alien/tgmc,
		/obj/item/bodypart/head/alien/tgmc,
		/obj/item/bodypart/arm/left/alien/tgmc,
		/obj/item/bodypart/arm/right/alien/tgmc,
		/obj/item/bodypart/leg/right/alien/tgmc,
		/obj/item/bodypart/leg/left/alien/tgmc,
	)

	default_organ_types_by_slot = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain/alien,
		ORGAN_SLOT_XENO_HIVENODE = /obj/item/organ/alien/hivenode,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/alien,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes/alien/tgmc,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver/alien,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach/alien,
	)

	/// What icon file update_held_items will look for when making inhands for xenos
	var/alt_inhands_file = 'tff_modular/modules/tgmc_xenos/icons/big_xenos.dmi'
	/// Setting this will give a xeno generic_evolve set to evolve them into this type
	var/next_evolution
	/// Keeps track of if a xeno has evolved recently, if so then we prevent them from evolving until that time is up
	var/has_evolved_recently = FALSE
	/// How long xenos should be unable to evolve after recently evolving
	var/evolution_cooldown_time = 90 SECONDS
	/// Determines if a xeno is unable to use abilities
	var/unable_to_use_abilities = FALSE
	/// Все дополнительные органы, что должны находиться в телах ксеносов
	var/list/additional_organ_types_by_slot

	// Оффсет для огня
	var/fire_offset_x = 16
	var/fire_offset_y = 0

	// АП при атаке по мехам
	var/mecha_armor_penetration = 15
	// Способность выдержать тяжелые удары мехов и не потерять сознание
	var/resist_heavy_hits = FALSE

	// Включен ли в данный момент фортифай
	var/fortify = FALSE

	// Может ли переносить хагов
	var/can_hold_facehugger = FALSE

/mob/living/carbon/alien/adult/tgmc/Initialize(mapload)
	. = ..()
	real_name = "alien [caste]"

	update_offsets() // Необходимо, чтобы base_pixel_w применился
	set_armor(armor_type)

	var/datum/atom_hud/data/xeno/xeno_hud = GLOB.huds[DATA_HUD_XENO]
	xeno_hud.add_atom_to_hud(src)
	xeno_hud_set_plasma()

	if(next_evolution)
		GRANT_ACTION(/datum/action/cooldown/alien/tgmc/generic_evolve)

	add_traits(list(TRAIT_XENO_HEAL_AURA, TRAIT_PIERCEIMMUNE, TRAIT_XENO_HUD), TRAIT_XENO_INNATE)
	AddElement(/datum/element/resin_walker, /datum/movespeed_modifier/resin_speedup)
	AddComponent(/datum/component/seethrough_mob)

/mob/living/carbon/alien/adult/tgmc/create_internal_organs()
	if(additional_organ_types_by_slot)
		for(var/slot in additional_organ_types_by_slot)
			default_organ_types_by_slot[slot] = additional_organ_types_by_slot[slot]
	return ..()

/mob/living/carbon/alien/adult/tgmc/UnarmedAttack(atom/attack_target, proximity_flag, list/modifiers)
	if(body_position == LYING_DOWN) // Лежим - значит отдыхаем. Никакой войны во время отдыха
		return FALSE
	if(fortify)
		return FALSE
	if(ishuman(attack_target))
		var/mob/living/carbon/human/target = attack_target
		if(target.stat == DEAD)
			to_chat(src, span_warning("[target] is dead, why would we want to touch it?"))
			return FALSE
	return ..()

/mob/living/carbon/alien/adult/tgmc/set_resting(new_resting, silent = TRUE, instant = FALSE)
	if(fortify)
		balloon_alert(src, "Cannot while fortified")
		return FALSE
	return ..()

/mob/living/carbon/alien/adult/tgmc/on_lying_down(new_lying_angle)
	. = ..()
	ADD_TRAIT(src, TRAIT_IMMOBILIZED, LYING_DOWN_TRAIT)

/mob/living/carbon/alien/adult/tgmc/on_standing_up()
	. = ..()
	REMOVE_TRAIT(src, TRAIT_IMMOBILIZED, LYING_DOWN_TRAIT)

/mob/living/carbon/alien/adult/tgmc/getarmor(def_zone, type)
	return get_armor_rating(type)

/datum/armor/tgmc_xeno
	acid = 100
	bio = 100
	bomb = 0
	bullet = 0
	consume = 0
	energy = 0
	laser = 0
	fire = 0
	melee = 0
	wound = 100

/mob/living/carbon/alien/adult/tgmc/get_fire_overlay(stacks, on_fire)
	var/fire_icon = "generic_fire"

	if(!GLOB.fire_appearances[fire_icon])
		var/mutable_appearance/new_fire_overlay = mutable_appearance(
			'icons/mob/effects/onfire.dmi',
			fire_icon,
			-HIGHEST_LAYER,
			appearance_flags = RESET_COLOR,
		)
		var/matrix/M = matrix(fire_offset_x, fire_offset_y, MATRIX_TRANSLATE)
		new_fire_overlay.transform = M
		GLOB.fire_appearances[fire_icon] = new_fire_overlay

	return GLOB.fire_appearances[fire_icon]

/mob/living/carbon/alien/adult/tgmc/add_shared_particles(particle_type, custom_key, particle_flags, pool_size)
	. = ..()
	var/obj/particle_holder = .
	particle_holder.pixel_x = fire_offset_x
	particle_holder.pixel_y = fire_offset_y

/mob/living/carbon/proc/get_max_plasma()
	var/obj/item/organ/alien/plasmavessel/vessel = get_organ_by_type(/obj/item/organ/alien/plasmavessel)
	if(isnull(vessel))
		return 0
	return vessel.max_plasma

/mob/living/carbon/alien/adult/tgmc/adjustPlasma(amount)
	. = ..()
	if(.)
		SEND_SIGNAL(src, COMSIG_XENO_PLASMA_ADJUSTED, amount)
