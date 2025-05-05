// Класс воина.

// Удар воина. Предназначен для того, чтобы превратить какой-либо предмет в опасное оружие. Имеет 12.5 КД. Увеличивает урон следующего удара либо в 2.5 раза, либо на 25 единиц. Добавляет пробитие брони на 25. Удар также заберет у жертвы 9% крови.
// Увеличение урона происходит по следующей системе - выбирается тот вариант, при котором урон будет ниже.
// Т.е. если мы возьмем предмет с уроном 10, то игра выберет умножение, потому что в таком случае урон будет ниже, чем при добавлении 25.
// Если мы возьмем предмет с уроном 26, то игра выберет прибавление, потому что в таком случае урон будет ниже, чем при умножении на 2.5
// Не работает на оружие, у которого урон уже 30 или более. Сделано чтобы братья не абузили контрабанду триторов.
/datum/action/cooldown/spell/sanguine_strike/bbweaponcharge
	name = "faith strike"
	desc = "Enchants your next weapon strike to deal more damage and refill blood."
	button_icon_state = "exsanguinating_strike"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"

	sound = 'sound/effects/magic/charge.ogg'
	school = SCHOOL_SANGUINE
	cooldown_time = 12.5 SECONDS

	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
	var/original_armour_penetration = 0

/datum/action/cooldown/spell/sanguine_strike/can_cast_spell(feedback)
	var/obj/item/to_enchant = owner.get_active_held_item() || owner.get_inactive_held_item()
	if(!to_enchant)
		if(feedback)
			to_chat(owner, span_warning("You need to hold something to empower it!"))
		return FALSE
	if(!to_enchant.force)
		if(feedback)
			to_chat(owner, span_warning("[to_enchant] is too weak to empower! Find something that'll hurt someone!"))
		return FALSE
	return ..()

/datum/action/cooldown/spell/sanguine_strike/bbweaponcharge/apply_enchantment(obj/item/enchanted)
	original_armour_penetration = enchanted.armour_penetration
	original_force = enchanted.force
	enchanted.add_filter("warrior_strike", 2, list("type" = "outline", "color" = "#030303", "size" = 2))
	enchanted.armour_penetration = (enchanted.armour_penetration + 25)
	enchanted.force = min(enchanted.force * 2.5, enchanted.force + 25)
	// Если итоговый урон больше или равен 55 (т.е. было добавлено 25 урона к 30, базовому урону антагвещей), то навык отменяется.
	if(enchanted.force >= 55)
		end_enchantment(enchanted)
		to_chat(owner, span_notice("This weapon is too strong for your ability!"))
		return FALSE
	enchanted.AddElement(enchanted.armour_penetration)
	enchanted.AddElement(enchanted.force)
	RegisterSignal(enchanted, COMSIG_ITEM_AFTERATTACK, PROC_REF(on_enchanted_afterattack))
	RegisterSignal(enchanted, COMSIG_ITEM_DROPPED, PROC_REF(on_dropped))

/datum/action/cooldown/spell/sanguine_strike/bbweaponcharge/end_enchantment(obj/item/enchanted)
	UnregisterSignal(enchanted, list(COMSIG_ITEM_AFTERATTACK, COMSIG_ITEM_DROPPED))
	StartCooldown()
	enchanted.remove_filter("warrior_strike")
	enchanted.force = original_force
	original_force = 0
	enchanted.armour_penetration = original_armour_penetration

/datum/action/cooldown/spell/sanguine_strike/bbweaponcharge/on_dropped(obj/item/enchanted, mob/dropper)
	SIGNAL_HANDLER
	to_chat(dropper, span_notice("[enchanted] seems to lose its black aura."))
	end_enchantment(enchanted)

// Адреналин. Имеет 120 секунд КД. Вводит стимуляторы и добавляет эффекты станиммуна на 15 секунд.
/datum/action/cooldown/spell/stimpack/bbescape
	name = "adrenaline filling"
	desc = "This ability creates unique type of adrenaline straight in your blood. Gives stun immunity for 15 seconds. Won't work on species with no reagent reactions!"
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "splattercasting"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	cooldown_time = 120 SECONDS
	spell_requirements = NONE
	invocation_type = INVOCATION_NONE

/datum/action/cooldown/spell/stimpack/bbescape/cast(mob/living/cast_on)
	. = ..()
	cast_on.balloon_alert(cast_on, "speeding up")
	cast_on.SetKnockdown(0)
	cast_on.setStaminaLoss(0)
	cast_on.set_resting(FALSE)
	cast_on.reagents.add_reagent(/datum/reagent/medicine/stimulants, -1)
	return TRUE


// Кровавые лезвия. Призывает несколько кровавых лезвий.
/datum/action/cooldown/spell/aoe/magic_missile/bbmissle
	name = "bloody slash"
	desc = "You creates several, slow moving, bloody projectiles at nearby targets."
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "scream_for_me"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	projectile_type = /obj/projectile/magic/aoe/soulslash
	cooldown_time = 60 SECONDS
	spell_requirements = NONE
	max_targets = 6

/obj/projectile/magic/aoe/soulslash
	name = "bloody slash"
	icon_state = "soulslash"
	range = 100
	speed = 0.35
	trigger_range = 0
	can_only_hit_target = TRUE
	paralyze = 1.5 SECONDS
	damage = 0
	hitsound = 'sound/effects/magic/mm_hit.ogg'
	trail = FALSE
