/obj/item/energy_spear
	name = "\improper energy spear"
	desc = "A spear made of pure energy, incredibly light to the touch."
	icon = 'tff_modular/modules/modsuits/icons/items/mod_items.dmi'
	icon_state = "energy_spear"
	force = 0
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = null
	throwforce = 0
	// Оно невероятно быстрое и сможет догнать кого угодно, в любой среде!
	throw_speed = 20
	demolition_mod = 2
	item_flags = NEEDS_PERMIT | NO_MAT_REDEMPTION

	armour_penetration = 50
	custom_materials = null
	wound_bonus = -50

	inhand_icon_state = "energy_spear"
	lefthand_file = 'tff_modular/modules/modsuits/icons/worn_icons/melee_lefthand.dmi'
	righthand_file = 'tff_modular/modules/modsuits/icons/worn_icons/melee_righthand.dmi'

	// Тип урона при попадании
	var/damage_type = STAMINA
	// Количество урона по стамине после удара
	var/damage = 60
	// Будет ли цель сбита с ног при попадании
	var/knockdown = FALSE


/obj/item/energy_spear/proc/hit_effect(mob/living/target)
	target.apply_damage(damage, damage_type, forced = TRUE)

	if(iscarbon(target) && knockdown)
		var/mob/living/carbon/hit_carbon = target
		hit_carbon.Knockdown(5 * (damage / 10), ignore_canstun = TRUE)
	playsound(get_turf(src), 'tff_modular/modules/modsuits/sounds/energy_spear_throw.ogg', 40)
	qdel(src)

/obj/item/energy_spear/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!istype(hit_atom, /mob/living))
		qdel(src)
		return
	hit_effect(hit_atom)


/obj/item/energy_spear/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	hit_effect(target_mob)

/obj/item/energy_spear/hardlight
	name = "\improper Hardlight energy spear"
	damage = 30
	damage_type = BRUTE
	knockdown = TRUE

/obj/item/melee/mod_blade
	name = "\improper MOD blade"
	desc = "A sharp, stylish and massive MOD blade built into the hand."
	icon = 'tff_modular/modules/modsuits/icons/items/mod_items.dmi'
	icon_state = "mod_blade"
	force = 25
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = null
	throwforce = 0
	throw_speed = 0
	demolition_mod = 3
	armour_penetration = 30
	custom_materials = null
	wound_bonus = 10

	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	inhand_icon_state = "mod_blade"
	lefthand_file = 'tff_modular/modules/modsuits/icons/worn_icons/melee_lefthand.dmi'
	righthand_file = 'tff_modular/modules/modsuits/icons/worn_icons/melee_righthand.dmi'

	var/slash_color = COLOR_BLUE

	// Урон от альтернативной атаки.
	var/alt_attack_damage = 20
	// Время перезарядки альтерантивной атаки.
	var/alt_attack_cooldown = 10 SECONDS
	// Бронепробитие альтерантивной атаки
	var/alt_armour_penetration = 50

	COOLDOWN_DECLARE(aoe_attack_cooldown)
	// Цена по энергии для второстепенной атаки.
	var/alt_attack_power_cost = 50
	//Мод костюм к которому привязан клинок.
	var/obj/item/mod/control/mod

/obj/item/melee/mod_blade/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, \
	speed = 6 SECONDS, \
	effectiveness = 60, \
	)

/obj/item/melee/mod_blade/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	INVOKE_ASYNC(src, PROC_REF(do_alt_attack), user, get_turf(interacting_with))
	return TRUE

/obj/item/melee/mod_blade/proc/do_alt_attack(mob/living/user, turf/target_turf)
	if(!user || !target_turf)
		return
	if(user.stat >= DEAD)
		return
	if(user.incapacitated)
		return
	if(isclosedturf(target_turf))
		return

	if(!COOLDOWN_FINISHED(src, aoe_attack_cooldown))
		user.balloon_alert(user, "Wait [DisplayTimeText(COOLDOWN_TIMELEFT(src, aoe_attack_cooldown))]")
		return
	if(mod && !mod.subtract_charge(alt_attack_power_cost)) // Проверяем наличие мода и вычитаем энергию, если не хватает - выходим.
		user.balloon_alert(user, "Not enough power!")
		return

	user.do_attack_animation(target_turf)
	new /obj/effect/temp_visual/slash(target_turf, target_turf, world.icon_size / 2, world.icon_size / 2, slash_color)
	playsound(target_turf, 'tff_modular/modules/modsuits/sounds/armblade_aoe_attack.ogg', 40)

	for(var/atom/target in target_turf.contents)
		if(isliving(target))
			var/mob/living/living_target = target
			living_target.apply_damage(alt_attack_damage, BRUTE, user.zone_selected, wound_bonus = wound_bonus, sharpness = sharpness, attacking_item = src)
			log_combat(user, living_target, "slashed (AOE)", src)
		else if(target.uses_integrity)
			target.take_damage(alt_attack_damage * 3, BRUTE, MELEE, TRUE, src, alt_armour_penetration)

	user.changeNext_move(CLICK_CD_MELEE)
	COOLDOWN_START(src, aoe_attack_cooldown, alt_attack_cooldown)


/obj/item/melee/mod_blade/armblade
	name = "\improper MOD armblade"
	wound_bonus = 40
	force = 40
	slash_color = COLOR_SYNDIE_RED
	icon_state = "mod_armblade"
	inhand_icon_state = "mod_armblade"
	alt_attack_damage = 35
	alt_attack_cooldown = 7 SECONDS



/obj/item/shield/brace
	name = "MOD Braceable shield"
	desc = "A sturdy shield that can be braced for enhanced stability, \
			slowing you down but allowing you to push forward and resist knockback from the front."
	armor_type = /datum/armor/item_shield_brace
	slot_flags = NONE
	icon_state = "mod_shield"
	worn_icon_state = "mod_shield"
	uses_integrity = FALSE

	icon = 'tff_modular/modules/modsuits/icons/items/mod_items.dmi'
	lefthand_file = 'tff_modular/modules/modsuits/icons/worn_icons/melee_lefthand.dmi'
	righthand_file = 'tff_modular/modules/modsuits/icons/worn_icons/melee_righthand.dmi'

	// Трейты что получит юзер, подняв щит
	var/brace_traits = list(TRAIT_NORUNNING, TRAIT_FORCED_STANDING, TRAIT_STRENGTH, TRAIT_PUSHIMMUNE, TRAIT_PULL_BLOCKED)

	// Поднят ли щит
	var/braced = FALSE
	// Направление взгляда щита
	var/braced_dir = null
	// Расстояние на которое будет отбрасывать толчек щитом
	var/push_distance = 2
	// Скорость с которой будет отлетать тот, кого оттолкнули
	var/push_speed = 2
	// Колдаун толчка с помощью щита
	var/brace_push_cooldown = 3 SECONDS
	var/brace_push_power_cost = POWER_CELL_USE_INSANE * 4

	COOLDOWN_DECLARE(push_cooldown)

	// МОД костюм к которму относится этот щит
	var/obj/item/mod/control/mod = null

	var/max_shield_health = 150
	// Здоровье этого щита
	VAR_PRIVATE/shield_health = 150

/datum/armor/item_shield_brace
	melee = 80
	bullet = 80
	laser = 80
	bomb = 40
	fire = 80
	acid = 80



/obj/item/shield/brace/examine(mob/user)
	. = ..()
	if(shield_health <= 0)
		. += span_warning("\n It broken!")
	if(shield_health < max_shield_health)
		. += span_notice("\n It can be repaired with plastic!")

/obj/item/shield/brace/update_icon_state()
	. = ..()
	if(braced)
		icon_state = "mod_shield_braced"
	if(shield_health <= 0)
		icon_state = "mod_shield_broken"
	else
		icon_state = "mod_shield"
	worn_icon_state = icon_state

/obj/item/shield/brace/attack_self(mob/user)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(toggle_brace), user)


/obj/item/shield/brace/attacked_by(obj/item/attacking_item, mob/living/user, list/modifiers, list/attack_modifiers)
	if(istype(attacking_item, /obj/item/stack/sheet/plastic))
		var/obj/item/stack/sheet/plastic/plasic = attacking_item
		var/how_many = 1
		var/healthpercent = round((shield_health/max_shield_health) * 100, 1)
		switch(healthpercent)
			if(50 to 99)
				how_many = 2
			if(25 to 50)
				how_many = 4
			if(0 to 25)
				how_many = 5
		if(!plasic.use(how_many))
			balloon_alert(user, "Not enough material!")
			return COMPONENT_CANCEL_ATTACK_CHAIN
		if(do_after(user, 5 SECONDS))
			balloon_alert(user, "Fixed!")
			update_shield_health(max_shield_health)
			return COMPONENT_CANCEL_ATTACK_CHAIN
	return ..()


/obj/item/shield/brace/proc/toggle_brace(mob/living/user)
	if(shield_health <= 0)
		user.balloon_alert(user, "Shield broken!")
		return

	if(!do_after(user, braced ? 1 SECONDS : 4 SECONDS, src))
		user.balloon_alert(user, "Interupted!")
		return
	if(braced)
		unbrace(user)
	else
		brace(user)


/obj/item/shield/brace/proc/brace(mob/living/user)
	if(braced)
		return
	if(!user.is_holding(src))
		to_chat(user, span_warning("You need to be holding [src] to brace it!"))
		return
	braced = TRUE
	braced_dir = user.dir
	user.add_traits(brace_traits, REF(src))
	block_chance += 20
	user.move_intent = MOVE_INTENT_WALK
	user.update_move_intent_slowdown()
	user.move_resist = 3000
	slowdown += 2

	RegisterSignal(user, COMSIG_ATOM_PRE_DIR_CHANGE, PROC_REF(prevent_turn))
	RegisterSignal(user, COMSIG_MOVABLE_BUMP, PROC_REF(brace_push), TRUE)

	balloon_alert(user, "Bracing!")
	user.visible_message(span_warning("[user] braces with [src]!"), span_notice("You brace with [src], facing [dir2text(braced_dir)]. Your movement is slowed, but you can push forward and resist knockback from the front."))
	update_icon_state()

/obj/item/shield/brace/proc/unbrace(mob/living/user)
	if(!braced)
		return

	braced = FALSE
	braced_dir = null

	user.remove_traits(brace_traits, REF(src))
	UnregisterSignal(user, list(COMSIG_ATOM_PRE_DIR_CHANGE, COMSIG_MOVABLE_BUMP))
	block_chance = initial(block_chance)
	slowdown = initial(slowdown)
	user.move_intent = MOVE_INTENT_RUN
	user.update_move_intent_slowdown()
	user.move_resist = initial(user.move_resist)

	balloon_alert(user, "Relaxing!")
	user.visible_message(span_notice("[user] relaxes [src]."), span_notice("You relax [src], regaining normal movement."))
	update_icon_state()

/obj/item/shield/brace/proc/prevent_turn(mob/user, old_dir, new_dir)
	if(braced && new_dir != braced_dir)
		return COMPONENT_ATOM_BLOCK_DIR_CHANGE

/obj/item/shield/brace/attack_secondary(mob/living/victim, mob/living/user, list/modifiers, list/attack_modifiers)
	INVOKE_ASYNC(src, PROC_REF(brace_push), user, victim)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/shield/brace/proc/brace_push(datum/source, atom/bumped)
	if(!braced)
		return
	var/mob/living/user = source
	var/dir_to_bumped = get_dir(user, bumped)
	if(dir_to_bumped != braced_dir)
		return
	if(!bumped.density)
		return
	if(!COOLDOWN_FINISHED(src, push_cooldown))
		return
	if(mod && !mod.subtract_charge(brace_push_power_cost)) // Проверяем наличие мода и вычитаем энергию, если не хватает - выходим.
		user.balloon_alert(user, "Not enough power!")
		return
	user.do_attack_animation(bumped)
	if(isliving(bumped))
		var/mob/living/target = bumped
		target.throw_at(get_step(target, braced_dir), push_distance, push_speed, user)
		log_combat(user, target, "pushed with braced shield")
		playsound(target, shield_bash_sound, 50, TRUE)
		user.visible_message(span_warning("[user] rams into [target] with [src]!"))
	else if(bumped.uses_integrity)
		bumped.take_damage(force * 2, BRUTE, MELEE)
	COOLDOWN_START(src, push_cooldown, brace_push_cooldown)
	return COMPONENT_NO_AFTERATTACK


/obj/item/shield/brace/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text, final_block_chance, damage, attack_type, damage_type)
	var/effective_block_chance = final_block_chance
	if(shield_health <= 0)
		return FALSE

	if(mod && !mod.subtract_charge(brace_push_power_cost))
		owner.balloon_alert(owner, "Not enough power!")
		effective_block_chance -= 200
	if(!is_front_attack(owner, hitby))
		effective_block_chance -= 200
	if(attack_type == THROWN_PROJECTILE_ATTACK)
		effective_block_chance += braced ? 50 : 30
	if(attack_type == LEAP_ATTACK)
		effective_block_chance += braced ? 150 : 80
	if(attack_type == OVERWHELMING_ATTACK)
		effective_block_chance -= braced ? 0 : 20
	final_block_chance = clamp(effective_block_chance, 0, 100)
	. = ..()
	if(.)
		on_shield_block(owner, hitby, attack_text, damage, attack_type, damage_type)


/obj/item/shield/brace/on_shield_block(mob/living/carbon/human/owner, atom/movable/hitby, attack_text, damage, attack_type, damage_type)
	if(!breakable_by_damage || (damage_type != BRUTE && damage_type != BURN))
		return TRUE

	var/penetration = 0
	var/armor_flag = MELEE
	if(isprojectile(hitby))
		var/obj/projectile/bang_bang = hitby
		armor_flag = bang_bang.armor_flag
		penetration = bang_bang.armour_penetration
	else if(isitem(hitby))
		var/obj/item/weapon = hitby
		penetration = weapon.armour_penetration
	else if(isanimal(hitby))
		var/mob/living/simple_animal/critter = hitby
		penetration = critter.armour_penetration
	else if(isbasicmob(hitby))
		var/mob/living/basic/critter = hitby
		penetration = critter.armour_penetration
	take_damage(damage, damage_type, armor_flag, armour_penetration = penetration)


/obj/item/shield/brace/proc/is_front_attack(mob/living/owner, atom/movable/hitby)
	var/turf/owner_turf = get_turf(owner)
	var/turf/attacker_turf = get_turf(hitby)
	if(get_dist(owner_turf, attacker_turf) > 3)
		return FALSE
	var/static/list/front_angles = list(0, -45, 45)
	for(var/angle in front_angles)
		var/turf/check_turf = get_step(owner_turf, turn(owner.dir, angle))
		if(attacker_turf == check_turf)
			return TRUE
	return FALSE


/obj/item/shield/brace/proc/update_shield_health(new_health)
	shield_health = min(new_health, max_shield_health)

// Прок для нанесения урона по щиту!
/obj/item/shield/brace/proc/damage_shield(damage_amount)
	shield_health = min(shield_health - damage_amount, 0)
	if(shield_health <= 0)
		atom_deconstruct(FALSE)

/obj/item/shield/brace/atom_deconstruct(disassembled)
	if(braced)
		unbrace(mod.wearer)
	if(isliving(loc))
		loc.balloon_alert(loc, "shield broken!")
	update_icon_state()

/obj/item/shield/brace/dropped(mob/user)
	. = ..()
	if(braced)
		unbrace(user)


/obj/projectile/beam/laser/modlaser
	name = "laser beam"
	icon_state = "heavylaser"
	light_color = COLOR_DARKER_BROWN
	damage = 25
	wound_bonus = -50
	armour_penetration = 0

/obj/projectile/beam/laser/modlaser_alt
	name = "concentrated laser beam"
	icon_state = "laser_musket"
	light_color = COLOR_PURPLE
	damage = 35
	wound_bonus = 25
	armour_penetration = 30

/obj/item/ammo_casing/energy/lasergun/modgun
	projectile_type = /obj/projectile/beam/laser/modlaser
	e_cost = LASER_SHOTS(20, STANDARD_CELL_CHARGE)
	select_name = "focused laser"
	fire_sound = 'sound/items/weapons/laser2.ogg'

/obj/item/ammo_casing/energy/lasergun/modgun_alt
	projectile_type = /obj/projectile/beam/laser/modlaser_alt
	e_cost = LASER_SHOTS(6, STANDARD_CELL_CHARGE)
	select_name = "concentrated laser"
	fire_sound = 'sound/items/weapons/laser2.ogg'

/obj/item/gun/energy/laser/mounted/modsuit
	name = "MOD laser canon module"
	desc = "A small but powerful laser mounted on the user's arm. The lens can be defocused for an alternate firing mode."
	icon = 'tff_modular/modules/modsuits/icons/mod_icons/mod_modules.dmi'
	icon_state = "mod_laser"
	inhand_icon_state = "armcannondisable0"
	worn_icon_state = "gun"
	shaded_charge = FALSE
	automatic_charge_overlays =  FALSE
	ammo_type = list(
		/obj/item/ammo_casing/energy/lasergun/modgun,
		/obj/item/ammo_casing/energy/lasergun/modgun_alt,
	)
	// Стоимость каждого выстрела не в зависимости от того, готов ли стрелять лазер
	var/shot_cost = POWER_CELL_USE_INSANE
	// МОД костюм к которму привязан этот лазер
	var/obj/item/mod/control/mod = null

	can_select = TRUE
	selfcharge = FALSE

/obj/item/gun/energy/laser/mounted/modsuit/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/gun/energy/laser/mounted/modsuit/try_fire_gun(atom/target, mob/living/user, params)
	if(!mod)
		balloon_alert(user, "No mod suit connected!")
		return
	if(!mod.subtract_charge(shot_cost))
		balloon_alert(user, "No power!")
		return
	return ..()

/obj/item/gun/energy/laser/mounted/modsuit/ranged_interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(ammo_type.len > 1 && can_select)
		select_fire(user)

/obj/item/gun/energy/laser/mounted/modsuit/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(ammo_type.len > 1 && can_select)
		select_fire(user)

/obj/item/gun/energy/laser/mounted/modsuit/attack_self(mob/living/user)
	if(ammo_type.len > 1 && can_select)
		select_fire(user)

/obj/item/gun/energy/laser/mounted/modsuit/process(seconds_per_tick)
	if(!mod)
		return
	if(cell && cell.percent() >= 100)
		return
	if(mod.subtract_charge(shot_cost))
		cell.give(shot_cost * seconds_per_tick)
		if(!chambered)
			recharge_newshot(TRUE)
		update_appearance()
		SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
