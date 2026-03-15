/datum/discipline/auspex
	name = "Auspex"
	discipline_explanation = "Auspex is a Discipline that grants vampires supernatural senses, letting them peer far further and see things best left unseen.\n\
		The malkavians especially have a bond with it, being seers at heart."
	icon_state = "auspex"

	// Lists of abilities granted per level
	level_1 = list(/datum/action/cooldown/vampire/auspex)
	level_2 = list(/datum/action/cooldown/vampire/auspex/two)
	level_3 = list(/datum/action/cooldown/vampire/auspex/three)

/datum/discipline/auspex/malkavian
	level_4 = list(/datum/action/cooldown/vampire/astral_projection)

/datum/action/cooldown/vampire/auspex
	name = "Auspex"
	desc = "Sense the vitae of any creature directly, and use your keen senses to widen your perception."
	button_icon_state = "power_auspex"
	power_explanation = "- Level 1: When Activated, you will be able to sense walls and the layout of rooms, and, upon examining a fellow Kindred, be able to tell if they have committed Diablerie. \n\
					- Level 2: When Activated, You will be able to see health of your victims. \n\
					- Level 3: When Activated, you will be able to sense anything in sight, seeing and hearing through walls and barriers as if they were glass."
	vampire_power_flags = BP_AM_TOGGLE | BP_AM_STATIC_COOLDOWN
	vampire_check_flags = BP_CANT_USE_IN_TORPOR | BP_CANT_USE_IN_FRENZY | BP_CANT_USE_WHILE_STAKED | BP_CANT_USE_WHILE_INCAPACITATED | BP_CANT_USE_WHILE_UNCONSCIOUS
	vitaecost = 10
	constant_vitaecost = 1
	cooldown_time = 10 SECONDS
	var/add_medical = FALSE
	var/add_meson = TRUE
	var/add_xray = FALSE
	var/see_diablerie = TRUE
	var/looking = FALSE

/datum/action/cooldown/vampire/auspex/two
	name = "Auspex"
	vitaecost = 40
	constant_vitaecost = 2
	add_meson = TRUE
	see_diablerie = TRUE
	add_medical = TRUE

/datum/action/cooldown/vampire/auspex/three
	name = "Auspex"
	vitaecost = 30
	constant_vitaecost = 3
	add_medical = TRUE
	add_meson = TRUE
	see_diablerie = TRUE
	add_xray = TRUE

/datum/action/cooldown/vampire/auspex/activate_power()
	. = ..()
	if(!looking)
		lookie()

/datum/action/cooldown/vampire/auspex/deactivate_power()
	. = ..()
	if(looking)
		unlooky()

/datum/action/cooldown/vampire/auspex/proc/lookie()
	SIGNAL_HANDLER

	looking = TRUE

	if(add_medical)
		ADD_TRAIT(owner, TRAIT_MEDICAL_HUD, REF(src))

	if(see_diablerie)
		ADD_TRAIT(owner, TRAIT_SEE_DIABLERIE, REF(src))

	if(add_meson)
		ADD_TRAIT(owner, TRAIT_MESON_VISION, REF(src))

	if(add_xray)
		owner.add_traits(list(TRAIT_XRAY_VISION, TRAIT_XRAY_HEARING), REF(src))

	owner.update_sight()

/datum/action/cooldown/vampire/auspex/proc/unlooky()
	SIGNAL_HANDLER

	looking = FALSE
	owner.remove_traits(list(TRAIT_SEE_DIABLERIE, TRAIT_MESON_VISION, TRAIT_XRAY_VISION, TRAIT_XRAY_HEARING, TRAIT_MEDICAL_HUD), REF(src))
	owner.update_sight()
