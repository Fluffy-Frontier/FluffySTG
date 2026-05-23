
/mob/living/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION(VV_HK_GIVE_PSIONIC, "Give Psionic")

/mob/living/vv_do_topic(list/href_list)
	. = ..()

	if(!.)
		return

	if(href_list[VV_HK_GIVE_PSIONIC])
		admin_give_psionic(usr)

/mob/living/proc/admin_give_psionic(mob/admin)
	if(!admin || !check_rights(NONE))
		return
	var/picked_type = tgui_input_list(admin, "Pick the psionic type.", "Psionic Controller", subtypesof(/datum/psionic))
	if(tgui_alert(admin, "Confirm creation.", "Psionic Controller", list("Yes", "No")) != "Yes")
		return
	var/datum/psionic/new_psionic = picked_type
	add_psionic(new_psionic)
	message_admins(span_adminnotice("[key_name_admin(admin)] gave a psionic powers of tier [new_psionic.get_level()] to [src]."))
	log_admin("[key_name(admin)] gave a psionic powers of tier [new_psionic.get_level()] to [src].")
	BLACKBOX_LOG_ADMIN_VERB("Give Psionic")

