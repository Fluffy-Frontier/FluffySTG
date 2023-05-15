/// Custom add_team_hud proc
/datum/antagonist/custom_rev/add_team_hud(mob/target, hudteam)
	QDEL_NULL(team_hud_ref)

	team_hud_ref = WEAKREF(target.add_alt_appearance(
		/datum/atom_hud/alternate_appearance/basic/has_antagonist/custom_rev,
		"antag_team_hud_[REF(src)]",
		hud_image_on(target),
		hudteam,
	))

	// Add HUDs that they couldn't see before
	for (var/datum/atom_hud/alternate_appearance/basic/has_antagonist/custom_rev/antag_hud as anything in GLOB.has_antagonist_huds)
		if (antag_hud.mobShouldSee(owner.current))
			antag_hud.show_to(owner.current)

/// An alternate appearance that will only show if you have the same rev team
/datum/atom_hud/alternate_appearance/basic/has_antagonist/custom_rev
	var/datum/weakref/hudteam

/datum/atom_hud/alternate_appearance/basic/has_antagonist/custom_rev/New(key, image/I, datum/team/custom_rev_team/hudteam_input)
	src.hudteam = WEAKREF(hudteam_input)
	GLOB.has_antagonist_huds += src
	return ..(key, I, NONE)

/datum/atom_hud/alternate_appearance/basic/has_antagonist/custom_rev/Destroy()
	GLOB.has_antagonist_huds -= src
	return ..()

/datum/atom_hud/alternate_appearance/basic/has_antagonist/custom_rev/mobShouldSee(mob/M)
	var/list/antags = !!M.mind?.antag_datums
	for (var/datum/antagonist/antag in antags)
		if(antag.get_team == hudteam.resolve())
		return TRUE
	return FALSE
