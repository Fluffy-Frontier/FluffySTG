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

// Это не оружие, но это буквально станционный синдимод, что не очень то вписывается
/datum/armor/mod_theme_infantry
	melee = 35
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	bio = 100
	fire = 50
	acid = 50
	wound = 10

// Возвращаем генокрадские штуки в игру
/datum/action/changeling/spiders
	name = "Spread Infestation"
	desc = "Our form divides, creating a cluster of eggs which will grow into a deadly arachnid. Costs 45 chemicals."
	helptext = "The spiders are ruthless creatures, and may attack their creators when fully grown. Requires at least 3 DNA absorptions."
	button_icon_state = "spread_infestation"
	category = "utility"
	chemical_cost = 45
	dna_cost = 1
	req_absorbs = 3

// Ensures that you cannot horrifically cheese the game by spawning spiders while in the vents
/datum/action/changeling/spiders/can_be_used_by(mob/living/user)
	if (!isopenturf(user.loc))
		var/turf/user_turf = get_turf(user)
		user_turf.balloon_alert(user, "not enough space!")
		return FALSE
	return ..()

//Makes a spider egg cluster. Allows you enable further general havok by introducing spiders to the station.
/datum/action/changeling/spiders/sting_action(mob/user)
	..()
	new /obj/effect/mob_spawn/ghost_role/spider/bloody(user.loc)
	return TRUE

/datum/action/changeling/sting/transformation
	dna_cost = 2
