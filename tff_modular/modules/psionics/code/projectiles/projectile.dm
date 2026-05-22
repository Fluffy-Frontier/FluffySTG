// Тут все заклинания, создающие снаряды.
/datum/action/cooldown/spell/pointed/projectile/psionic/air_bullet
	name = "Psionic Air Bullet"
	desc = "Wrap air in a psionic bubble, compress it, then send it flying at your enemies."
	button_icon_state = "tech_repelmissiles"
	cooldown_time = 1 SECONDS
	mana_cost = 10
	cast_range = 9
	active_msg = "You prepare to charge air bullet..."
	deactive_msg = "You relax."
	projectile_type = /obj/projectile/magic/air_bullet
	projectile_amount = INFINITY
	psionic_level = 1
	point_cost = 2
	locked = FALSE

/datum/action/cooldown/spell/pointed/projectile/psionic/air_bullet/ready_projectile(obj/projectile/to_fire, atom/target, mob/user, iteration)
	. = ..()
	to_fire.damage = 10 * cast_power

/datum/action/cooldown/spell/pointed/projectile/psionic/air_bullet/fire_projectile(atom/target)
	. = ..()
	drain_mana()
	playsound(owner, 'tff_modular/modules/psionics/sounds/power_feedback.ogg', 50, TRUE)

/obj/projectile/magic/air_bullet
	icon = 'tff_modular/modules/psionics/icons/projectiles.dmi'
	icon_state = "air_bubble"
	damage = 10
	damage_type = BRUTE

/datum/action/cooldown/spell/pointed/projectile/psionic/lighting
	name = "Spell Cards"
	desc = "Hits living beings in a 4x3 area in front of you with thunders."
	button_icon_state = "spellcard"
	category = "Tier 2"
	click_cd_override = 1
	cooldown_time = 60 SECONDS
	psionic_level = 2
	mana_cost = 30
	point_cost = 3
	cast_range = 40
	projectile_type = /obj/projectile/beam/psi_lightning
	projectile_amount = 1
	projectiles_per_fire = 5
	/// The turn rate of the spell cards in flight. (They track onto locked on targets)
	var/projectile_turnrate = 10
	/// The homing spread of the spell cards in flight.
	var/projectile_pixel_homing_spread = 32
	/// The initial spread of the spell cards when fired.
	var/projectile_initial_spread_amount = 30
	/// The location spread of the spell cards when fired.
	var/projectile_location_spread_amount = 12


/datum/action/cooldown/spell/pointed/projectile/psionic/lighting/ready_projectile(obj/projectile/to_fire, atom/target, mob/user, iteration)
	. = ..()
	var/rand_spr = rand()
	var/total_angle = projectile_initial_spread_amount * 2
	var/adjusted_angle = total_angle - ((projectile_initial_spread_amount / projectiles_per_fire) * 0.5)
	var/one_fire_angle = adjusted_angle / projectiles_per_fire
	var/current_angle = iteration * one_fire_angle * rand_spr - (projectile_initial_spread_amount / 2)

	to_fire.pixel_x = rand(-projectile_location_spread_amount, projectile_location_spread_amount)
	to_fire.pixel_y = rand(-projectile_location_spread_amount, projectile_location_spread_amount)
	to_fire.aim_projectile(target, user, null, current_angle)

/datum/action/cooldown/spell/pointed/projectile/psionic/lighting/cast(atom/cast_on)
	. = ..()
	drain_mana()

/obj/projectile/beam/psi_lightning
	name = "psionic lightning"
	damage = 20
	armour_penetration = 30
	damage_type = BURN
	pass_flags = PASSTABLE | PASSGRILLE | PASSGLASS
	range = 40

	muzzle_type = /obj/effect/projectile/muzzle/solar
	tracer_type = /obj/effect/projectile/muzzle/solar
	impact_type = /obj/effect/projectile/muzzle/solar
