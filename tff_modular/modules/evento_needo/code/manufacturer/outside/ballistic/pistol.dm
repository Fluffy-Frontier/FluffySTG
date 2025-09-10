
/obj/item/gun/ballistic/automatic/pistol/commissar
	name = "\improper Commissar"
	desc = "A Nanotrasen-issue handgun, modified with a voice box to further enhance its effectiveness in troop discipline."
	icon_state = "commander"
	icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/onmob.dmi'

	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/co9mm
	var/funnysounds = TRUE
	var/cooldown = 0
	load_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_insert.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_insert.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_release.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_release.ogg'

	rack_sound = 'tff_modular/modules/evento_needo/sounds/pistol/rack_small.ogg'
	lock_back_sound = 'tff_modular/modules/evento_needo/sounds/pistol/lock_small.ogg'
	bolt_drop_sound = 'tff_modular/modules/evento_needo/sounds/pistol/drop_small.ogg'

/obj/item/gun/ballistic/automatic/pistol/commissar/equipped(mob/living/user, slot)
	..()
	if(slot == ITEM_SLOT_HANDS && funnysounds) // We do this instead of equip_sound as we only want this to play when it's wielded
		playsound(src, 'tff_modular/modules/evento_needo/sounds/commissar/pickup.ogg', 30, 0)

/obj/item/gun/ballistic/automatic/pistol/commissar/shoot_live_shot(mob/living/user, pointblank, atom/pbtarget, message)
	. = ..()
	if(prob(50) && funnysounds)
		playsound(src, 'tff_modular/modules/evento_needo/sounds/commissar/shot.ogg', 30, 0)

/obj/item/gun/ballistic/automatic/pistol/commissar/shoot_with_empty_chamber(mob/living/user)
	. = ..()
	if(prob(50) && funnysounds)
		playsound(src, 'tff_modular/modules/evento_needo/sounds/commissar/dry.ogg', 30, 0)

/obj/item/gun/ballistic/automatic/pistol/commissar/insert_magazine(mob/user, obj/item/ammo_box/magazine/AM, display_message)
	. = ..()
	if(bolt_locked)
		drop_bolt(user)
		if(. && funnysounds)
			playsound(src, 'tff_modular/modules/evento_needo/sounds/commissar/magazine.ogg', 30, 0)

/obj/item/gun/ballistic/automatic/pistol/commissar/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	funnysounds = !funnysounds
	to_chat(user, span_notice("You toggle [src]'s vox audio functions."))

/obj/item/gun/ballistic/automatic/pistol/commissar/click_alt(mob/user)
	. = ..()
	if((cooldown < world.time - 200) && funnysounds)
		user.audible_message("<font color='red' size='5'><b>DON'T TURN AROUND!</b></font>")
		playsound(src, 'tff_modular/modules/evento_needo/sounds/commissar/dontturnaround.ogg', 50, 0, 4)
		cooldown = world.time

/obj/item/gun/ballistic/automatic/pistol/commissar/examine(mob/user)
	. = ..()
	if(funnysounds)
		. += span_info("Alt-click to use \the [src] vox hailer.")

//not technically a pistol but whatever
/obj/item/gun/ballistic/derringer
	name = ".38 Derringer"
	desc = "An easily concealable derringer. Uses .38 special ammo."
	icon_state = "derringer"
	inhand_icon_state = "hp_generic"

	icon = 'tff_modular/modules/evento_needo/icons/hunterspride/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/hunterspride/onmob.dmi'

	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rev38
	fire_sound = 'tff_modular/modules/evento_needo/sounds/revolver/shot.ogg'
	load_sound = 'tff_modular/modules/evento_needo/sounds/revolver/load_bullet.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/revolver/empty.ogg'
	fire_sound_volume = 60
	dry_fire_sound = 'tff_modular/modules/evento_needo/sounds/revolver/dry_fire.ogg'
	casing_ejector = FALSE
	internal_magazine = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	tac_reloads = FALSE
	w_class = WEIGHT_CLASS_TINY

/obj/item/gun/ballistic/derringer/get_ammo(countchambered = FALSE, countempties = TRUE)
	var/boolets = 0 //legacy var name maturity
	if (chambered && countchambered)
		boolets++
	if (magazine)
		boolets += magazine.ammo_count(countempties)
	return boolets

/obj/item/gun/ballistic/derringer/examine(mob/user)
	. = ..()
	var/live_ammo = get_ammo(FALSE, FALSE)
	. += "[live_ammo ? live_ammo : "None"] of those are live rounds."

/obj/item/gun/ballistic/derringer/traitor
	name = "\improper .357 Syndicate Derringer"
	desc = "An easily concealable derriger, if not for the bright red-and-black. Uses .357 ammo."

	icon = 'tff_modular/modules/evento_needo/icons/scarborough/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/scarborough/onmob.dmi'

	icon_state = "derringer_syndie"
	inhand_icon_state = "sa_generic"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rus357
	fire_sound_volume = 50 //Tactical stealth firing

/obj/item/gun/ballistic/derringer/gold
	name = "\improper Golden Derringer"
	desc = "The golden sheen is somewhat counter-intuitive on a holdout weapon, but it looks cool. Uses .357 ammo."
	icon_state = "derringer_gold"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rus357
