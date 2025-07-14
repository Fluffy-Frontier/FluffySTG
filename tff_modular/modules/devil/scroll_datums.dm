// Датумs контрактов
/datum/contract_datum

// Прок для подписывания
/datum/contract_datum/proc/devil_sign(mob/living/carbon/human/user)
	return

// Позитивные
/datum/contract_datum/positive/gold/devil_sign(mob/living/carbon/human/user)
	. = ..()
	to_chat(user, span_cult_bold_italic("Nothing new. Could you have thought of something else?"))
	var/datum/action/cooldown/spell/conjure_item/coins/goldy = new
	goldy.Grant(user)

/datum/contract_datum/positive/immortality/devil_sign(mob/living/carbon/human/user)
	. = ..()
	to_chat(user, span_cult_bold_italic("You're immortal now. But at what cost?"))
	ADD_TRAIT(user, TRAIT_NODEATH, SCROLL_TRAIT)

/datum/contract_datum/positive/weapon/devil_sign(mob/living/carbon/human/user)
	. = ..()
	to_chat(user, span_cult_bold_italic("Well, welcome to Space America."))
	devil_item_give(/obj/item/gun/ballistic/automatic/pistol/deagle/regal/devil, user)
	var/datum/action/cooldown/spell/conjure_item/desert_eagle_ammo/summon_ammo = new
	summon_ammo.Grant(user)

/datum/contract_datum/positive/taro_card/devil_sign(mob/living/carbon/human/user)
	. = ..()
	to_chat(user, span_cult_bold_italic("Enjoy your new friend."))
	devil_item_give(/obj/item/guardian_creator/wizard, user, FALSE)

/datum/contract_datum/positive/captain/devil_sign(mob/living/carbon/human/user)
	. = ..()
	to_chat(user, span_cult_bold_italic("Welcome to abord, captain."))
	equip_captain_clothing(user)
	minor_announce("Son of the Satan [user.real_name] on the desk! Glory to Satan!", "Message from Hell")
	GLOB.manifest.modify(user.real_name, JOB_CAPTAIN, JOB_CAPTAIN)

/datum/contract_datum/positive/captain/proc/equip_captain_clothing(mob/living/carbon/human/signer)
	var/obj/id = signer.get_item_by_slot(ITEM_SLOT_ID)
	QDEL_NULL(id)
	var/obj/headset = signer.get_item_by_slot(ITEM_SLOT_EARS)
	QDEL_NULL(headset)
	var/obj/item/belt = signer.get_item_by_slot(ITEM_SLOT_BELT)
	QDEL_NULL(belt)
	var/obj/pants = signer.get_item_by_slot(ITEM_SLOT_ICLOTHING)
	QDEL_NULL(pants)
	signer.equipOutfit(/datum/outfit/job/wizard_captain/devil)

/datum/outfit/job/wizard_captain/devil
	name = "Captain (Devil Transformation)"
	jobtype = /datum/job/captain
	id = /obj/item/card/id/advanced/gold
	id_trim = /datum/id_trim/job/captain
	uniform = /obj/item/clothing/under/rank/captain/parade
	belt = /obj/item/storage/belt/sabre
	ears = /obj/item/radio/headset/heads/captain/alt
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/captains_formal
	head = /obj/item/clothing/head/hats/caphat/parade
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = /obj/item/clothing/gloves/captain
	shoes = /obj/item/clothing/shoes/laceup
	accessory = /obj/item/clothing/accessory/medal/gold/captain
	backpack_contents = list(
		/obj/item/melee/baton/telescopic = 1,
		/obj/item/station_charter = 1,
		/obj/item/modular_computer/pda/heads/captain = 1,
	)
	box = null

// Негативные
/datum/contract_datum/negative/rage_of_zeus/devil_sign(mob/living/carbon/human/user)
	. = ..()
	to_chat(user, span_cult_bold_italic("It seems you've accidentally angered Zeus. Good luck."))
	RegisterSignal(user, COMSIG_LIVING_LIFE, PROC_REF(zeus_rage))

/datum/contract_datum/negative/rage_of_zeus/proc/zeus_rage(mob/living/carbon/human/user, seconds_per_tick, times_fired)
	if(SPT_PROB(0.1, seconds_per_tick))
		lightningbolt(user) // Наносит 75 урона, поэтому достаточно редко.

/datum/contract_datum/negative/ghoulize/devil_sign(mob/living/carbon/human/user)
	. = ..()
	to_chat(user, span_cult_bold_italic("You're cursed now."))
	user.spawn_gibs()
	user.set_species(/datum/species/ghoul)
	ADD_TRAIT(user, TRAIT_RACE_SELF_ACTUALIZATOR_BLOCKED, SCROLL_TRAIT)

/datum/contract_datum/negative/disabled/devil_sign(mob/living/carbon/human/user)
	. = ..()
	to_chat(user, span_cult_bold_italic("Now you're a certified racer."))
	user.gain_trauma(/datum/brain_trauma/severe/paralysis/paraplegic)
	new /obj/vehicle/ridden/wheelchair(get_turf(user))

/datum/contract_datum/negative/spider_egg/devil_sign(mob/living/carbon/human/user)
	. = ..()
	to_chat(user, span_cult_bold_italic("How does it feel when the creatures you created hate you?"))
	RegisterSignal(user, COMSIG_LIVING_LIFE, PROC_REF(spawn_spiders))

/datum/contract_datum/negative/spider_egg/proc/spawn_spiders(mob/user, seconds_per_tick, times_fired)
	SIGNAL_HANDLER
	if(SPT_PROB(0.5, seconds_per_tick))
		to_chat(user, span_warning("You feel something moving in your throat."))
		new /mob/living/basic/spider/growing/spiderling/guard (user.loc)
		var/mob/living/carbon/human = user
		human.adjustBruteLoss(10, TRUE, FALSE, HEAD)

// Ничего
/datum/contract_datum/nothing/devil_sign(mob/living/carbon/human/user)
	return
