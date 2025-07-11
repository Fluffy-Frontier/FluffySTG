#define IS_DEVIL(mob) (mob?.mind?.has_antag_datum (/datum/antagonist/devil))

// Свиток
/obj/item/devil_contract
	name = "Contract"
	icon = 'icons/obj/scrolls.dmi'
	icon_state = "scroll-ancient"
	var/datum/contract_datum/negative/negative = null
	var/datum/contract_datum/positive/positive = null
	// Список позитивных эффектов
	var/static/list/positive_effects = list(
		"Gold Contract" = /datum/contract_datum/positive/gold,
	)
	// Список негативных эффектов
	var/static/list/negative_effects = list(
		"Rage Of Zeus" = /datum/contract_datum/negative/rage_of_zeus,
	)

/obj/item/devil_contract/attack_self(mob/user, modifiers)
	. = ..()
	if(IS_DEVIL(user))
		to_chat(user, span_cult_italic("You must create a masterpiece."))
		create_positive(user)
	else
		if(!negative || !positive)
			to_chat(user, span_cult_italic("It's empty here. Talk to the owner of this scroll."))
			return
		sign_contract(user)

// Выбор эффектов
/obj/item/devil_contract/proc/create_positive(mob/user)
	var/contract_effect_positive = tgui_input_list(user, "Choose A Positive Effect", "Contract", positive_effects)
	if(!contract_effect_positive)
		return
	positive = positive_effects[contract_effect_positive]
	create_negative(user)

/obj/item/devil_contract/proc/create_negative(mob/user)
	var/contract_effect_negative = tgui_input_list(user, "Choose A Negative Effect", "Contract", negative_effects)
	if(!contract_effect_negative)
		return
	negative = negative_effects[contract_effect_negative]

/obj/item/devil_contract/proc/sign_contract(mob/user)
	if(IS_DEVIL(user))
		to_chat(user, span_cult_italic("How."))
		return
	if(tgui_alert(user, "Are you sure you want sign contract?", "Contract", list("Yes", "No")) == "Yes")
		if(QDELETED(src))
			return
		if(!negative || !positive)
			to_chat(user, span_cult_italic("It's empty here. Talk to the owner of this scroll."))
			return
		negative.devil_sign()
		positive.devil_sign()
		to_chat(user, span_cult_italic("The contract has been signed. Enjoy Yourself."))

		negative = null
		positive = null

// Датум контракта
/datum/contract_datum

// Прок для подписывания
/datum/contract_datum/proc/devil_sign(mob/user)
	return

// Тестовые датумы
/datum/contract_datum/positive/gold/devil_sign(mob/user)
	var/obj/item/coin/gold/big_coin = new (user.loc)
	big_coin.value *= 200
	big_coin.name = "Devil's Coin"

/datum/contract_datum/negative/rage_of_zeus/devil_sign(mob/user)
	RegisterSignal(user, COMSIG_LIVING_LIFE, PROC_REF(zeus_rage))

/datum/contract_datum/negative/rage_of_zeus/proc/zeus_rage(mob/user, seconds_per_tick, times_fired)
	if(SPT_PROB(5, seconds_per_tick))
		lightningbolt(user)

// Антаг
/datum/antagonist/devil
	name = "\improper Devil"
	roundend_category = "Devils"
	show_in_roundend = TRUE
	show_in_antagpanel = TRUE
	show_to_ghosts = TRUE
	antagpanel_category = "Devils"
	// how much souls we collected?
	var/souls = 0

