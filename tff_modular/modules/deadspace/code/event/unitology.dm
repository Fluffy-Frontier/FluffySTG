/datum/antagonist/necromorph/unitology
	name = "\improper Unitologist"
	show_to_ghosts = FALSE
	silent = FALSE
	show_in_antagpanel = TRUE
	antagpanel_category = "Necromorph"
	show_name_in_check_antagonists = TRUE
	suicide_cry = "FOR THE OBELISK"
	hud_icon = 'tff_modular/modules/deadspace/icons/mob/hud/antag_hud.dmi'
	antag_hud_name = "unitologist"

/datum/antagonist/necromorph/unitology/on_mindshield(mob/implanter, mob/living/mob_override)
	. = ..()
	to_chat(implanter, span_hypnophrase("You can feel your mind clearing of thoughts. You feel that the Marker no longer dominates you."))
	implanter.mind?.remove_antag_datum(/datum/antagonist/necromorph)

/datum/antagonist/necromorph/unitology/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/carbon/human/unitologist = owner.current || mob_override
	unitologist.mind?.teach_crafting_recipe(/datum/crafting_recipe/clergy_necklace)
	unitologist.mind?.teach_crafting_recipe(/datum/crafting_recipe/clergy_robe)
	unitologist.mind?.teach_crafting_recipe(/datum/crafting_recipe/clergy_uniform)

/datum/antagonist/necromorph/unitology/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/carbon/human/unitologist = owner.current || mob_override
	unitologist.mind?.forget_crafting_recipe(/datum/crafting_recipe/clergy_necklace)
	unitologist.mind?.forget_crafting_recipe(/datum/crafting_recipe/clergy_robe)
	unitologist.mind?.forget_crafting_recipe(/datum/crafting_recipe/clergy_uniform)

/obj/item/clothing/under/misc/clergy
	name = "Unitology Uniform"
	desc = "Uniform worn by members of the Unitology faith."
	icon = 'tff_modular/modules/deadspace/icons/obj/clothing/jumpsuit.dmi'
	worn_icon = 'tff_modular/modules/deadspace/icons/mob/clothing/jumpsuit.dmi'
	icon_state = "clergy"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/hooded/clergy
	name = "Unitology Robe"
	desc = "Robe worn by members of the Unitology faith."
	icon = 'tff_modular/modules/deadspace/icons/obj/clothing/suit.dmi'
	worn_icon = 'tff_modular/modules/deadspace/icons/mob/clothing/suit.dmi'
	icon_state = "clergy"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	hoodtype = /obj/item/clothing/head/hooded/clergy

/obj/item/clothing/head/hooded/clergy
	name = "Unitology Hood"
	desc = "Hood worn by members of the Unitology faith."
	icon = 'tff_modular/modules/deadspace/icons/obj/clothing/head.dmi'
	worn_icon = 'tff_modular/modules/deadspace/icons/mob/clothing/head.dmi'
	icon_state = "clergy"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	flags_inv = HIDEFACIALHAIR | HIDENECK | HIDEHAIR | HIDEFACE | HIDEEYES | HIDEEARS | HIDEMASK

/obj/item/clothing/neck/necklace/clergy
	name = "Unitology Necklace"
	desc = "Necklace worn by members of the Unitology faith."
	icon = 'tff_modular/modules/deadspace/icons/obj/clothing/neck.dmi'
	worn_icon = 'tff_modular/modules/deadspace/icons/mob/clothing/neck.dmi'
	icon_state = "clergy"

/datum/crafting_recipe/clergy_uniform
	name = "Clergy Uniform"
	result = /obj/item/clothing/under/misc/clergy
	time = 3 SECONDS
	category = CAT_CLOTHING
	reqs = list(
		/obj/item/stack/sheet/cloth = 1,
		/obj/item/clothing/under = 1,
	)
	crafting_flags = CRAFT_SKIP_MATERIALS_PARITY | CRAFT_MUST_BE_LEARNED

/datum/crafting_recipe/clergy_robe
	name = "Clergy Robe"
	result = /obj/item/clothing/suit/hooded/clergy
	time = 5 SECONDS
	category = CAT_CLOTHING
	reqs = list(
		/obj/item/stack/sheet/cloth = 2,
		/obj/item/clothing/suit = 1,
	)
	crafting_flags = CRAFT_SKIP_MATERIALS_PARITY | CRAFT_MUST_BE_LEARNED

/datum/crafting_recipe/clergy_necklace
	name = "Clergy Necklace"
	result = /obj/item/clothing/neck/necklace/clergy
	time = 2 SECONDS
	category = CAT_CLOTHING
	reqs = list(
		/obj/item/stack/sheet/iron = 1,
	)
	crafting_flags = CRAFT_SKIP_MATERIALS_PARITY | CRAFT_MUST_BE_LEARNED
