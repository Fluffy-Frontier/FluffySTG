/// TGMC_XENOS (old nova sector xenos)

/mob/living/carbon/alien/adult/tgmc/queen
	name = "alien queen"
	desc = "A hulking beast of an alien, for some reason this one seems more important than the others, you should probably quit staring at it and do something."
	icon_state = "alienqueen"
	caste = "queen"
	maxHealth = 350
	health = 350
	mob_size = MOB_SIZE_LARGE
	melee_damage_lower = 30
	melee_damage_upper = 35
	alien_speed = 2

	armor_type = /datum/armor/tgmc_xeno/queen

	additional_organ_types_by_slot = list(
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel/tgmc/large/queen,
		ORGAN_SLOT_XENO_RESINSPINNER = /obj/item/organ/alien/resinspinner,
		ORGAN_SLOT_XENO_ACIDGLAND = /obj/item/organ/alien/acid/tgmc/large,
		ORGAN_SLOT_XENO_NEUROTOXINGLAND = /obj/item/organ/alien/neurotoxin/tgmc/queen,
		ORGAN_SLOT_XENO_EGGSAC = /obj/item/organ/alien/eggsac/tgmc,
	)

	mecha_armor_penetration = 45
	resist_heavy_hits = TRUE

/mob/living/carbon/alien/adult/tgmc/queen/Initialize(mapload)
	. = ..()
	var/static/list/innate_actions = list(
		/datum/action/cooldown/spell/aoe/repulse/xeno/tgmc_tailsweep/hard_throwing,
		/datum/action/cooldown/alien/tgmc/queen_screech,
	)
	grant_actions_by_list(innate_actions)

	REMOVE_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/datum/armor/tgmc_xeno/queen
	bomb = 30
	bullet = 40
	energy = 65
	laser = 65
	fire = 60
	melee = 60

/mob/living/carbon/alien/adult/tgmc/queen/alien_talk(message, list/spans = list(), list/message_mods = list(), shown_name = name, big_voice = TRUE)
	..(message, spans, message_mods, shown_name, TRUE)

/mob/living/carbon/alien/adult/tgmc/queen/death(gibbed)
	if(stat == DEAD)
		return

	for(var/mob/living/carbon/carbon_mob in GLOB.alive_mob_list)
		if(carbon_mob == src)
			continue

		var/obj/item/organ/alien/hivenode/node = carbon_mob.get_organ_by_type(/obj/item/organ/alien/hivenode)

		if(istype(node))
			node.queen_death()

	return ..()

/datum/action/cooldown/alien/tgmc/queen_screech
	name = "Deafening Screech"
	desc = "Let out a screech so deafeningly loud that anything with the ability to hear around you will likely be incapacitated for a short time."
	button_icon_state = "screech"
	cooldown_time = 3 MINUTES

/datum/action/cooldown/alien/tgmc/queen_screech/Activate()
	. = ..()
	var/mob/living/carbon/alien/adult/tgmc/queenie = owner
	playsound(queenie, 'tff_modular/modules/tgmc_xenos/sound/alien_queen_screech.ogg', 100, FALSE, 8, 0.9)
	queenie.create_shriekwave()
	shake_camera(owner, 2, 2)

	owner.visible_message(span_doyourjobidiot("[queenie] lets out a deafening screech!"), self_message = span_revenbignotice("You emits an ear-splitting guttural roar!"))

	for(var/mob/living/carbon/screech_target in get_hearers_in_range(9, get_turf(queenie)))

		if(isalien(screech_target))
			shake_camera(screech_target, 10, 1)
			continue
		else
			shake_camera(screech_target, 30, 1)

		var/distance_to_target = get_dist(queenie, screech_target)
		if(distance_to_target <= 4)
			to_chat(src, span_danger("An ear-splitting guttural roar shakes the ground beneath your feet!"))
			screech_target.AdjustParalyzed(80)
		else if(distance_to_target >= 5 && distance_to_target < 7)
			to_chat(src, span_danger("The roar shakes your body to the core, freezing you in place!"))
			screech_target.AdjustStun(40)

	return TRUE

/mob/living/carbon/alien/adult/tgmc/proc/create_shriekwave()
	remove_overlay(HALO_LAYER)
	overlays_standing[HALO_LAYER] = image("icon" = 'tff_modular/modules/tgmc_xenos/icons/big_xenos.dmi', "icon_state" = "shriek_waves") //Ehh, suit layer's not being used.
	apply_overlay(HALO_LAYER)
	addtimer(CALLBACK(src, PROC_REF(remove_shriekwave)), 3 SECONDS)

/mob/living/carbon/alien/adult/tgmc/proc/remove_shriekwave()
	remove_overlay(HALO_LAYER)

/mob/living/carbon/alien/adult/tgmc/queen/findQueen()
	return	// Королева и так знает свое местоположение
