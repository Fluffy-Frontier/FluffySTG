/mob/living/basic/space_dragon
	health = 400
	maxHealth = 400
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 1, STAMINA = 0.5, OXY = 1)

/obj/item/gun/energy/e_gun/nuclear
	fire_delay = 10

/obj/item/gun/energy/laser/captain
	charge_delay = 15

/obj/structure/carp_rift
	max_integrity = 400

/obj/item/gun/ballistic/automatic/c20r
	projectile_damage_multiplier = 0.75

// Это как бы не оружие, но оно тоже ломается из-за перехода на 100 хп
/obj/structure/millstone/mill_it_up(mob/living/carbon/human/user)
	if(!length(contents))
		balloon_alert(user, "nothing to mill")
		return

	if(user.get_stamina_loss() > 50)
		balloon_alert(user, "too tired")
		return

	if(!length(contents) || !in_range(src, user))
		return

	balloon_alert_to_viewers("grinding...")

	flick("millstone_spin", src)
	playsound(src, 'sound/effects/stonedoor_openclose.ogg', 50, TRUE)

	user.adjust_stamina_loss(65) // Prevents spamming it

	var/skill_modifier = user.mind?.get_skill_modifier(/datum/skill/primitive, SKILL_SPEED_MODIFIER)
	if(!do_after(user, 5 SECONDS * skill_modifier, target = src))
		balloon_alert_to_viewers("stopped grinding")
		return

	for(var/target_item in contents)
		seedify(target_item, t_max = 1)

	balloon_alert_to_viewers("finished grinding")
	user.mind?.adjust_experience(/datum/skill/primitive, 5)

/obj/projectile/bullet/incendiary/fire
	damage = 5
	range = 5
	wound_bonus = 15
	fire_stacks = 2

/obj/projectile/bullet/incendiary/fire/backblast/short_range
	range = 1

/obj/projectile/bullet/incendiary/fire
	armor_flag = FIRE

/obj/item/melee/implantarmblade/early
	force = 8

/obj/item/melee/implantarmblade/energy
	force = 15

