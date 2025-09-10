/mob/living/simple_animal/hostile/abnormality/oracle
	name = "Oracle of No Future"
	desc = "An ancient cryopod with the name 'Maria' etched into the side. \
		You look inside expecting to see the body of the person named, \
		but all you see is a gooey substance at the bottom."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	icon_state = "oracle"
	icon_living = "oracle"
	maxHealth = 1500
	health = 1500
	damage_coeff = list(BURN = 2, BRAIN = 0, BRUTE = 2, TOX = 2)
	fear_level = ZAYIN_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/dead_dream,
		/datum/ego_datum/armor/dead_dream
	)
//	gift_type =  /datum/ego_gifts/oracle
	observation_prompt = "In a vivid dream you see her, as she was. \
		<br>She was told that it would feel like no time at all. \
		<br>Silently sleeping she dreams of the future, a future she was promised. \
		<br>Before your eyes untold time passes until one day."


	var/list/sleeplines = list(
		"Hello...",
		"I am reaching you from beyond the veil...",
		"I cannot move, I cannot speak...",
		"But for you, I have some information to part...",
		"Please wait a moment while I retrieve it for you....",
		"Ah, I have information on the next ordeal.... as you call it...",
		"The next ordeal is...",
	)
	var/list/fakeordeals = list(
		//Some Based off the 7 trumpets
		"Hail of fire and blood..... Thrown to the earth.... burning up nature...",
		"A great mountain..... plunging into the sea..... oceans of blood..... killing sea life....",
		"A star.... falling to earth.... poisoning the fresh water....",
		"The sky goes dark..... all the stars, the moon and even the sun.....",
		"Woe...... Woe to those who dwell on earth....",
		"A star falls to earth.... opening the abyss...",
		"Locusts.... with scorpion tails.... man's face... and lion's teeth.....",
		"Two hundred million troops.... fire and smoke.... and their plague will kill man...",
		"The kingdom of the world has become the kingdom of His Messiah.... reigning forever and ever...",
		//And some I made
		"Cold.... Endless Cold.....",
		"A man with many arms......",
		"A woman without a face.... and many children screaming....",
		// -IP additions
		"In a ruined hallway... scavengers feed on a worker...",
		"Hundred eyes... a endless maw... long legs... im scared...",
		"I hear it around the corner... but i cant look... i dont want to see whats there...",
		"The corner of a room... someone is smiling... their skin isnt on right...",
		"A plume of light erupts from a city...",
		"Monsters... monsters everywhere... they are eating people in the streets...",
		"A woman with a dog head... she is smoking silently...",
		"A person in a blue coat... they fold into a book...",
		)

	update_qliphoth = -1
	work_types = null

/mob/living/simple_animal/hostile/abnormality/oracle/Move()
	return FALSE

/mob/living/simple_animal/hostile/abnormality/oracle/CanAttack(atom/the_target)
	return FALSE

/mob/living/simple_animal/hostile/abnormality/oracle/try_working(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	user.Sleeping(30 SECONDS) //Sleep with her, so that you can get some information
	for(var/line in sleeplines)
		to_chat(user, span_notice(line))
		SLEEP_CHECK_DEATH(40, src)
		if(!user.IsSleeping())
			return
	if(prob(50))
		var/chosenfake = pick(fakeordeals)
		to_chat(user, span_notice("[chosenfake]"))
		return
	if(!SSlobotomy_corp.next_ordeal)
		to_chat(user, span_notice("All ordeals.... are completed..."))
		return
	to_chat(user, span_notice("[SSlobotomy_corp.next_ordeal.name]"))

/mob/living/simple_animal/hostile/abnormality/oracle/Initialize(mob/living/carbon/human/user)
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_ABNORMALITY_BREACH, PROC_REF(OnAbnoBreach))

/mob/living/simple_animal/hostile/abnormality/oracle/Destroy()
	UnregisterSignal(SSdcs, COMSIG_GLOB_ABNORMALITY_BREACH)
	return ..()

/mob/living/simple_animal/hostile/abnormality/oracle/proc/OnAbnoBreach(datum/source, mob/living/simple_animal/hostile/abnormality/abno)
	SIGNAL_HANDLER
	if(z != abno.z)
		return
	addtimer(CALLBACK(src, PROC_REF(NotifyEscape), loc, abno), rand(1 SECONDS, 3 SECONDS))

/mob/living/simple_animal/hostile/abnormality/oracle/proc/NotifyEscape(mob/living/carbon/human/user, mob/living/simple_animal/hostile/abnormality/abno)
	if(QDELETED(abno) || abno.stat == DEAD)
		return
	for(var/mob/living/carbon/human/H in GLOB.clients)
		if(H.IsSleeping())
			continue //You need to be sleeping to get notified
		to_chat(H, "<span class='notice'>Oh.... [abno]... It has breached containment...</span>")

//ER stuff
/mob/living/simple_animal/hostile/abnormality/oracle/BreachEffect(mob/living/carbon/human/user, breach_type)//finish this shit
	var/chosenfake = pick(fakeordeals)
	for(var/mob/living/L in view(48, src))
		if(L.z != z)
			continue
		if(faction_check_atom(L))
			continue
		to_chat(L, span_userdanger("[chosenfake]"))
	addtimer(CALLBACK(src, PROC_REF(NukeAttack)), 90 SECONDS)
	return ..()

/mob/living/simple_animal/hostile/abnormality/oracle/proc/NukeAttack()
	if(stat == DEAD)
		return
	playsound(src, 'sound/effects/magic/wandodeath.ogg', 100, FALSE, 40, falloff_distance = 10)
	for(var/mob/living/L in view(48, src))
		if(L.z != z)
			continue
		if(faction_check_atom(L))
			continue
		to_chat(L, span_userdanger("Visions of a horrible future flash before your eyes!"))
		L.apply_damage((150 - get_dist(src, L)), BRUTE)
	qdel(src)
