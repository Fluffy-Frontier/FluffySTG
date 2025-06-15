// Класс воина.

// Удар воина. Предназначен для того, чтобы превратить какой-либо предмет в опасное оружие. Имеет 12.5 КД. Увеличивает урон следующего удара либо в 2.5 раза, либо на 25 единиц. Добавляет пробитие брони на 25. Удар также заберет у жертвы 9% крови.
// Увеличение урона происходит по следующей системе - выбирается тот вариант, при котором урон будет ниже.
// Т.е. если мы возьмем предмет с уроном 10, то игра выберет умножение, потому что в таком случае урон будет ниже, чем при добавлении 25.
// Если мы возьмем предмет с уроном 26, то игра выберет прибавление, потому что в таком случае урон будет ниже, чем при умножении на 2.5
// Не работает на оружие, у которого урон уже 30 или более. Сделано чтобы братья не абузили контрабанду триторов.
/datum/action/cooldown/spell/hematocrat/weapon_charge
	name = "Powerful Strike"
	desc = "Your next attack with item in hand will damage more and refill your blood."
	button_icon_state = "exsanguinating_strike"

	sound = 'sound/items/unsheath.ogg'
	school = SCHOOL_SANGUINE
	cooldown_time = 12.5 SECONDS

	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
	var/original_armour_penetration = 0
	var/original_force = 0
	var/active = FALSE

/datum/action/cooldown/spell/hematocrat/weapon_charge/is_valid_target(atom/cast_on)
	return isliving(cast_on)

/datum/action/cooldown/spell/hematocrat/weapon_charge/can_cast_spell(feedback)
	var/obj/item/to_enchant = owner.get_active_held_item() || owner.get_inactive_held_item()
	if(!to_enchant)
		if(feedback)
			to_chat(owner, span_warning("You need to hold something to empower it!"))
		return FALSE
	if(!to_enchant.force)
		if(feedback)
			to_chat(owner, span_warning("[to_enchant] is too weak to empower! Find something that'll hurt someone!"))
		return FALSE
	if(active)
		if(feedback)
			to_chat(owner, span_warning("[to_enchant] is seems to be enchanted!"))
		return FALSE
	return ..()


/datum/action/cooldown/spell/hematocrat/weapon_charge/cast(mob/living/cast_on)
	. = ..()
	var/obj/item/to_enchant = cast_on.get_active_held_item() || cast_on.get_inactive_held_item()
	if(!to_enchant)
		return
	to_chat(cast_on, span_notice("[to_enchant] begins to glow red..."))
	apply_enchantment(to_enchant)
	StartCooldown(INFINITY)

/datum/action/cooldown/spell/hematocrat/weapon_charge/proc/on_enchanted_afterattack(obj/item/enchanted, atom/target, mob/user, list/modifiers)
	SIGNAL_HANDLER
	end_enchantment(enchanted)
	if(!isliving(target))
		return
	var/mob/living/living_target = target
	if(living_target.blood_volume < BLOOD_VOLUME_SURVIVE)
		return
	playsound(target, 'sound/effects/wounds/crackandbleed.ogg', 100)
	var/attack_direction = get_dir(user, living_target)
	if(iscarbon(living_target))
		var/mob/living/carbon/carbon_target = living_target
		carbon_target.spray_blood(attack_direction, 3)
	living_target.blood_volume -= 75
	if(!isliving(user))
		return
	var/mob/living/living_user = user
	//if we blind-added blood volume to the caster, non-vampire wizards could easily kill themselves by using the spell enough
	if(living_user.blood_volume < BLOOD_VOLUME_MAXIMUM)
		living_user.blood_volume += 25

/datum/action/cooldown/spell/hematocrat/weapon_charge/proc/apply_enchantment(obj/item/enchanted)
	original_armour_penetration = enchanted.armour_penetration
	original_force = enchanted.force
	enchanted.add_filter("warrior_strike", 2, list("type" = "outline", "color" = "#030303", "size" = 2))
	enchanted.armour_penetration = (enchanted.armour_penetration + 25)
	enchanted.force = min(enchanted.force * 2.5, enchanted.force + 25)
	// Если итоговый урон больше или равен 55 (т.е. было добавлено 25 урона к 30, базовому урону антагвещей), то навык отменяется.
	if(enchanted.force >= 55)
		end_enchantment(enchanted)
		to_chat(owner, span_notice("This weapon is too strong for you!"))
		return FALSE
	enchanted.AddElement(enchanted.armour_penetration)
	enchanted.AddElement(enchanted.force)
	RegisterSignal(enchanted, COMSIG_ITEM_AFTERATTACK, PROC_REF(on_enchanted_afterattack))
	RegisterSignal(enchanted, COMSIG_ITEM_DROPPED, PROC_REF(on_dropped))

/datum/action/cooldown/spell/hematocrat/weapon_charge/proc/end_enchantment(obj/item/enchanted)
	UnregisterSignal(enchanted, list(COMSIG_ITEM_AFTERATTACK, COMSIG_ITEM_DROPPED))
	StartCooldown()
	enchanted.remove_filter("warrior_strike")
	enchanted.force = original_force
	original_force = 0
	enchanted.armour_penetration = original_armour_penetration

/datum/action/cooldown/spell/hematocrat/weapon_charge/proc/on_dropped(obj/item/enchanted, mob/dropper)
	to_chat(dropper, span_notice("[enchanted] seems to lose its black aura."))
	end_enchantment(enchanted)

// Броня. Дает сопротивление к стамин урону 50% и сопротивление к ранам.
/datum/action/cooldown/hematocrat/armor
	name = "Armor up"
	desc = "This ability makes your skin a little bit harder, protecting you from wounds and energy weapons aimed at stunning \
		It does not provide protection from bullets or harmful lasers!"
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "splattercasting"
	cooldown_time = 5 SECONDS
	var/active = FALSE

/datum/action/cooldown/hematocrat/armor/Remove(mob/removed_from)
	. = ..()
	if(active)
		var/mob/living/carbon/human/living_owner = removed_from
		living_owner.remove_traits(list(TRAIT_HARDLY_WOUNDED, TRAIT_PIERCEIMMUNE))

/datum/action/cooldown/hematocrat/armor/Activate(atom/target)
	. = ..()
	if(active)
		deactivate()
		return FALSE
	var/mob/living/carbon/human/living_owner = owner
	living_owner.balloon_alert(living_owner, "Armor up")
	living_owner.add_traits(list(TRAIT_HARDLY_WOUNDED, TRAIT_PIERCEIMMUNE), ACTION_TRAIT)
	active = TRUE
	return TRUE

/datum/action/cooldown/hematocrat/armor/proc/deactivate()
	if(!active)
		return FALSE
	active = FALSE
	var/mob/living/carbon/living_owner = owner
	living_owner.balloon_alert(living_owner, "armor up")
	living_owner.remove_traits(list(TRAIT_HARDLY_WOUNDED, TRAIT_PIERCEIMMUNE), ACTION_TRAIT)

// АОЕ атака. Активация навыка наносит по 35 урона всем в радиусе 3x3, имеет шанс отрезать конечность или застанить.
/datum/action/cooldown/hematocrat/slash
	name = "The Fury Of The Warrior"
	desc = "Attack everyone in 3x3 radius with a chance of stunning target or dismember its bodyparts"
	button_icon = 'tff_modular/modules/hematocrat/icons/hematocraticons.dmi'
	button_icon_state = "slash_icon"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
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
		if(prob(10))
			var/obj/item/bodypart/cut_bodypart = something_living.get_bodypart(pick(BODY_ZONE_R_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_ARM, BODY_ZONE_L_LEG))
			cut_bodypart?.dismember(BRUTE)
		something_living.apply_damage(35, BRUTE)
	playsound(owner, 'sound/vehicles/mecha/mech_stealth_attack.ogg', 75, FALSE)
	StartCooldown()

// Визуальный эффект от АОЕ атаки.
/obj/effect/temp_visual/hem_attack
	name = "hem attack"
	icon = 'tff_modular/modules/hematocrat/icons/attack_effect.dmi'
	icon_state = "hem_attack"
	duration = 0.5 SECONDS
	pixel_x = -32
	pixel_y = -32

/datum/action/cooldown/spell/pointed/projectile/hematocrat/warrior
	name = "double blood spit"
	projectile_type = /obj/projectile/bloodspit/warrior
	projectile_amount = 2
	projectiles_per_fire = 2

/obj/projectile/bloodspit/warrior
	damage = 24
