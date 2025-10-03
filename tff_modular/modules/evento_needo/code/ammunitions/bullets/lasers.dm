/obj/projectile/beam/hitscan/disabler
	name = "disabler beam"
	icon = 'tff_modular/modules/evento_needo/icons/projectiles.dmi'
	icon_state = "omnilaser"
	damage = 20
	armour_penetration = -20
	damage_type = STAMINA
	hitsound = 'sound/items/weapons/tap.ogg'
	eyeblur = 0
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	tracer_type = /obj/effect/projectile/tracer/disabler
	muzzle_type = /obj/effect/projectile/muzzle/disabler
	impact_type = /obj/effect/projectile/impact/disabler

	light_color = LIGHT_COLOR_BLUE

	hitscan_light_intensity = 2
	hitscan_light_range = 0.75
	hitscan_light_color_override = COLOR_CYAN
	muzzle_flash_intensity = 4
	muzzle_flash_range = 2
	muzzle_flash_color_override = COLOR_CYAN
	impact_light_intensity = 6
	impact_light_range = 2.5
	impact_light_color_override = COLOR_CYAN

/obj/projectile/beam/hitscan/disabler/heavy
	damage = 35
	armour_penetration = -10

/obj/projectile/beam/laser/sharplite
	speed = 1.1

/obj/projectile/beam/laser/light
	damage = 15

/obj/projectile/beam/laser/light/sharplite
	speed = 1.1

/obj/projectile/beam/laser/eoehoma
	icon = 'tff_modular/modules/evento_needo/icons/projectiles.dmi'
	icon_state = "heavylaser"
	damage = 25
	armour_penetration = 0
	speed = 1

/obj/projectile/beam/laser/eoehoma/heavy
	icon_state = "heavylaser"
	damage = 30
	stamina = 40
	knockdown = 50
	armour_penetration = 20
	speed = 1.1

/obj/projectile/beam/laser/eoehoma/heavy/on_hit(atom/target, blocked = FALSE, pierce_hit)
	..()
	explosion(get_turf(loc),0,0,0,flame_range = 3)
	return BULLET_ACT_HIT

/obj/projectile/beam/laser/assault
	icon = 'tff_modular/modules/evento_needo/icons/projectiles.dmi'
	icon_state = "heavylaser"
	damage = 25
	armour_penetration = 20

/obj/projectile/beam/laser/assault/sharplite
	icon_state = "heavylaser"
	damage = 25
	armour_penetration = 20

/obj/projectile/beam/laser/heavylaser/assault
	armour_penetration = 20

/obj/projectile/beam/laser/h

/obj/projectile/beam/laser/on_hit(atom/target, blocked = FALSE, pierce_hit)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.ignite_mob()
	else if(isturf(target))
		impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser/wall

/obj/projectile/beam/weak/sharplite
	damage = 16
	speed = 1.1

/obj/projectile/beam/weaker
	damage = 10

/obj/projectile/beam/weak/low_range
	damage = 10
	range = 9

/obj/projectile/beam/laser/weak/negative_ap
	damage = 15
	armour_penetration = -30
	range = 9

/obj/projectile/beam/laser/weak/negative_ap/low_range
	range = 6


/obj/projectile/beam/disabler/weak/negative_ap
	damage = 7
	armour_penetration = -30
	range = 9

/obj/projectile/beam/disabler/weak/negative_ap/sharplite
	armour_penetration = -30
	range = 9
	speed = 1.1

/obj/projectile/beam/disabler/weak/negative_ap/low_range
	range = 6

/obj/projectile/beam/practice/sharplite
	icon = 'tff_modular/modules/evento_needo/icons/projectiles.dmi'
	name = "practice laser"
	damage = 0
	speed = 1.1

/obj/projectile/beam/laser/slug
	name = "laser slug"
	icon = 'tff_modular/modules/evento_needo/icons/projectiles.dmi'
	icon_state = "heavylaser"
	damage = 20
	armour_penetration = 40

/obj/projectile/beam/disabler/sharplite
	speed = 1.1

/obj/projectile/beam/emitter/hitscan/e50
	damage = 30
	armour_penetration = 40



/obj/projectile/energy/trap
	name = "energy snare"
	icon_state = "e_snare"
	hitsound = 'sound/items/weapons/taserhit.ogg'
	range = 4

/obj/projectile/energy/trap/on_hit(atom/target, blocked = FALSE, pierce_hit)
	if(!ismob(target) || blocked >= 100) //Fully blocked by mob or collided with dense object - drop a trap
		new/obj/item/restraints/legcuffs/beartrap/energy(get_turf(loc))
	else if(iscarbon(target))
		var/obj/item/restraints/legcuffs/beartrap/B = new /obj/item/restraints/legcuffs/beartrap/energy(get_turf(target))
		B.trap_stepped_on(src, target)
	. = ..()

/obj/projectile/energy/trap/on_range()
	new /obj/item/restraints/legcuffs/beartrap/energy(loc)
	..()
