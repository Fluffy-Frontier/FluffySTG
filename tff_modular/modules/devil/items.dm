#define IS_DEVIL(mob) (mob?.mind?.has_antag_datum (/datum/antagonist/devil))

/obj/item/devil
	var/devil_desc = ""
	var/only_for_devil = TRUE

/obj/item/devil/examine(mob/user)
	. = ..()
	if(IS_DEVIL(user))
		. += span_cult(devil_desc)

/obj/item/devil/on_equipped(mob/user, slot, initial)
	. = ..()
	if(!IS_DEVIL(user) && only_for_devil)
		var/mob/living/carbon/human = user
		human.drop_all_held_items()

// Свиток
/obj/item/devil/contract
	name = "Contract"
	icon = 'icons/obj/scrolls.dmi'
	icon_state = "scroll-ancient"
	devil_desc = "You see a message that others can't see: \
		The devil must create the terms of the contract, \
		communicate the terms to the customer, \
		then give the contract to the customer \
		and the customer must sign the contract."

	only_for_devil = TRUE
	var/mob/current_owner = null
	var/datum/contract_datum/negative/negative = null
	var/datum/contract_datum/positive/positive_first = null
	var/datum/contract_datum/positive/positive_second = null
	// Список позитивных эффектов
	var/static/list/positive_effects = list(
		"Greedy" = new /datum/contract_datum/positive/gold,
		"Taro Cards" = new /datum/contract_datum/positive/taro_card,
		"Desert Eagle" = new /datum/contract_datum/positive/weapon,
		"Immortality" = new /datum/contract_datum/positive/immortality,
		"Authority" = new /datum/contract_datum/positive/captain,
		"None" = /datum/contract_datum/nothing,
	)
	// Список негативных эффектов
	var/static/list/negative_effects = list(
		"Rage Of Zeus" = new /datum/contract_datum/negative/rage_of_zeus,
		"Ghoul Curse" = new /datum/contract_datum/negative/ghoulize,
		"Spider Infestation" = new /datum/contract_datum/negative/spider_egg,
		"Wheelchair" = new /datum/contract_datum/negative/disabled,
		"None" = new /datum/contract_datum/nothing,
	)

/obj/item/devil/contract/attack_self(mob/user, modifiers)
	. = ..()
	if(IS_HERETIC(user) || IS_CULTIST(user))
		to_chat(user, span_big(span_cult_italic("No. I have nothing to offer to you.")))
		return
	if(IS_DEVIL(user))
		create_positive(user)
		return
	if(HAS_TRAIT(user, TRAIT_NO_SOUL))
		if(tgui_alert(user, "Are you sure you want to sign contract? You have no soul to offer!", "Contract", list("Yes", "No")) == "Yes")
			var/mob/living/carbon/human = user
			human.death()
		return
	if(tgui_alert(user, "Are you sure you want to sign contract?", "Contract", list("Yes", "No")) == "Yes")
		if(!positive_first || !positive_second || !negative)
			to_chat(user, span_cult_italic("Contract is empty."))
			return
		negative.devil_sign(user)
		positive_first.devil_sign(user)
		positive_second.devil_sign(user)
		ADD_TRAIT(user, TRAIT_NO_SOUL, ACTION_TRAIT)
		to_chat(user, span_cult_italic("The contract has been signed. Enjoy Yourself."))
		collect_souls(current_owner, user.mind)
		negative = null
		positive_first = null
		positive_second = null

/obj/item/devil/contract/proc/collect_souls(mob/living/carbon/soul_merchant, mob/living/sold_soul)
	var/datum/antagonist/devil/soul_collector = soul_merchant.mind.has_antag_datum(/datum/antagonist/devil,FALSE)
	soul_collector.add_soul(soul_collector, sold_soul)

// Выбор эффектов
/obj/item/devil/contract/proc/create_positive(mob/user)
	var/contract_effect_positive_first = tgui_input_list(user, "Choose A First Positive Effect", "Contract", positive_effects)
	if(!contract_effect_positive_first)
		return
	positive_first = positive_effects[contract_effect_positive_first]
	var/contract_effect_positive_second = tgui_input_list(user, "Choose A Second Positive Effect", "Contract", positive_effects)
	if(!contract_effect_positive_second)
		return
	positive_second = positive_effects[contract_effect_positive_second]
	create_negative(user)

/obj/item/devil/contract/proc/create_negative(mob/user)
	var/contract_effect_negative = tgui_input_list(user, "Choose A Negative Effect", "Contract", negative_effects)
	if(!contract_effect_negative)
		return
	negative = negative_effects[contract_effect_negative]

// Оружие дьявола. Очень мощная столовая вилка. Наносит 35 урона, поджигает при ударе. Вмещается в рюкзак. Двуручная.
/obj/item/devil/pitchfork
	icon = 'icons/obj/weapons/spear.dmi'
	icon_state = "pitchfork0"
	base_icon_state = "pitchfork"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	name = "pitchfork"
	desc = "Looks like a pitchfork."
	devil_desc = "This is your weapon. Sets fire to enemies, causes huge damage. Don't lose it or use it to kill customers."
	force = 15
	throwforce = 35
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("attacks", "impales", "pierces")
	attack_verb_simple = list("attack", "impale", "pierce")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	max_integrity = 500
	armor_type = /datum/armor/item_pitchfork/devil
	resistance_flags = FIRE_PROOF

/datum/armor/item_pitchfork/devil
	fire = 100
	acid = 100

/obj/item/devil/pitchfork/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/jousting)
	AddComponent(/datum/component/two_handed, force_unwielded=15, force_wielded=35, icon_wielded="[base_icon_state]1")

/obj/item/devil/pitchfork/update_icon_state()
	icon_state = "[base_icon_state]0"
	return ..()

/obj/item/devil/pitchfork/attack(mob/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	var/mob/living/carbon/human = target_mob
	if(!isliving(target_mob))
		return
	human.ignite_mob()
	human.adjust_fire_stacks(1)
