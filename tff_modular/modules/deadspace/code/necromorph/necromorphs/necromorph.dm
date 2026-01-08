/mob/living/carbon/human/necromorph/Initialize(mapload, obj/structure/marker/marker_master)
	. = ..()

	var/mob/living/carbon/human/necromorph/necro_owner = src
	necro_owner.physiology.armor = necro_owner.physiology.armor.add_other_armor(src.necro_armor)
	necro_owner.physiology.burn_mod = 1.1

	if(!marker_master)
		return INITIALIZE_HINT_QDEL

	fully_replace_character_name(real_name, "[initial(class.display_name)] [rand(1, 999)]")

	marker = marker_master
	marker_master.add_necro(src)
	var/datum/necro_class/temp = marker_master.necro_classes[class]
	temp.load_data(src)
	RegisterSignal(src, COMSIG_CARBON_CUFF_ATTEMPTED, PROC_REF(prevent_cuff))

/mob/living/carbon/human/necromorph/Destroy()
	UnregisterSignal(src, COMSIG_CARBON_CUFF_ATTEMPTED)
	evacuate()
	marker?.remove_necro(src)
	return ..()

/mob/living/carbon/human/necromorph/examine(mob/user)
	. = ..()
	if(previous_owner)
		. += previous_owner

/mob/living/carbon/human/necromorph/mind_initialize()
	. = ..()
	var/datum/antagonist/necromorph/necromorph = mind.has_antag_datum(/datum/antagonist/necromorph)
	if(!necromorph)
		mind.add_antag_datum(/datum/antagonist/necromorph)

/mob/living/carbon/human/necromorph/update_damage_overlays()
	return

/mob/living/carbon/human/necromorph/update_wound_overlays()
	return

//We should be always able to attack our opponents
/mob/living/carbon/human/necromorph/has_active_hand()
	return TRUE

//This messes with bloody hands, we don't want those on necros yet due to having no custom sprites for it
/mob/living/carbon/human/necromorph/update_worn_gloves(update_obscured)
	return

//This had to be moved from species due to code improvements
/mob/living/carbon/human/necromorph/apply_damage(damage, damagetype = BRUTE, def_zone = null, blocked, forced = FALSE, spread_damage = FALSE, wound_bonus = 0, exposed_wound_bonus = 0, sharpness = NONE, attack_direction = null, attacking_item, wound_clothing)
	if(dodge_shield > 0)
		// Calculate amount of the damage that was blocked by the shield
		var/dodged_damage = min(dodge_shield, damage, damage * (100 - blocked) / 100)
		reduce_shield(dodged_damage)
		blocked += (dodged_damage / damage) * 100
	return ..()

/mob/living/carbon/human/necromorph/updatehealth()
	if(HAS_TRAIT(src, TRAIT_GODMODE))
		return

	set_health(maxHealth - get_fire_loss() - get_brute_loss() - get_tox_loss())
	update_stat()
	SEND_SIGNAL(src, COMSIG_CARBON_UPDATING_HEALTH_HUD)
	if(hud_used)
		var/datum/hud/necromorph/hud = hud_used
		hud.update_healthbar(src)

/mob/living/carbon/human/necromorph/revive(full_heal_flags = NONE, excess_healing = 0, force_grab_ghost = FALSE)
	.=..()
	marker?.add_necro(src)

/mob/living/carbon/human/necromorph/set_stat(new_stat)
	.=..()
	update_sight()

/mob/living/carbon/human/necromorph/death(gibbed)
	marker?.remove_necro(src)
	if(controlling)
		controlling.forceMove(loc)
		controlling.body = null
		mind.transfer_to(controlling, TRUE)
	return ..()

/mob/living/carbon/human/necromorph/create_dna()
	dna = new /datum/dna(src)
	dna.species = new necro_species

/mob/living/carbon/human/necromorph/update_stat()
	if(HAS_TRAIT(src, TRAIT_GODMODE))
		return
	if(stat != DEAD)
		if(handle_death_check())
			death()
			return
		else
			set_stat(CONSCIOUS)
	update_damage_hud()
	update_health_hud()
	update_stamina_hud()

/// Check if the necromorph should die
/mob/living/carbon/human/necromorph/proc/handle_death_check()
	return (health <= 0 && !HAS_TRAIT(src, TRAIT_NODEATH))

/mob/living/carbon/human/necromorph/proc/prevent_cuff(datum/source, mob/attemptee)
	SIGNAL_HANDLER
	return COMSIG_CARBON_CUFF_PREVENT

/mob/living/carbon/human/necromorph/toggle_throw_mode()
	return

/mob/living/carbon/human/necromorph/throw_item(atom/target)
	return
