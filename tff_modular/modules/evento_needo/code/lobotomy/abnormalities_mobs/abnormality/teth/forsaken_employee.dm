/mob/living/simple_animal/hostile/abnormality/forsaken_employee
	name = "Forsaken Employee"
	desc = "A person who seems to be wearing an L Corp Uniform and is covered in chains, as well as wearing a box with what looks like Enkephalin in it on their head."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "forsaken_employee"
	fear_level = TETH_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/denial,
		/datum/ego_datum/armor/denial,
	)
	gift_type =  /datum/ego_gifts/denial
	var/list/blackout_list = list()

	//Observation is mostly mirror dungeon but with some changed phrasing
	observation_prompt = "The sound of plastic crashing is accompanied by the sloshing of a liquid. <br>\
		It looks like something that used to be a fellow employee. <br>\
		Its identity is evidenced by the now-worn formal outfit and the employee card. <br>\
		The card is almost too battered and contaminated to recognize. <br>\
		Wearing a box filled with Enkephalin on their head, the employee rams it into what looks like the door to a containment unit. <br>\
		A rubber O-ring is worn around their neck. Could it be there to prevent Enkephalin from spilling?"


/mob/living/simple_animal/hostile/abnormality/forsaken_employee/FailureEffect(mob/living/carbon/human/user, work_type, pe, work_time, canceled)
	. = ..()
	qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/forsaken_employee/ZeroQliphoth(mob/living/carbon/human/user)
	. = ..()
	qliphoth_change(1)
	visible_message("[src] lets out a muffled scream!")
	playsound(get_turf(src), 'sound/mobs/humanoids/human/scream/malescream_6.ogg', 15, 3, 3)
	var/list/possible_areas = list()
	if(LAZYLEN(blackout_list) < 3)
		for(var/area/A in world)
			if(A.z == z && A.lightswitch == TRUE)
				possible_areas += A
		if(length(possible_areas) != 0)
			var/area/chosen_area = pick(possible_areas)
			blackout_list += chosen_area
			chosen_area.lightswitch = FALSE
			chosen_area.update_icon()
			chosen_area.power_change()
			addtimer(CALLBACK(src, PROC_REF(TurnOn), chosen_area), 10 MINUTES)

/mob/living/simple_animal/hostile/abnormality/forsaken_employee/proc/TurnOn(area/A)
	A.lightswitch = TRUE
	blackout_list -= A
	A.update_icon()
	A.power_change()
