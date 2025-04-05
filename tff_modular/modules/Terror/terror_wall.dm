/obj/structure/spider/stickyweb/sealed/tough
	name = "hardened web"
	desc = "Webbing hardened through a chemical process into a durable barrier."
	icon = 'icons/obj/smooth_structures/webwall_dark.dmi'
	base_icon_state = "webwall_dark"
	icon_state = "webwall_dark-0"
	smoothing_groups = SMOOTH_GROUP_SPIDER_WEB_WALL_TOUGH
	canSmoothWith = SMOOTH_GROUP_SPIDER_WEB_WALL_TOUGH
	opacity = TRUE
	max_integrity = 250
	layer = ABOVE_MOB_LAYER
	resistance_flags = FIRE_PROOF | FREEZE_PROOF

/obj/structure/spider/stickyweb/sealed/tough/run_atom_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	switch(damage_type)
		if(BURN)
			damage_amount *= 1.0
		if(BRUTE)
			damage_amount *= 0.25
	return ..()
