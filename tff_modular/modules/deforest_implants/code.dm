//Cyberpunk implants can be bought only from restricted consoles
/datum/armament_entry/company_import/deforest/cyber_implants
	restricted = TRUE

//And emag-cyberdeck only from contraband. Still easy to get.
/datum/armament_entry/company_import/deforest/cyber_implants/hackerman
	contraband = TRUE

//No free emag from RnD.
/datum/design/cyberimp_hackerman
	category = list(
		RND_CATEGORY_SYNDICATE
	)
