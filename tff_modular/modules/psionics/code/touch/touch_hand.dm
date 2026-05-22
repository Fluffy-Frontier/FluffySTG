
/obj/item/melee/touch_attack/psionic
	name = "Sparks"
	desc = "Concentrated psionic energy in a hand."
	icon = 'tff_modular/modules/psionics/icons/touch_spell.dmi'
	inhand_icon_state = "greyscale"
	color = null

/obj/item/melee/touch_attack/psionic/mending
	name = "Mending"
	icon_state = "mend_wounds"

/obj/item/melee/touch_attack/psionic/assay
	name = "Assay"
	icon_state = "track"

/obj/item/melee/touch_attack/psionic/chain_lighting
	name = "Electrocute"
	icon_state = "chain_lighting"

/obj/item/melee/touch_attack/psionic/read_mind
	name = "Electrocute"
	icon_state = "apportation"

/obj/item/melee/touch_attack/psionic/rend
	name = "Rend"
	icon_state = "energy_siphon_drain"
	force = 40

/obj/item/melee/touch_attack/psionic/rend/attack_self(mob/user, modifiers)
	. = ..()
	var/datum/action/cooldown/spell/touch/psionic/rend/hand_spell = spell_which_made_us?.resolve()
	if(hand_spell.structure_mode)
		hand_spell.structure_mode = FALSE
	else if(!hand_spell.structure_mode)
		hand_spell.structure_mode = TRUE
	to_chat(user, span_horizonblue("structure mode turned on!"))

/obj/item/melee/touch_attack/psionic/rend/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	var/datum/action/cooldown/spell/touch/psionic/rend/hand_spell = spell_which_made_us?.resolve()
	if(hand_spell.structure_mode)
		return FALSE
