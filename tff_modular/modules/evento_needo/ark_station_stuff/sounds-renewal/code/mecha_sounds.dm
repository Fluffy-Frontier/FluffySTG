/// Добавляем мехам возможность устанавливать кастомные звуки при посадке и активации приближения. Заменяем некоторые звуки на общие - за неимением озвучки.

/obj/vehicle/sealed/mecha
	var/nominal_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/mecha/nominal.ogg'
	var/imag_enh_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/mecha/imag_enh.ogg'

/obj/vehicle/sealed/mecha/marauder/mauler
	nominal_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/mecha/nominal_syndicate.ogg'
	imag_enh_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/mecha/imag_enh_syndicate.ogg'

/obj/vehicle/sealed/mecha/gygax/dark
	nominal_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/mecha/nominal_syndicate.ogg'
	imag_enh_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/mecha/imag_enh_syndicate.ogg'

/obj/vehicle/sealed/mecha/savannah_ivanov
	nominal_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/mecha/nominal_russian.ogg'
	imag_enh_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/mecha/imag_enh_russian.ogg'

/obj/vehicle/sealed/mecha/moved_inside(mob/living/newoccupant)
	if(!(newoccupant?.client))
		return FALSE
	if(ishuman(newoccupant) && !Adjacent(newoccupant))
		return FALSE
	add_occupant(newoccupant)
	newoccupant.forceMove(src)
	newoccupant.update_mouse_pointer()
	add_fingerprint(newoccupant)
	log_message("[newoccupant] moved in as pilot.", LOG_MECHA)
	setDir(SOUTH)
	playsound(src, 'sound/machines/windowdoor.ogg', 50, TRUE)
	set_mouse_pointer()
	if(!internal_damage)
		SEND_SOUND(newoccupant, sound(nominal_sound,volume=50))
	return TRUE

/obj/vehicle/sealed/mecha/mmi_moved_inside(obj/item/mmi/brain_obj, mob/user)
	if(!(Adjacent(brain_obj) && Adjacent(user)))
		return FALSE
	if(!brain_obj.brain_check(user))
		return FALSE

	var/mob/living/brain/brain_mob = brain_obj.brainmob
	if(!user.transferItemToLoc(brain_obj, src))
		to_chat(user, span_warning("[brain_obj] is stuck to your hand, you cannot put it in [src]!"))
		return FALSE

	brain_obj.set_mecha(src)
	add_occupant(brain_mob)//Note this forcemoves the brain into the mech to allow relaymove
	mecha_flags |= SILICON_PILOT
	brain_mob.reset_perspective(src)
	brain_mob.remote_control = src
	brain_mob.update_mouse_pointer()
	setDir(SOUTH)
	log_message("[brain_obj] moved in as pilot.", LOG_MECHA)
	if(!internal_damage)
		SEND_SOUND(brain_obj, sound(nominal_sound,volume=50))
	user.log_message("has put the MMI/posibrain of [key_name(brain_mob)] into [src]", LOG_GAME)
	brain_mob.log_message("was put into [src] by [key_name(user)]", LOG_GAME, log_globally = FALSE)
	return TRUE


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/obj/item/mecha_parts/mecha_equipment
	destroy_sound = 'sound/machines/engine_alert/engine_alert1.ogg'

/obj/item/mecha_parts/mecha_equipment/weapon
	destroy_sound = 'sound/machines/engine_alert/engine_alert1.ogg'

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/action/vehicle/sealed/mecha/mech_zoom
	name = "Zoom"
	button_icon_state = "mech_zoom_off"

/datum/action/vehicle/sealed/mecha/mech_zoom/Trigger(trigger_flags)
	if(!owner?.client || !chassis || !(owner in chassis.occupants))
		return
	chassis.zoom_mode = !chassis.zoom_mode
	button_icon_state = "mech_zoom_[chassis.zoom_mode ? "on" : "off"]"
	chassis.log_message("Toggled zoom mode.", LOG_MECHA)
	to_chat(owner, "[icon2html(chassis, owner)]<font color='[chassis.zoom_mode?"blue":"red"]'>Zoom mode [chassis.zoom_mode?"en":"dis"]abled.</font>")
	if(chassis.zoom_mode)
		owner.client.view_size.setTo(4.5)
		SEND_SOUND(owner, sound(chassis.imag_enh_sound, volume=50))
	else
		owner.client.view_size.resetToDefault()
	build_all_button_icons()
