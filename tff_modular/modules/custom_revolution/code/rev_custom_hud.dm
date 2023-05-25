/// Custom add_team_hud proc
/datum/antagonist/custom_rev/add_team_hud(mob/target, antag_to_check)
	QDEL_NULL(team_hud_ref)

	team_hud_ref = WEAKREF(target.add_alt_appearance(
		/datum/atom_hud/alternate_appearance/basic/has_antagonist/custom_rev,
		"antag_team_hud_[REF(src)]",
		hud_image_on(target),
		antag_to_check || type,
	))

	var/datum/atom_hud/alternate_appearance/basic/has_antagonist/custom_rev/hud = team_hud_ref.resolve()
	hud.team = get_team()

	// Add HUDs that they couldn't see before
	for (var/datum/atom_hud/alternate_appearance/basic/has_antagonist/antag_hud as anything in GLOB.has_antagonist_huds)
		if (antag_hud.mobShouldSee(owner.current))
			antag_hud.show_to(owner.current)

/// An alternate appearance that will only show if you have the same rev team
/datum/atom_hud/alternate_appearance/basic/has_antagonist/custom_rev
	var/datum/team/custom_rev_team/team

/datum/atom_hud/alternate_appearance/basic/has_antagonist/custom_rev/mobShouldSee(mob/M)
	if(isnull(team))
		return FALSE
	if(isnull(M.mind))
		return FALSE
	if(M.mind in team.members)
		return TRUE
	return FALSE
