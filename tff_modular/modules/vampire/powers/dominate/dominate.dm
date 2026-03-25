/datum/discipline/dominate
	name = "Dominate"
	discipline_explanation = "Dominate is a Discipline that overwhelms another person's mind with the vampire's will, forcing victims to think or act according to the vampire's decree."
	icon_state = "dominate"

	// Base only has mez, ventrue get command earlier and can upgrade it
	level_1 = list(/datum/action/cooldown/vampire/targeted/mesmerize, /datum/action/cooldown/vampire/targeted/command)
	level_2 = list(/datum/action/cooldown/vampire/targeted/mesmerize/two, /datum/action/cooldown/vampire/targeted/command/two)
	level_3 = list(/datum/action/cooldown/vampire/targeted/mesmerize/three, /datum/action/cooldown/vampire/targeted/command/three)
	level_4 = list(/datum/action/cooldown/vampire/targeted/mesmerize/four, /datum/action/cooldown/vampire/targeted/command/four)
	level_5 = list(/datum/action/cooldown/vampire/targeted/mesmerize/four, /datum/action/cooldown/vampire/targeted/command/five)

/datum/discipline/dominate/ventrue
	level_1 = list(/datum/action/cooldown/vampire/targeted/mesmerize/three, /datum/action/cooldown/vampire/targeted/command/three)
	level_2 = list(/datum/action/cooldown/vampire/targeted/mesmerize/four, /datum/action/cooldown/vampire/targeted/command/four)
	level_3 = list(/datum/action/cooldown/vampire/targeted/mesmerize/four, /datum/action/cooldown/vampire/targeted/command/five)
