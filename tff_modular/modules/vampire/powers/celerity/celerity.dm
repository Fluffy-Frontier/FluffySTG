/datum/discipline/celerity
	name = "Celerity"
	discipline_explanation = "Celerity is a Discipline that grants vampires supernatural quickness and reflexes."
	icon_state = "celerity"

	// Lists of abilities granted per level
	level_1 = list(/datum/action/cooldown/vampire/targeted/haste)
	level_2 = list(/datum/action/cooldown/vampire/targeted/haste/two)
	level_3 = list(/datum/action/cooldown/vampire/targeted/haste/three)
	level_4 = list(/datum/action/cooldown/vampire/targeted/haste/four, /datum/action/cooldown/vampire/exactitude)
	level_4 = list(/datum/action/cooldown/vampire/targeted/haste/five, /datum/action/cooldown/vampire/exactitude)

/datum/discipline/celerity/apply_discipline_quirks(datum/antagonist/vampire/clan_owner)
	. = ..()
	owner.add_traits(clan_owner.vampire_traits, TRAIT_PERFECT_ATTACKER, TRAIT_VAMPIRE)
	owner.next_move_modifier *= 0.9
