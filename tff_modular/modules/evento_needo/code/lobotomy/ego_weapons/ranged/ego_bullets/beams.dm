
/obj/projectile/beam/fairy
	name = "fairy"
	icon_state = "fairy"
	damage = 50
	damage_type = BRUTE
	//hit_stunned_targets = TRUE
	//white_healing = FALSE
	projectile_piercing = PASSMOB
	projectile_phasing = (ALL & (~PASSMOB) & (~PASSCLOSEDTURF))

	light_color = LIGHT_COLOR_YELLOW
	//beam_type = list("fairy", 'icons/effects/beam.dmi')
	hitscan = TRUE
	hitscan_light_intensity = 2
	hitscan_light_range = 1
	hitscan_light_color_override = LIGHT_COLOR_YELLOW
	muzzle_flash_intensity = 3
	muzzle_flash_range = 2
	muzzle_flash_color_override = LIGHT_COLOR_YELLOW
	impact_light_intensity = 4
	impact_light_range = 3
	impact_light_color_override = LIGHT_COLOR_YELLOW

/obj/projectile/beam/nobody
	name = "whip"
	icon_state = "nobody"
	damage = 30
	//hitsound = 'sound/weapons/slash.ogg'
	//hitsound_wall = 'sound/weapons/slash.ogg'
	//damage_type = BRUTE
	//hit_stunned_targets = TRUE
	//white_healing = FALSE
	projectile_piercing = PASSMOB
	projectile_phasing = (ALL & (~PASSMOB) & (~PASSCLOSEDTURF))
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/laser/nobody
	muzzle_type = /obj/effect/projectile/tracer/laser/nobody
	impact_type = /obj/effect/projectile/impact/laser/nobody

/obj/effect/projectile/tracer/laser/nobody
	name = "whip tracer"
	icon_state = "nobody"

/obj/effect/projectile/impact/laser/nobody
	name = "whip impact"
	icon_state = "nobody"

/obj/projectile/beam/oberon
	name = "whip"
	icon_state = "nobody"
	damage = 15
	//hitsound = 'sound/weapons/slash.ogg'
	//hitsound_wall = 'sound/weapons/slash.ogg'
	//damage_type = BRUTE
	//hit_stunned_targets = TRUE
	//white_healing = FALSE
	projectile_piercing = PASSMOB
	projectile_phasing = (ALL & (~PASSMOB) & (~PASSCLOSEDTURF))
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/laser/nobody
	muzzle_type = /obj/effect/projectile/tracer/laser/nobody
	impact_type = /obj/effect/projectile/impact/laser/nobody

/obj/projectile/beam/oberon/on_hit(atom/target, blocked = FALSE, pierce_hit)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.apply_damage(15, BURN, null, M.run_armor_check(null, BURN), spread_damage = TRUE)

/obj/projectile/beam/nobody_friendly
	name = "whip"
	icon_state = "nobody"
	damage = 30
	//hitsound = 'sound/weapons/slash.ogg'
	//hitsound_wall = 'sound/weapons/slash.ogg'
	damage_type = BRUTE
	//hit_stunned_targets = TRUE
	//white_healing = FALSE
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/laser/nobody
	muzzle_type = /obj/effect/projectile/tracer/laser/nobody
	impact_type = /obj/effect/projectile/impact/laser/nobody


/obj/projectile/beam/laser/iff
	damage_type = BURN
	light_color = COLOR_RED
	nodamage = TRUE	//Damage is calculated later
	projectile_piercing = PASSMOB

/obj/projectile/beam/laser/iff/on_hit(atom/target, blocked = FALSE, pierce_hit)
	if(isliving(target))
		var/mob/living/L = target
		if("neutral" in L.faction)
			return
	nodamage = FALSE
	. = ..()
	qdel(src)

/obj/projectile/beam/laser/iff/white
	damage_type = BRAIN
	light_color = COLOR_WHITE
	icon_state = "whitelaser"
	//impact_effect_type = /obj/effect/temp_visual/impact_effect/white_laser

/obj/projectile/beam/laser/iff/black
	damage_type = BRUTE
	light_color = COLOR_PURPLE
	icon_state = "purplelaser"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/purple_laser

/obj/projectile/beam/laser/iff/pale
	damage_type = TOX
	light_color = COLOR_PALE_BLUE_GRAY
	icon_state = "omnilaser"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
