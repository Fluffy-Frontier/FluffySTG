
/**
 * Applies damage to this mob.
 *
 * Sends [COMSIG_MOB_APPLY_DAMAGE]
 *
 * Arguuments:
 * * damage - Amount of damage
 * * damagetype - What type of damage to do. one of [BRUTE], [BURN], [TOX], [OXY], [STAMINA], [BRAIN].
 * * def_zone - What body zone is being hit. Or a reference to what bodypart is being hit.
 * * blocked - Percent modifier to damage. 100 = 100% less damage dealt, 50% = 50% less damage dealt.
 * * forced - "Force" exactly the damage dealt. This means it skips damage modifier from blocked.
 * * spread_damage - For carbons, spreads the damage across all bodyparts rather than just the targeted zone.
 * * wound_bonus - Bonus modifier for wound chance.
 * * exposed_wound_bonus - Bonus modifier for wound chance on bare skin.
 * * sharpness - Sharpness of the weapon.
 * * attack_direction - Direction of the attack from the attacker to [src].
 * * attacking_item - Item that is attacking [src].
 * * wound_clothing - If this should cause damage to clothing.
 *
 * Returns the amount of damage dealt.
 */
/mob/living/proc/apply_damage(
	damage = 0,
	damagetype = BRUTE,
	def_zone = null,
	blocked = 0,
	forced = FALSE,
	spread_damage = FALSE,
	wound_bonus = 0,
	exposed_wound_bonus = 0,
	sharpness = NONE,
	attack_direction = null,
	attacking_item,
	wound_clothing = TRUE,
)
	SHOULD_CALL_PARENT(TRUE)
	var/damage_amount = damage
	if(!forced)
		damage_amount *= ((100 - blocked) / 100)
		damage_amount *= get_incoming_damage_modifier(damage_amount, damagetype, def_zone, sharpness, attack_direction, attacking_item)
	if(damage_amount <= 0)
		return 0

	SEND_SIGNAL(src, COMSIG_MOB_APPLY_DAMAGE, damage_amount, damagetype, def_zone, blocked, wound_bonus, exposed_wound_bonus, sharpness, attack_direction, attacking_item, wound_clothing)

	var/damage_dealt = 0
	switch(damagetype)
		if(BRUTE)
			if(isbodypart(def_zone))
				var/obj/item/bodypart/actual_hit = def_zone
				var/delta = actual_hit.get_damage()
				if(actual_hit.receive_damage(
					brute = damage_amount,
					burn = 0,
					forced = forced,
					wound_bonus = wound_bonus,
					exposed_wound_bonus = exposed_wound_bonus,
					sharpness = sharpness,
					attack_direction = attack_direction,
					damage_source = attacking_item,
					wound_clothing = wound_clothing,
				))
					update_damage_overlays()
				damage_dealt = actual_hit.get_damage() - delta // Unfortunately bodypart receive_damage doesn't return damage dealt so we do it manually
			else
				damage_dealt = -1 * adjustBruteLoss(damage_amount, forced = forced)
			INVOKE_ASYNC(src, TYPE_PROC_REF(/mob/living, adjust_pain), damage_amount) // NOVA EDIT ADDITION - ERP Pain
		if(BURN)
			if(isbodypart(def_zone))
				var/obj/item/bodypart/actual_hit = def_zone
				var/delta = actual_hit.get_damage()
				if(actual_hit.receive_damage(
					brute = 0,
					burn = damage_amount,
					forced = forced,
					wound_bonus = wound_bonus,
					exposed_wound_bonus = exposed_wound_bonus,
					sharpness = sharpness,
					attack_direction = attack_direction,
					damage_source = attacking_item,
					wound_clothing = wound_clothing,
				))
					update_damage_overlays()
				damage_dealt = actual_hit.get_damage() - delta // See above
			else
				damage_dealt = -1 * adjustFireLoss(damage_amount, forced = forced)
			INVOKE_ASYNC(src, TYPE_PROC_REF(/mob/living, adjust_pain), damage_amount) // NOVA EDIT ADDITION - ERP Pain
		if(TOX)
			damage_dealt = -1 * adjustToxLoss(damage_amount, forced = forced)
		if(OXY)
			damage_dealt = -1 * adjustOxyLoss(damage_amount, forced = forced)
		if(STAMINA)
			damage_dealt = -1 * adjustStaminaLoss(damage_amount, forced = forced)
		if(BRAIN)
			damage_dealt = -1 * adjustOrganLoss(ORGAN_SLOT_BRAIN, damage_amount)

	SEND_SIGNAL(src, COMSIG_MOB_AFTER_APPLY_DAMAGE, damage_dealt, damagetype, def_zone, blocked, wound_bonus, exposed_wound_bonus, sharpness, attack_direction, attacking_item, wound_clothing)
	return damage_dealt

/**
 * Used in tandem with [/mob/living/proc/apply_damage] to calculate modifier applied into incoming damage
 */
/mob/living/proc/get_incoming_damage_modifier(
	damage = 0,
	damagetype = BRUTE,
	def_zone = null,
	sharpness = NONE,
	attack_direction = null,
	attacking_item,
)
	SHOULD_CALL_PARENT(TRUE)
	SHOULD_BE_PURE(TRUE)

	var/list/damage_mods = list()
	SEND_SIGNAL(src, COMSIG_MOB_APPLY_DAMAGE_MODIFIERS, damage_mods, damage, damagetype, def_zone, sharpness, attack_direction, attacking_item)

	var/final_mod = 1
	for(var/new_mod in damage_mods)
		final_mod *= new_mod
	return final_mod

/**
 * Simply a wrapper for calling mob adjustXLoss() procs to heal a certain damage type,
 * when you don't know what damage type you're healing exactly.
 */
/mob/living/proc/heal_damage_type(heal_amount = 0, damagetype = BRUTE)
	heal_amount = abs(heal_amount) * -1

	switch(damagetype)
		if(BRUTE)
			return adjustBruteLoss(heal_amount)
		if(BURN)
			return adjustFireLoss(heal_amount)
		if(TOX)
			return adjustToxLoss(heal_amount)
		if(OXY)
			return adjustOxyLoss(heal_amount)
		if(STAMINA)
			return adjustStaminaLoss(heal_amount)

/// return the damage amount for the type given
/**
 * Simply a wrapper for calling mob getXLoss() procs to get a certain damage type,
 * when you don't know what damage type you're getting exactly.
 */
/mob/living/proc/get_current_damage_of_type(damagetype = BRUTE)
	switch(damagetype)
		if(BRUTE)
			return getBruteLoss()
		if(BURN)
			return getFireLoss()
		if(TOX)
			return getToxLoss()
		if(OXY)
			return getOxyLoss()
		if(STAMINA)
			return getStaminaLoss()

/// return the total damage of all types which update your health
/mob/living/proc/get_total_damage(precision = DAMAGE_PRECISION)
	return round(getBruteLoss() + getFireLoss() + getToxLoss() + getOxyLoss(), precision)

/// Applies multiple damages at once via [apply_damage][/mob/living/proc/apply_damage]
/mob/living/proc/apply_damages(
	brute = 0,
	burn = 0,
	tox = 0,
	oxy = 0,
	def_zone = null,
	blocked = 0,
	stamina = 0,
	brain = 0,
)
	var/total_damage = 0
	if(brute)
		total_damage += apply_damage(brute, BRUTE, def_zone, blocked)
	if(burn)
		total_damage += apply_damage(burn, BURN, def_zone, blocked)
	if(tox)
		total_damage += apply_damage(tox, TOX, def_zone, blocked)
	if(oxy)
		total_damage += apply_damage(oxy, OXY, def_zone, blocked)
	if(stamina)
		total_damage += apply_damage(stamina, STAMINA, def_zone, blocked)
	if(brain)
		total_damage += apply_damage(brain, BRAIN, def_zone, blocked)
	return total_damage

/// applies various common status effects or common hardcoded mob effects
/mob/living/proc/apply_effect(effect = 0,effecttype = EFFECT_STUN, blocked = 0)
	var/hit_percent = (100-blocked)/100
	if(!effect || (hit_percent <= 0))
		return FALSE
	switch(effecttype)
		if(EFFECT_STUN)
			Stun(effect * hit_percent)
		if(EFFECT_KNOCKDOWN)
			Knockdown(effect * hit_percent)
		if(EFFECT_PARALYZE)
			Paralyze(effect * hit_percent)
		if(EFFECT_IMMOBILIZE)
			Immobilize(effect * hit_percent)
		if(EFFECT_UNCONSCIOUS)
			Unconscious(effect * hit_percent)

	return TRUE

/**
 * Applies multiple effects at once via [/mob/living/proc/apply_effect]
 *
 * Pretty much only used for projectiles applying effects on hit,
 * don't use this for anything else please just cause the effects directly
 */
/mob/living/proc/apply_effects(
		stun = 0,
		knockdown = 0,
		unconscious = 0,
		slur = 0 SECONDS, // Speech impediment, not technically an effect
		stutter = 0 SECONDS, // Ditto
		eyeblur = 0 SECONDS,
		drowsy = 0 SECONDS,
		blocked = 0, // This one's not an effect, don't be confused - it's block chance
		stamina = 0, // This one's a damage type, and not an effect
		jitter = 0 SECONDS,
		paralyze = 0,
		immobilize = 0,
	)

	if(blocked >= 100)
		return FALSE

	if(stun)
		apply_effect(stun, EFFECT_STUN, blocked)
	if(knockdown)
		apply_effect(knockdown, EFFECT_KNOCKDOWN, blocked)
	if(unconscious)
		apply_effect(unconscious, EFFECT_UNCONSCIOUS, blocked)
	if(paralyze)
		apply_effect(paralyze, EFFECT_PARALYZE, blocked)
	if(immobilize)
		apply_effect(immobilize, EFFECT_IMMOBILIZE, blocked)

	if(stamina)
		apply_damage(stamina, STAMINA, null, blocked)

	if(drowsy)
		adjust_drowsiness(drowsy)
	if(eyeblur)
		adjust_eye_blur_up_to(eyeblur, eyeblur)
	if(jitter && !check_stun_immunity(CANSTUN))
		adjust_jitter(jitter)
	if(slur)
		adjust_slurring(slur)
	if(stutter)
		adjust_stutter(stutter)

	return TRUE

/// Returns a multiplier to apply to a specific kind of damage
/mob/living/proc/get_damage_mod(damage_type)
	switch(damage_type)
		if (OXY)
			return HAS_TRAIT(src, TRAIT_NOBREATH) ? 0 : 1
		if (TOX)
			if (HAS_TRAIT(src, TRAIT_TOXINLOVER))
				return -1
			return HAS_TRAIT(src, TRAIT_TOXIMMUNE) ? 0 : 1
	return 1

/mob/living/proc/getBruteLoss()
	return bruteloss

/mob/living/proc/can_adjust_brute_loss(amount, forced, required_bodytype)
	if(!forced && HAS_TRAIT(src, TRAIT_GODMODE))
		return FALSE
	if(SEND_SIGNAL(src, COMSIG_LIVING_ADJUST_BRUTE_DAMAGE, BRUTE, amount, forced) & COMPONENT_IGNORE_CHANGE)
		return FALSE
	return TRUE

/mob/living/proc/adjustBruteLoss(amount, updating_health = TRUE, forced = FALSE, required_bodytype = ALL)
	if (!can_adjust_brute_loss(amount, forced, required_bodytype))
		return 0
	. = bruteloss
	bruteloss = clamp((bruteloss + (amount * CONFIG_GET(number/damage_multiplier))), 0, maxHealth * 2)
	. -= bruteloss
	if(!.) // no change, no need to update
		return 0
	if(updating_health)
		updatehealth()


/mob/living/proc/setBruteLoss(amount, updating_health = TRUE, forced = FALSE, required_bodytype = ALL)
	if(!forced && HAS_TRAIT(src, TRAIT_GODMODE))
		return FALSE
	. = bruteloss
	bruteloss = amount

	if(!.) // no change, no need to update
		return FALSE
	if(updating_health)
		updatehealth()
	. -= bruteloss

/mob/living/proc/getOxyLoss()
	return oxyloss

/mob/living/proc/can_adjust_oxy_loss(amount, forced, required_biotype, required_respiration_type)
	if(!forced)
		if(HAS_TRAIT(src, TRAIT_GODMODE))
			return FALSE
		if (required_respiration_type)
			var/obj/item/organ/lungs/affected_lungs = get_organ_slot(ORGAN_SLOT_LUNGS)
			if(isnull(affected_lungs))
				if(!(mob_respiration_type & required_respiration_type))  // if the mob has no lungs, use mob_respiration_type
					return FALSE
			else
				if(!(affected_lungs.respiration_type & required_respiration_type)) // otherwise use the lungs' respiration_type
					return FALSE
	if(SEND_SIGNAL(src, COMSIG_LIVING_ADJUST_OXY_DAMAGE, OXY, amount, forced) & COMPONENT_IGNORE_CHANGE)
		return FALSE
	return TRUE

/mob/living/proc/adjustOxyLoss(amount, updating_health = TRUE, forced = FALSE, required_biotype = ALL, required_respiration_type = ALL)
	if(!can_adjust_oxy_loss(amount, forced, required_biotype, required_respiration_type))
		return 0
	. = oxyloss
	oxyloss = clamp((oxyloss + (amount * CONFIG_GET(number/damage_multiplier))), 0, maxHealth * 2)
	. -= oxyloss
	if(!.) // no change, no need to update
		return FALSE
	if(updating_health)
		updatehealth()

/mob/living/proc/setOxyLoss(amount, updating_health = TRUE, forced = FALSE, required_biotype = ALL, required_respiration_type = ALL)
	if(!forced)
		if(HAS_TRAIT(src, TRAIT_GODMODE))
			return FALSE

		var/obj/item/organ/lungs/affected_lungs = get_organ_slot(ORGAN_SLOT_LUNGS)
		if(isnull(affected_lungs))
			if(!(mob_respiration_type & required_respiration_type))
				return FALSE
		else
			if(!(affected_lungs.respiration_type & required_respiration_type))
				return FALSE
	. = oxyloss
	oxyloss = amount
	. -= oxyloss
	if(!.) // no change, no need to update
		return FALSE
	if(updating_health)
		updatehealth()

/mob/living/proc/getToxLoss()
	return toxloss

/mob/living/proc/can_adjust_tox_loss(amount, forced, required_biotype = ALL)
	if(!forced && (HAS_TRAIT(src, TRAIT_GODMODE) || !(mob_biotypes & required_biotype)))
		return FALSE
	if(SEND_SIGNAL(src, COMSIG_LIVING_ADJUST_TOX_DAMAGE, TOX, amount, forced) & COMPONENT_IGNORE_CHANGE)
		return FALSE
	return TRUE

/mob/living/proc/adjustToxLoss(amount, updating_health = TRUE, forced = FALSE, required_biotype = ALL)
	if(!can_adjust_tox_loss(amount, forced, required_biotype))
		return 0

	if(!forced && HAS_TRAIT(src, TRAIT_TOXINLOVER)) //damage becomes healing and healing becomes damage
		amount = -amount
		if(HAS_TRAIT(src, TRAIT_TOXIMMUNE)) //Prevents toxin damage, but not healing
			amount = min(amount, 0)
		if(blood_volume)
			if(amount > 0)
				blood_volume = max(blood_volume - (5 * amount), 0)
			else
				blood_volume = max(blood_volume - amount, 0)

	else if(!forced && HAS_TRAIT(src, TRAIT_TOXIMMUNE)) //Prevents toxin damage, but not healing
		amount = min(amount, 0)

	. = toxloss
	toxloss = clamp((toxloss + (amount * CONFIG_GET(number/damage_multiplier))), 0, maxHealth * 2)
	. -= toxloss

	if(!.) // no change, no need to update
		return FALSE

	if(updating_health)
		updatehealth()


/mob/living/proc/setToxLoss(amount, updating_health = TRUE, forced = FALSE, required_biotype = ALL)
	if(!forced && HAS_TRAIT(src, TRAIT_GODMODE))
		return FALSE
	if(!forced && !(mob_biotypes & required_biotype))
		return FALSE
	. = toxloss
	toxloss = amount
	. -= toxloss
	if(!.) // no change, no need to update
		return FALSE
	if(updating_health)
		updatehealth()

/mob/living/proc/getFireLoss()
	return fireloss

/mob/living/proc/can_adjust_fire_loss(amount, forced, required_bodytype)
	if(!forced && HAS_TRAIT(src, TRAIT_GODMODE))
		return FALSE
	if(SEND_SIGNAL(src, COMSIG_LIVING_ADJUST_BURN_DAMAGE, BURN, amount, forced) & COMPONENT_IGNORE_CHANGE)
		return FALSE
	return TRUE

/mob/living/proc/adjustFireLoss(amount, updating_health = TRUE, forced = FALSE, required_bodytype = ALL)
	if(!can_adjust_fire_loss(amount, forced, required_bodytype))
		return 0
	. = fireloss
	fireloss = clamp((fireloss + (amount * CONFIG_GET(number/damage_multiplier))), 0, maxHealth * 2)
	. -= fireloss
	if(. == 0) // no change, no need to update
		return
	if(updating_health)
		updatehealth()

/mob/living/proc/setFireLoss(amount, updating_health = TRUE, forced = FALSE, required_bodytype = ALL)
	if(!forced && HAS_TRAIT(src, TRAIT_GODMODE))
		return 0
	. = fireloss
	fireloss = amount
	. -= fireloss
	if(. == 0) // no change, no need to update
		return 0
	if(updating_health)
		updatehealth()


/mob/living/carbon/human/proc/adjustSanityLoss(amount, forced = FALSE)
	if((HAS_TRAIT(src, TRAIT_GODMODE)) || stat == DEAD)
		return FALSE
	if(!forced && amount < 0)
		return FALSE
	sanityloss = clamp(sanityloss + amount, 0, maxSanity)
	if(HAS_TRAIT(src, TRAIT_SANITYIMMUNE))
		sanityloss = 0
	if(sanityhealth > maxSanity)
		sanityhealth = maxSanity
	sanityhealth = clamp((maxSanity - sanityloss), 0, maxSanity)
	if(amount > 0)
		playsound(loc, 'tff_modular/modules/evento_needo/sounds/Tegusounds/sanity_damage.ogg', min(amount, 50), TRUE, -1)
	else if(amount < 0)
		var/turf/T = get_turf(src)
		new /obj/effect/temp_visual/sparkles/sanity_heal(T)
	if(sanity_lost && sanityhealth >= maxSanity)
		QDEL_NULL(ai_controller)
		sanity_lost = FALSE
		grab_ghost(force = TRUE)
		remove_status_effect(/datum/status_effect/panicked_type)
		visible_message(span_boldnotice("[src] comes back to [p_their(TRUE)] senses!"), \
						span_boldnotice("You are back to normal!"))
	else if(!sanity_lost && sanityhealth <= 0)
		sanity_lost = TRUE
		apply_status_effect(/datum/status_effect/panicked)
		SanityLossEffect()
	update_sanity_hud()
	med_hud_set_sanity()
	if(sanityloss > 0)
		received_sanity_loss()
	return amount

/mob/living/carbon/human/proc/SanityLossEffect()
	if((HAS_TRAIT(src, TRAIT_GODMODE)) || HAS_TRAIT(src, TRAIT_SANITYIMMUNE) || stat >= HARD_CRIT)
		return
	var/attribute = get_major_clothing_class()
	if(attribute == CLOTHING_BASIC)
		attribute = pick(CLOTHING_ARMORED, CLOTHING_ENGINEERING, CLOTHING_SCIENCE, CLOTHING_SERVICE)
	QDEL_NULL(ai_controller) // In case there was one already
	SEND_SIGNAL(src, COMSIG_HUMAN_INSANE, attribute)
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_HUMAN_INSANE, src, attribute)
	playsound(loc, 'tff_modular/modules/evento_needo/sounds/Tegusounds/sanity_lost.ogg', 75, TRUE, -1)
	var/warning_text = "[src] shakes for a moment..."
	var/datum/status_effect/panicked_type/status_effect_type
	switch(attribute)
		if(CLOTHING_ENGINEERING)
			ai_controller = /datum/ai_controller/insane/murder
			warning_text = "[src] screams for a moment, murderous intent shining in [p_their()] eyes."
			status_effect_type = /datum/status_effect/panicked_type/murder
		if(CLOTHING_SCIENCE)
			ai_controller = /datum/ai_controller/insane/suicide
			warning_text = "[src] stops moving entirely, [p_they()] lost all hope..."
			status_effect_type = /datum/status_effect/panicked_type/suicide
		if(CLOTHING_SERVICE)
			ai_controller = /datum/ai_controller/insane/wander
			warning_text = "[src] twitches for a moment, [p_their()] eyes looking for a way out."
			status_effect_type = /datum/status_effect/panicked_type/wander
		if(CLOTHING_ARMORED)
			ai_controller = /datum/ai_controller/insane/release
			warning_text = "[src] laughs for a moment, as [p_they()] start[p_s()] approaching nearby containment zones."
			status_effect_type = /datum/status_effect/panicked_type/release
	apply_status_effect(status_effect_type)
	visible_message(span_bolddanger("[warning_text]"), \
					span_userdanger("You've been overwhelmed by what is going on in this place... There's no hope!"))
	var/turf/T = get_turf(src)
	if(mind)
		if(mind.name && mind.active)
			deadchat_broadcast(" has went insane(<i>[initial(status_effect_type.icon)]</i>) at <b>[get_area_name(T)]</b>.", "<b>[mind.name]</b>", follow_target = src, turf_target = T, message_type=DEADCHAT_DEATHRATTLE)
	ghostize(1)
	InitializeAIController()
	SpreadPanic(FALSE)
	return TRUE


/mob/living/carbon/human/proc/SpreadPanic(death = TRUE)
	var/list/result_text_list = list(
		1 = list("Damn it all, someone died", "Comrade down! Comrade down!", "And they're gone forever..."),
		2 = list("[real_name] is really dead...", "I can't let them kill me too.", "Is [real_name] really dead? Is it my turn?"),
		3 = list("My god...", "If even [real_name]'s dead, then...", "I won't last... Even [real_name]'s died now..."),
		4 = list("It's over for me.", "I can't believe [real_name] died... How...", "WE'RE ALL GOING TO DIE!!!!")
		)
	if(!death) // Insane text
		result_text_list = list(
			1 = list("We've got someone panicking!", "Someone's just hit the maximum mental corruption level!", "I don't want to hear those screams of pain anymore..."),
			2 = list("Even the seniors can go insane just the same...", "Please don’t give up on your mind.", "Oh [real_name]... Please come back to your senses..."),
			3 = list("The high rankers go crazy, too...", "Just how long will I endure this madness?", "[real_name]... They hit the maximum mental corruption level... Oh God..."),
			4 = list("Madness rules this place...", "[real_name]... [real_name]... Not you... You were supposed to protect us...", "WE WILL ALL BE DRIVEN MAD AND DIE JUST LIKE THEM!!")
			)
	for(var/mob/living/carbon/human/H in view(7, src))
		if(H == src) // Don't affect yourself
			continue
		if(H.stat == DEAD)
			continue
		if(HAS_TRAIT(H, TRAIT_COMBATFEAR_IMMUNE))
			continue
		if(!faction_check_atom(H)) // If you killed an enemy, you won't go insane
			continue
		var/sanity_result = round(get_clothing_class_level(get_major_clothing_class()) - H.get_clothing_class_level(H.get_major_clothing_class())) + death // Going insane doesn't deal as much damage
		var/sanity_damage = 0
		var/result_text = pick(result_text_list[clamp(sanity_result, 1, 4)])
		switch(sanity_result)
			if(-INFINITY to 0)
				continue
			if(1)
				sanity_damage = H.maxSanity*0.1
				H.apply_status_effect(/datum/status_effect/panicked_lvl_1)
				if(H.sanity_lost)
					continue
				to_chat(H, "<span class='warning'>[result_text]</span>")
			if(2)
				sanity_damage = H.maxSanity*0.3
				H.apply_status_effect(/datum/status_effect/panicked_lvl_2)
				if(H.sanity_lost)
					continue
				to_chat(H, "<span class='danger'>[result_text]</span>")
			if(3)
				sanity_damage = H.maxSanity*0.6
				H.apply_status_effect(/datum/status_effect/panicked_lvl_3)
				if(H.sanity_lost)
					continue
				to_chat(H, "<span class='userdanger'>[result_text]</span>")
			if(4 to INFINITY)
				sanity_damage = H.maxSanity*0.95
				H.apply_status_effect(/datum/status_effect/panicked_lvl_4)
				if(H.sanity_lost)
					continue
				to_chat(H, "<span class='userdanger'><b>[result_text]</b></span>")
		H.adjustSanityLoss(sanity_damage)
	return

/mob/living/carbon/human/proc/received_sanity_loss()
	addtimer(CALLBACK(src, PROC_REF(adjustSanityLoss), -20, TRUE, TRUE), 20 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE)

/mob/living/proc/adjustOrganLoss(slot, amount, maximum, required_organ_flag)
	return

/mob/living/proc/setOrganLoss(slot, amount, maximum, required_organ_flag)
	return

/mob/living/proc/get_organ_loss(slot, required_organ_flag)
	return

/mob/living/proc/getStaminaLoss()
	return staminaloss

/mob/living/proc/can_adjust_stamina_loss(amount, forced, required_biotype = ALL)
	if(!forced && (!(mob_biotypes & required_biotype) || HAS_TRAIT(src, TRAIT_GODMODE)))
		return FALSE
	if(SEND_SIGNAL(src, COMSIG_LIVING_ADJUST_STAMINA_DAMAGE, STAMINA, amount, forced) & COMPONENT_IGNORE_CHANGE)
		return FALSE
	return TRUE

/mob/living/proc/adjustStaminaLoss(amount, updating_stamina = TRUE, forced = FALSE, required_biotype = ALL)
	if(!can_adjust_stamina_loss(amount, forced, required_biotype))
		return 0
	var/old_amount = staminaloss
	staminaloss = clamp((staminaloss + (amount * CONFIG_GET(number/damage_multiplier))), 0, max_stamina)
	var/delta = old_amount - staminaloss
	if(delta <= 0)
		// need to check for stamcrit AFTER canadjust but BEFORE early return here
		received_stamina_damage(staminaloss, -1 * delta)
	if(delta == 0) // no change, no need to update
		return 0
	if(updating_stamina)
		updatehealth()
	return delta

/mob/living/proc/setStaminaLoss(amount, updating_stamina = TRUE, forced = FALSE, required_biotype = ALL)
	if(!forced && HAS_TRAIT(src, TRAIT_GODMODE))
		return 0
	if(!forced && !(mob_biotypes & required_biotype))
		return 0
	var/old_amount = staminaloss
	staminaloss = amount
	var/delta = old_amount - staminaloss
	if(delta <= 0 && amount >= DAMAGE_PRECISION)
		received_stamina_damage(staminaloss, -1 * delta, amount)
	if(delta == 0) // no change, no need to update
		return 0
	if(updating_stamina)
		updatehealth()
	return delta

/// The mob has received stamina damage
///
/// - current_level: The mob's current stamina damage amount (to save unnecessary getStaminaLoss() calls)
/// - amount_actual: The amount of stamina damage received, in actuality
/// For example, if you are taking 50 stamina damage but are at 90, you would actually only receive 30 stamina damage (due to the cap)
/// - amount: The amount of stamina damage received, raw
/mob/living/proc/received_stamina_damage(current_level, amount_actual, amount)
	addtimer(CALLBACK(src, PROC_REF(setStaminaLoss), 0, TRUE, TRUE), stamina_regen_time, TIMER_UNIQUE|TIMER_OVERRIDE)

/**
 * heal ONE external organ, organ gets randomly selected from damaged ones.
 *
 * returns the net change in damage
 */
/mob/living/proc/heal_bodypart_damage(brute = 0, burn = 0, updating_health = TRUE, required_bodytype = NONE, target_zone = null)
	. = (adjustBruteLoss(-abs(brute), updating_health = FALSE) + adjustFireLoss(-abs(burn), updating_health = FALSE))
	if(!.) // no change, no need to update
		return FALSE
	if(updating_health)
		updatehealth()

/// damage ONE external organ, organ gets randomly selected from damaged ones.
/mob/living/proc/take_bodypart_damage(brute = 0, burn = 0, updating_health = TRUE, required_bodytype, check_armor = FALSE, wound_bonus = 0, exposed_wound_bonus = 0, sharpness = NONE)
	. = (adjustBruteLoss(abs(brute), updating_health = FALSE) + adjustFireLoss(abs(burn), updating_health = FALSE))
	if(!.) // no change, no need to update
		return FALSE
	if(updating_health)
		updatehealth()

/// heal MANY bodyparts, in random order. note: stamina arg nonfunctional for carbon mobs
/mob/living/proc/heal_overall_damage(brute = 0, burn = 0, stamina = 0, required_bodytype, updating_health = TRUE, forced = FALSE)
	. = (adjustBruteLoss(-abs(brute), updating_health = FALSE, forced = forced) + \
			adjustFireLoss(-abs(burn), updating_health = FALSE, forced = forced) + \
			adjustStaminaLoss(-abs(stamina), updating_stamina = FALSE, forced = forced))
	if(!.) // no change, no need to update
		return FALSE
	if(updating_health)
		updatehealth()

/// damage MANY bodyparts, in random order. note: stamina arg nonfunctional for carbon mobs
/mob/living/proc/take_overall_damage(brute = 0, burn = 0, stamina = 0, updating_health = TRUE, forced = FALSE, required_bodytype)
	. = (adjustBruteLoss(abs(brute), updating_health = FALSE, forced = forced) + \
			adjustFireLoss(abs(burn), updating_health = FALSE, forced = forced) + \
			adjustStaminaLoss(abs(stamina), updating_stamina = FALSE, forced = forced))
	if(!.) // no change, no need to update
		return FALSE
	if(updating_health)
		updatehealth()

///heal up to amount damage, in a given order
/mob/living/proc/heal_ordered_damage(amount, list/damage_types)
	. = 0 //we'll return the amount of damage healed
	for(var/damagetype in damage_types)
		var/amount_to_heal = min(abs(amount), get_current_damage_of_type(damagetype)) //heal only up to the amount of damage we have
		if(amount_to_heal)
			. += heal_damage_type(amount_to_heal, damagetype)
			amount -= amount_to_heal //remove what we healed from our current amount
		if(!amount)
			break
