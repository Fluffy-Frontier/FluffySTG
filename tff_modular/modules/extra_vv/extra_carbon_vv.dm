/**
 * EXTRA CARBON VV
 */
/mob/living/carbon/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION(VV_HK_GIVE_ADDICTION, "Give/Remove Addiction")

/mob/living/carbon/vv_do_topic(list/href_list)
	. = ..()

	if(href_list[VV_HK_GIVE_ADDICTION])
		if(!check_rights(R_VAREDIT))
			return
		if(!mind)	//Addictions are stored in the mind...
			return

		switch(tgui_alert(usr, "Give or Remove addictions?", "Addictions", list("Give", "Remove", "Cancel")))
			if("Give")
				var/chosen_addiction = input(usr, "Choose an addiction to add.", "Choose an addiction.") as null|anything in sort_list(SSaddiction.all_addictions, GLOBAL_PROC_REF(cmp_typepaths_asc))
				var/addiction_points = input(usr, "Choose the amount to add.\nAt least 600 are required to obtain an addiction.", "Choose the amount.", MAX_ADDICTION_POINTS) as num|null
				if(chosen_addiction && addiction_points)
					mind.add_addiction_points(chosen_addiction, addiction_points)
				return
			if("Remove")
				if(!mind.active_addictions)
					tgui_alert(usr, "No active addictions.", "Remove addictions")
					return
				var/chosen_addiction = input(usr, "Choose an addiction to remove.", "Choose an addiction.") as null|anything in sort_list(mind.active_addictions, GLOBAL_PROC_REF(cmp_typepaths_asc))
				if(chosen_addiction)
					mind.remove_addiction_points(chosen_addiction, MAX_ADDICTION_POINTS)
				return
			if("Cancel")
				return
