#define NABBER_DAMAGE_ONBURNING 5

/datum/species/nabber
	name = "Giant Armored Serpentid"
	id = SPECIES_NABBER
	can_augment = FALSE
	veteran_only = TRUE
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CHUNKYFINGERS_IGNORE_BATON,
		TRAIT_PUSHIMMUNE,
		TRAIT_LIGHT_STEP,	//В связи с балансными причинами и соображениями логики.
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_RESISTCOLD,
		TRAIT_MUTANT_COLORS,
		TRAIT_NO_UNDERWEAR,
		TRAIT_HARD_SOLES,
		TRAIT_NO_BLOOD_OVERLAY,
		TRAIT_NO_SLIP_WATER,
		TRAIT_BRAWLING_KNOCKDOWN_BLOCKED,
	)
	body_size_restricted = TRUE
	digitigrade_customization = DIGITIGRADE_NEVER
	no_equip_flags = ITEM_SLOT_FEET | ITEM_SLOT_OCLOTHING | ITEM_SLOT_SUITSTORE | ITEM_SLOT_EYES | ITEM_SLOT_LEGCUFFED
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutanttongue = /obj/item/organ/internal/tongue/nabber
	always_customizable = TRUE
	hair_alpha = 0
	facial_hair_alpha = 0
	payday_modifier = 0.75
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	species_cookie = /obj/item/food/grown/cabbage
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 10)
	mutantbrain = /obj/item/organ/internal/brain/nabber
	mutanteyes = /obj/item/organ/internal/eyes/nabber
	mutantlungs = /obj/item/organ/internal/lungs/nabber
	mutantheart = /obj/item/organ/internal/heart/nabber
	mutantliver = /obj/item/organ/internal/liver/nabber
	mutantears = /obj/item/organ/internal/ears/nabber
	mutantappendix = null
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/nabber,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/nabber,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/nabber,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/nabber,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/nabber,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/nabber,
	)
	custom_worn_icons = list(
		LOADOUT_ITEM_HEAD = NABBER_HEAD_ICON,
		LOADOUT_ITEM_MASK = NABBER_MASK_ICON,
		LOADOUT_ITEM_UNIFORM = NABBER_UNIFORM_ICON,
		LOADOUT_ITEM_HANDS =  NABBER_HANDS_ICON,
		LOADOUT_ITEM_BELT = NABBER_BELT_ICON,
		LOADOUT_ITEM_MISC = NABBER_BACK_ICON,
		LOADOUT_ITEM_EARS = NABBER_EARS_ICON
	)
	var/datum/action/cooldown/toggle_arms/arms
	var/datum/action/cooldown/optical_camouflage/camouflage
	var/datum/action/cooldown/nabber_threat/threat_mod
	var/obj/item/restraints/legcuffs/gas_placeholder/anti_cuffs
	species_language_holder = /datum/language_holder/nabber
	language_prefs_whitelist = list(/datum/language/nabber)

/datum/species/nabber/on_species_gain(mob/living/carbon/human/C, datum/species/old_species, pref_load)
	. = ..()
	arms = new(C)
	arms.Grant(C)
	camouflage = new(C)
	camouflage.Grant(C)
	threat_mod = new(C)
	threat_mod.Grant(C)

	var/is_dummy = istype(C, /mob/living/carbon/human/dummy)

	if(!is_dummy)
		anti_cuffs = new()
		C.equip_to_slot(anti_cuffs, ITEM_SLOT_LEGCUFFED, initial = TRUE)

		var/obj/item/implant/gas_sol_speaker/imp_in = new()
		imp_in.implant(C)

/datum/species/nabber/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	arms.Destroy()
	camouflage.Destroy()
	threat_mod.Destroy()

	if(anti_cuffs)
		anti_cuffs.Destroy()
		anti_cuffs = null

	if(C.legcuffed)
		C.legcuffed.Destroy()
		C.legcuffed = null

/datum/species/nabber/spec_life(mob/living/carbon/human/H, seconds_per_tick, times_fired)
	// Вызываем это перед проверкой на смерть, чтобы даже у мёртвых ГБСов была заглушка
	if(H.num_legs >= 2 && QDELETED(anti_cuffs))
		anti_cuffs = new()
		H.equip_to_slot(anti_cuffs, ITEM_SLOT_LEGCUFFED, initial = TRUE)
	. = ..()
	if(isdead(H))
		return
	//Огонь вызывает у ГБС асфиксию. Им лучше не гореть.
	if(H.on_fire)
		H.apply_damage(NABBER_DAMAGE_ONBURNING, OXY)

/datum/species/nabber/randomize_features(mob/living/carbon/human/human_mob)
	var/list/features = ..()
	var/main_color
	var/random = rand(1,6)
	switch(random)
		if(1)
			main_color = "#44FF77"
		if(2)
			main_color = "#227900"
		if(3)
			main_color = "#c40000"
		if(4)
			main_color = "#660000"
		if(5)
			main_color = "#c0ad00"
		if(6)
			main_color = "#e6ff03"
	features["mcolor"] = main_color
	features["mcolor2"] = main_color
	features["mcolor3"] = main_color
	return features

/datum/species/nabber/prepare_human_for_preview(mob/living/carbon/human/nabber)
	var/nabber_color = "#00ac1d"
	nabber.dna.features["mcolor"] = nabber_color
	nabber.dna.features["mcolor2"] = nabber_color
	nabber.dna.features["mcolor3"] = nabber_color
	regenerate_organs(nabber, src, visual_only = TRUE)
	nabber.update_body(TRUE)

/datum/species/nabber/create_pref_unique_perks()
	var/list/perk_descriptions = list()

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "dna",
		SPECIES_PERK_NAME = "Serpent body",
		SPECIES_PERK_DESC = "GAS possess serpent-like bodies and cannot wear most human clothes."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "dna",
		SPECIES_PERK_NAME = "Robust chitin",
		SPECIES_PERK_DESC = "GAS possess durable chitinous exoskeletons and can withstand a lot of brute damage."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "star-of-life",
		SPECIES_PERK_NAME = "Extreme heat weakness",
		SPECIES_PERK_DESC = "GAS is afraid of fire. High temperatures and open flames suffocate them and deal massive damage.."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "user-plus",
		SPECIES_PERK_NAME = "Welder eyelids",
		SPECIES_PERK_DESC = "GAS can close their second pair of eyelids to protect their eyes from welder flash."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "user-plus",
		SPECIES_PERK_NAME = "Mantis arms",
		SPECIES_PERK_DESC = "GAS possesses a second pair of arms with massive sharp mantis blades. They can have only one pair active at a time and need to pump blood between them."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "user-plus",
		SPECIES_PERK_NAME = "Camoufage",
		SPECIES_PERK_DESC = "GAS can blend in with their surroundings and become transparent to hide from danger."
	))

	return perk_descriptions

/datum/species/nabber/get_species_description()
	return placeholder_description

/datum/species/nabber/get_species_lore()
	return list(placeholder_lore)

/mob/living/carbon/human/species/nabber
	race = /datum/species/nabber

// Отображение для других наличия повреждений у голосового импланта
/mob/living/carbon/human/examine(mob/user)
	. = ..()

	if(isnabber(src))
		var/is_really_borked = FALSE
		for(var/obj/item/implant/gas_sol_speaker/imp in implants)
			var/is_borked = imp.emp_damage
			if (is_borked > 0)
				is_really_borked = TRUE
		if(is_really_borked)
			. += span_notice("[user.p_Their()] speech synthesizer emits constant silent white noise.") + "\n"

// Не заковывается при наличии кос
/mob/living/carbon/human/canBeHandcuffed()
	if(isnabber(src))
		var/obj/item/held = get_active_held_item()
		var/obj/item/inactive = get_inactive_held_item()
		if(istype((inactive || held), /obj/item/melee/nabber_blade))
			return FALSE
	. = ..()

// В режиме кос агро грабы не будут замедлять
/mob/living/carbon/human/add_movespeed_modifier(datum/movespeed_modifier/type_or_datum, update = TRUE)
	if(isnabber(src) && type_or_datum == /datum/movespeed_modifier/grab_slowdown/aggressive)
		var/datum/species/nabber/our_nabber = src.dna.species
		var/datum/action/cooldown/toggle_arms/arms = our_nabber.arms
		if(arms.button_icon_state == "arms_on")
			return FALSE
	return ..()

// ЧС квирков
/mob/living/carbon/human/add_quirk(datum/quirk/quirktype, client/override_client)
	var/bad_nabber_quirks = list(/datum/quirk/oversized, /datum/quirk/prosthetic_limb, /datum/quirk/quadruple_amputee) // Дополнить
	if(isnabber(src) && quirktype in bad_nabber_quirks)
		return FALSE
	. = ..()
