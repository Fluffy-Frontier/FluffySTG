/obj/item/attachment/gun/energy
	name = "underbarrel e-gun"
	desc = "Pew pew laser beam. You probably shouldnt be seeing this."
	underbarrel_prefix = "laser_"
	icon_state = "energy"
	weapon_type = /obj/item/gun/energy/e_gun
	var/automatic_charge_overlays = TRUE
	allow_hand_interaction = TRUE

/obj/item/attachment/gun/energy/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/stock_parts/power_store/cell))
		attached_gun.attackby(I, user)
		update_appearance()
	else
		return ..()

/obj/item/attachment/gun/energy/hand_attack_interaction(mob/user)
	var/obj/item/gun/energy/e_gun = attached_gun
	if(e_gun.tac_reloads && e_gun.cell)
		e_gun.eject_cell(user)
		return ..()

/obj/item/attachment/gun/energy/on_examine(obj/item/gun/gun, mob/user, list/examine_list)
	var/obj/item/gun/energy/e_gun = attached_gun
	var/obj/item/ammo_casing/energy/shot = e_gun.ammo_type[e_gun.select]
	var/obj/item/stock_parts/power_store/cell/gun_cell = get_cell()
	if(e_gun.ammo_type.len > 1)
		examine_list += span_notice("- You can switch firemodes on the [name] by pressing the <b>unique action</b> key. By default, this is <b>space</b>")
	if(e_gun.cell)
		examine_list += span_notice("- \The [name]'s cell has [gun_cell.percent()]% charge remaining.")
		examine_list += span_notice("- \The [name] has [round(gun_cell.charge/shot.e_cost)] shots remaining on <b>[shot.select_name]</b> mode.")
	else
		. += span_notice("- \The [name] doesn't seem to have a cell!")
	if(!e_gun.internal_magazine)
		examine_list += span_notice("- The cell retainment latch is [e_gun.latch_closed ? span_green("CLOSED") : span_red("OPEN")]. Alt-Click to toggle the latch.")
	return examine_list

/obj/item/attachment/gun/energy/click_alt(mob/user)
	. = ..()
	attached_gun.click_alt(user)

/obj/item/attachment/gun/energy/get_cell()
	return attached_gun.cell

/obj/item/attachment/gun/energy/e_gun
	name = "underbarrel energy gun"
	desc = "A compact underbarrel energy gun. The reduction in size makes it less power effiecent per shot than the standard model."
	weapon_type = /obj/item/gun/energy/e_gun/underbarrel

/obj/item/gun/energy/e_gun/underbarrel
	name = "underbarrel energy gun"
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/underbarrel, /obj/item/ammo_casing/energy/laser/underbarrel)

/obj/item/attachment/gun/energy/e50
	name = "underbarrel energy cannon"
	desc = "An aftermarket conversion of Eoehoma Firearms' E-50 emitter cannon stripped down in order to fit on the rail mounts on other weapons. This less than orthodox conversion strips out most of the E-50's safety mechanisms to cut down on weight and size, making it dangerously prone to overheating even at its reduced power. Heat insulated gloves are reccomended."
	weapon_type = /obj/item/gun/energy/laser/e50/clip/underbarrel
	icon_state = "e50"

/obj/item/gun/energy/laser/e50/clip/underbarrel
	name = "underbarrel energy cannon"
	desc = "Watch out, its hot."

// turns out shrinking an industrial laser to this size is kinda dangerous
/obj/item/gun/energy/laser/e50/clip/underbarrel/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	if(..())
		var/prot = FALSE
		var/mob/living/carbon/human/shooter = user
		if(shooter.gloves)
			var/obj/item/clothing/gloves/shooter_glove = shooter.gloves
			if(shooter_glove.max_heat_protection_temperature)
				prot = (shooter_glove.max_heat_protection_temperature > 360)
		if(HAS_TRAIT(user, TRAIT_RESISTHEAT) || HAS_TRAIT(user, TRAIT_RESISTHEATHANDS))
			prot = TRUE
		var/obj/item/bodypart/affected_hand = shooter.get_bodypart("[(user.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
		if(prot == FALSE)
			if(affected_hand && affected_hand.receive_damage(0, 25))
				shooter.drop_all_held_items()
				to_chat(shooter,span_danger("The [src] violently heats up as it fires, burning your hand!"))

