/mob/living/simple_animal/hostile/abnormality/fetus
	name = "Nameless Fetus"
	desc = "A giant, pus-filled baby."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x48.dmi'
	icon_state = "fetus"
	maxHealth = 400
	health = 400
	fear_level = HE_LEVEL
	pixel_x = -8
	base_pixel_x = -8
	ego_list = list(
		/datum/ego_datum/weapon/syrinx,
		/datum/ego_datum/weapon/trachea,
		/datum/ego_datum/armor/syrinx,
	)
	gift_type =  /datum/ego_gifts/syrinx
	observation_prompt = "The baby never cries. <br>It kept that way forever. <br>\
		As a lack of words doesn't necessarily mean a lack of emotions, a lack of crying doesn't mean lack of desire. <br>\
		Since time unknown, the baby has had a mouth. <br>The baby who does not understand cries, expresses hunger, and causes pain for the others. <br>You..."


	var/mob/living/carbon/human/calling = null
	var/criesleft

/mob/living/simple_animal/hostile/abnormality/fetus/ZeroQliphoth(mob/living/carbon/human/user)
	for(var/mob/living/carbon/human/H in GLOB.player_list)	//Way harder to get a list of living humans.
		if(H.stat != DEAD)
			criesleft+=3		//Get a max of 3 cries per person.
	check_players()
	check_range()
	return ..()

	//Are they nearby?
/mob/living/simple_animal/hostile/abnormality/fetus/proc/check_range()
	if(calling && Adjacent(calling))
		calling.gib(DROP_ALL_REMAINS)
		calling = null

		for(var/mob/living/carbon/human/H in GLOB.player_list)
			to_chat(H, span_userdanger("The creature is satisfied."))

		notify_ghosts("The nameless fetus is satisfied.", source = src, header="Something Interesting!") // bless this mess
		qliphoth_change(1)
		return

	addtimer(CALLBACK(src, PROC_REF(check_range)), 2 SECONDS)


/mob/living/simple_animal/hostile/abnormality/fetus/proc/check_players()
	if(datum_reference.qliphoth_meter == 1)
		return
	if(criesleft<=0)
		for(var/mob/living/carbon/human/H in GLOB.player_list)
			to_chat(H, span_warning("The crying stops. Finally, silence."))
		return


	criesleft--

	//Find a living player, they're the new target.
	var/list/checking = list()
	for(var/mob/living/carbon/human/H in GLOB.alive_player_list)
		if(H.z == z && H.stat != DEAD)
			checking +=H
	if(LAZYLEN(checking))
		calling = pick(checking)

		//and make a global announce
		for(var/mob/living/carbon/human/H in GLOB.alive_player_list)
			to_chat(H, span_userdanger("The fetus calls out for [calling.real_name]."))

		notify_ghosts("The fetus calls out for [calling.real_name].", source = src, header="Something Interesting!") // bless this mess

	var/list/qliphoth_abnos = list()
	for(var/mob/living/simple_animal/hostile/abnormality/V in GLOB.abnormality_mob_list)
		if(V.IsContained())
			qliphoth_abnos += V

	if(LAZYLEN(qliphoth_abnos))
		var/mob/living/simple_animal/hostile/abnormality/meltem = pick(qliphoth_abnos)
		meltem.qliphoth_change(-1)

	//Babies crying hurts your head
	SLEEP_CHECK_DEATH(3, src)
	for(var/mob/living/L in urange(10, src))
		if(faction_check_atom(L, FALSE))
			continue
		if(L.stat == DEAD)
			continue
		to_chat(L, span_warning("The crying hurts your head..."))
		L.apply_damage(20, BRUTE)
		L.playsound_local(get_turf(L), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/fetus/crying.ogg', 50, FALSE)

	addtimer(CALLBACK(src, PROC_REF(check_players)), 30 SECONDS)


/* Work effects */
/mob/living/simple_animal/hostile/abnormality/fetus/NeutralEffect(mob/living/carbon/human/user, work_type, pe)
	. = ..()
	if(prob(20))
		qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/fetus/FailureEffect(mob/living/carbon/human/user)
	if(prob(80))
		qliphoth_change(-1)
	return
