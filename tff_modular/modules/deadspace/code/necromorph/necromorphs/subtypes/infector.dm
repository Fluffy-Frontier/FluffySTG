/mob/living/carbon/human/necromorph/infector
	health = 90
	maxHealth = 90
	class = /datum/necro_class/infector
	necro_species = /datum/species/necromorph/infector
	var/mob/eye/signal/biomass_source
	var/current_biomass = 0

/mob/living/carbon/human/necromorph/infector/Initialize(mapload, obj/structure/marker/marker_master)
	. = ..()
	add_movespeed_modifier(/datum/movespeed_modifier/dsnecro_faster)
	AddComponent(/datum/component/execution/infector)

/mob/living/carbon/human/necromorph/infector/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.infector_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/infector
	display_name = "Infector"
	desc = "A high value, fragile support, the Infector works as a builder and healer"
	necromorph_type_path = /mob/living/carbon/human/necromorph/infector
	biomass_cost = 350
	biomass_spent_required = 350
	melee_damage_lower = 10
	melee_damage_upper = 16
	necro_armor = /datum/armor/dsnecro_infector
	actions = list(
		/datum/action/cooldown/mob_cooldown/charge/necro/execution/infector,
		/datum/action/cooldown/necro/infector_proboscis,
		/datum/action/cooldown/necro/shout,
		//datum/action/innate/sense,
		/datum/action/cooldown/necro/corruption/infector,
	)
	implemented = TRUE

/datum/armor/dsnecro_infector
	melee = 25
	bullet = 40
	laser = 0
	energy = 0
	bomb = 15
	bio = 75
	fire = 15
	acid = 95

/datum/species/necromorph/infector
	name = "Infector"
	id = SPECIES_NECROMORPH_INFECTOR
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/infector,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/infector,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/infector,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/infector,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/infector,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/infector,
	)
	mutant_organs = list(
		/obj/item/organ/proboscis,
	)

/datum/species/necromorph/infector/get_scream_sound(mob/living/carbon/human/necromorph/infector)
	return pick(
		'tff_modular/modules/deadspace/sound/effects/creatures/necromorph/infector/infector_shout_long_1.ogg',
		'tff_modular/modules/deadspace/sound/effects/creatures/necromorph/infector/infector_shout_long_2.ogg',
		'tff_modular/modules/deadspace/sound/effects/creatures/necromorph/infector/infector_shout_long_3.ogg',
	)


/*
*
*		ORGANS
*
*/

//This is a proc so it can be used in another place later
/mob/living/carbon/human/necromorph/infector/proc/inject_necrotoxin(var/mob/living/L, var/quantity = 5)
	if (istype(L) && !(isnecromorph(L)))
		if (!L.reagents.has_reagent(/datum/reagent/toxin/necro))
			to_chat(L, "<span class='warning'>You feel a tiny prick.</span>")
		L.reagents.add_reagent(/datum/reagent/toxin/necro, quantity)

/datum/reagent/toxin/necro
	name = "Necrotoxin"
	description = "A vile substance that gradually corrupts the body."
	taste_description = "rotting flesh"
	color = "#4c3b34"
	overdose_threshold = 100 //Basically impossible to OD on, but turns into a worse toxin
	metabolization_rate = REM * 0.125	//Slow acting poison, but really strong

/datum/reagent/toxin/necro/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	//affected_mob.reagents.remove_reagent(/datum/reagent/dylovene, removed) // Requires the occasional extra dose of dylovene
	if(volume > 45) // Short lived effect, warns the player that they've taken too much necrotox in a short period of time.
		//affected_mob.add_chemical_effect(CE_SLOWDOWN, 2)
		affected_mob.reagents.remove_reagent(/datum/reagent/toxin/necro, 50 * 1) //Rapidly converts necrotoxin into a worse variant
		affected_mob.reagents.add_reagent(/datum/reagent/toxin/necro/lethal, 25 * 1)
		if(prob(75))
			affected_mob.emote("scream");
			to_chat(affected_mob, span_notice("Your insides briefly twist and burn! Something's wrong!"))

/datum/reagent/toxin/necro/lethal
	name = "Necrax toxin"
	description = "A much deadlier variant of the enigmatic, corrupting substance."
	taste_description = "corpse bile"
	color = "#bd3c3c"
	overdose_threshold = 6 //Technically it takes 62+ necrotox to get a deadly dose here! Difficult to cure without dialysis
	metabolization_rate = REM * 0.125

/datum/reagent/toxin/necro/lethal/overdose_start(mob/living/affected_mob)
	//affected_mob.add_chemical_effect(CE_TOXIN, 1.5) // damages the liver directly, should the liver die, recovery is unlikely
	//affected_mob.heal_organ_damage(0.25, 0.25) //heals you! This makes a necro conversion far more likely.
	affected_mob.adjustToxLoss(REM * 4) // 500% base strength, or 10x as strong as normal necrotoxin
	//affected_mob.reagents.remove_reagent(/datum/reagent/dylovene, 0.25) // Purges dylovene slowly
	return

/*
	This proc attempts to determine if the victim was successfully corrupted by the toxin
	Toxin only converts people whose primary cause of death was itself. People who suffer violent deaths shouldn't count
*/
/datum/reagent/toxin/necro/proc/is_toxin_victim()
	var/mob/living/human = holder

	//If they were gibbed, dusted, or deleted, then they sure didn't die from poison. And they're invalid if not a mob too
	if (!iscarbon(human))
		return FALSE

	//They have to be already dead of course
	if (human.stat != DEAD)
		return

	//Alright now we want to figure out if the poison actually caused their death. This is a complicated problem
	//We're going to go with a simple solution which is not 100% foolproof, but will cover most use cases:
	//IF their toxloss is higher than their total violent damage (brute+burn) then they probably died of poison. If not, violence
	var/violence = (human.getBruteLoss() + human.getFireLoss()) * 0.5 //It's actually pretty hard to trigger this, this will make it a bit easier
	if (human.getToxLoss()	<=	violence)
		return

	if (human)
		//And lets see if they have their head. Decapitated victims cannot be converted
		if (!human.get_bodypart(BODY_ZONE_HEAD))
			return FALSE

	//Alright we're done, return true
	return TRUE
