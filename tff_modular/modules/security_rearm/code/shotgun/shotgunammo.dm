/obj/item/ammo_casing/shotgun/suppressor
	name = "Suppressor shell"
	desc = "A highly experimental shell filled with nanite electrodes that will embed themselves in soft targets. The electrodes are charged from kinetic movement which means moving targets will get punished more."
	icon_state = "lasershell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot/suppressor
	pellets = 8 // 8 * 7 for 56 stamina damage, plus whatever the embedded shells do
	variance = 30
	harmful = FALSE
	fire_sound = 'sound/items/weapons/taser.ogg'
	custom_materials = AMMO_MATS_SHOTGUN_TIDE
	advanced_print_req = TRUE

/obj/projectile/bullet/pellet/shotgun_buckshot/suppressor
	name = "electrode"
	icon = 'modular_nova/modules/shotgunrebalance/icons/projectiles.dmi'
	icon_state = "stardust"
	damage = 2
	stamina = 8
	damage_falloff_tile = -0.2
	stamina_falloff_tile = -0.3
	wound_bonus = 0
	bare_wound_bonus = 0
	stutter = 3 SECONDS
	jitter = 5 SECONDS
	eyeblur = 1 SECONDS
	sharpness = NONE
	range = 8
	embed_type = /datum/embedding/shotgun_buckshot/suppressor

/datum/embedding/shotgun_buckshot/suppressor
	embed_chance = 70
	pain_chance = 25
	fall_chance = 15
	jostle_chance = 80
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.9
	pain_mult = 2
	rip_time = 1 SECONDS

/obj/projectile/bullet/pellet/shotgun_buckshot/suppressor/on_range()
	do_sparks(1, TRUE, src)
	..()
