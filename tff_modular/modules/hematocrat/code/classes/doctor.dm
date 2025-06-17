// Класс Доктора. Планируется как дамагер. Пока что недоделан, но играть можно.

// Аура - дамажущая аура с расстоянием 5 тайлов. Наносит урон: 3 токсинам, 2 стамины и 0.2 крови.
/datum/action/cooldown/hematocrat/aura
	name = "The plague aura."
	desc = "We start spreading the harmful cells into the air, harming everyone within 4x4 range!"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "berserk_mode"
	cooldown_time = 1 SECONDS
	var/aura_active = FALSE
	var/aura_range = 4
	var/datum/component/damage_aura/aura_damage_component

/datum/action/cooldown/hematocrat/aura/Activate()

	if(aura_active)
		aura_deactivate()
		return FALSE
	owner.balloon_alert(owner, "damage aura started")
	to_chat(owner, span_danger("We start spreading the harmful cells into the air, harming everyone within range."))
	aura_active = TRUE
	aura_damage_component = owner.AddComponent( \
		/datum/component/damage_aura, \
		range = aura_range, \
		requires_visibility = TRUE, \
		toxin_damage = 3, \
		stamina_damage = 2, \
		blood_damage = 0.2, \
		immune_factions = list(FACTION_HEMATOCRAT), \
	)
	return TRUE

/datum/action/cooldown/hematocrat/aura/proc/aura_deactivate()
	if(!aura_active)
		return
	aura_active = FALSE
	QDEL_NULL(aura_damage_component)
	owner.balloon_alert(owner, "damage aura removed")

// АОЕ атака. Активация навыка наносит по 35 урона всем в радиусе 3x3, имеет шанс отрезать конечность или застанить.
/datum/action/cooldown/hematocrat/slash
	name = "The Fury Of The Doctor"
	desc = "Attack everyone in 3x3 radius with a chance of stunning target or dismember its bodyparts"
	button_icon = 'tff_modular/modules/hematocrat/icons/hematocraticons.dmi'
	button_icon_state = "slash_attack"
	cooldown_time = 160 SECONDS
	melee_cooldown_time = 0 SECONDS
	click_to_activate = FALSE

/datum/action/cooldown/hematocrat/slash/Activate(atom/target)
	new /obj/effect/temp_visual/hem_attack(get_turf(owner))
	for(var/mob/living/something_living in range(1, get_turf(owner)))
		if(something_living.stat >= UNCONSCIOUS)
			continue
		if(something_living == owner)
			continue
		if(HAS_TRAIT(something_living, TRAIT_HEMATOCRAT))
			continue
		if(prob(35))
			something_living.Stun(2 SECONDS)
			something_living.Paralyze(1.5 SECONDS)
		if(prob(15))
			var/obj/item/bodypart/cut_bodypart = something_living.get_bodypart(pick(BODY_ZONE_R_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_ARM, BODY_ZONE_L_LEG))
			cut_bodypart?.dismember(BRUTE)
		something_living.apply_damage(35, BRUTE)
	playsound(owner, 'sound/vehicles/mecha/mech_stealth_attack.ogg', 75, FALSE)
	StartCooldown()

/datum/action/cooldown/hematocrat/plague_secret
	name = "The secret of plague immortality."
	desc = "Gives you immunity to toxins, speeds up the use of medical items, and you can see other people's wounds, you are immune to overdoses. If someone attacks you in close combat, they have a chance to get infected with a virus. But it makes you speechless."
	cooldown_time = 1 SECONDS
	button_icon = 'tff_modular/modules/hematocrat/icons/hematocraticons.dmi'
	button_icon_state = "doctor"
	var/active = FALSE
	var/static/list/plague_immunity = list(
		TRAIT_MUTE,
		TRAIT_TOXINLOVER,
		TRAIT_FASTMED,
		TRAIT_MEDICAL_HUD,
		TRAIT_OVERDOSEIMMUNE,
		TRAIT_VIRUSIMMUNE,
	)

/datum/action/cooldown/hematocrat/plague_secret/Remove(mob/removed_from)
	. = ..()
	if(active)
		removed_from.remove_traits(plague_immunity, ACTION_TRAIT)

/datum/action/cooldown/hematocrat/plague_secret/Activate(atom/target)
	. = ..()
	var/mob/living/carbon/living_owner = owner
	if(active)
		living_owner.remove_traits(plague_immunity, ACTION_TRAIT)
		active = FALSE
		return FALSE
	living_owner.add_traits(plague_immunity, ACTION_TRAIT)
	active = TRUE

// Визуальный эффект от АОЕ атаки.
/obj/effect/temp_visual/hem_attack
	name = "hem attack"
	icon = 'tff_modular/modules/hematocrat/icons/attack_effect.dmi'
	icon_state = "hem_attack"
	duration = 0.5 SECONDS
	pixel_x = -32
	pixel_y = -32
