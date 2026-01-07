/mob/living/proc/start_necromorph_conversion(var/duration = 12, enhanced_bonus = 0)
	var/intensity_step = 1 / duration
	var/intensity = 0
	var/decision = tgui_alert(src, "Do you want to play as a necromoprh?", "Necro Ressurection", list("Yes", "No"))
	for (var/i in 1 to duration)
		//If the mob has become invalid, stop this
		if(!is_necromorph_conversion_valid())
			return

		intensity += intensity_step

		if (prob(80))
			shake_animation(intensity*50)

		if (prob(80))
			playsound(src, "fracture", intensity*100, TRUE)

		if (prob(20))
			var/list/verbs = list("twitches", "cringes", "twists", "contorts", "writhes", "snaps", "crunches", "jerks", "spasms", "convulses", "distorts")
			var/list/adverbs	=	list("gruesomely", "uncontrollably", "violently", "awkwardly", "horribly", "pitifully", "painfully")
			visible_message("[src] [prob(20)	?	"[pick(adverbs)] ":""][pick(verbs)] [prob(20)	?	"and [pick(verbs)], ":""][pick(adverbs)]")

		sleep(1 SECONDS)

	//Actually do it
	necromorph_conversion(enh_bonus = enhanced_bonus, choice = decision)

	/*
	The place where converting actually happens, this is instant, no sleeps here
*/
/mob/living/proc/necromorph_conversion(var/compatibility = 1, enh_bonus = 0, choice = FALSE)
	//Final
	if (!is_necromorph_conversion_valid())
		return

	//if (client || key)
		//ghostize()	//Kick out any existing client


	//Animal conversion doesnt use species, we just spawn a new mob and delete the old one
	compatibility += enh_bonus
	var/list/options = get_necromorph_conversion_possibilities(compatibility)
	var/newtype = pick_weight(options)
	var/obj/structure/marker/mark = pick(GLOB.necromorph_markers)
	if(!isnull(newtype))
		var/mob/living/carbon/human/necromorph/necro = new newtype(loc, mark)
		mark.add_necro(necro)
		if(choice == "Yes")
			var/mob/eye/marker_signal/signal = new /mob/eye/marker_signal(loc, mark)
			signal.ckey = ckey
			signal.possess_necromorph(necro)
	gib()


	//Mice become divider components
	//Cats, dogs, etc become lurkers


//TODO: Fix necromorphs wearing rigs

/mob/living/carbon/human/necromorph_conversion(var/compatibility = 1, enh_bonus = 0, choice = FALSE)
	//Final
	if (!is_necromorph_conversion_valid())
		return

	compatibility += enh_bonus
	compatibility += get_bonus_conversion_compatibility()

	var/list/options = get_necromorph_conversion_possibilities(compatibility)

	//Lets do lots of audio of flesh cracking at randomly staggered intervals over a second
	for (var/i in 1 to 5)
		spawn(rand(0 SECONDS, 1 SECONDS))
		playsound(src, "fracture", 18, TRUE)

	//We do gib visual fx without actually destroying the mob
	//spawn_gibs()
	var/newtype = pick_weight(options)
	var/obj/structure/marker/mark = pick(GLOB.necromorph_markers)
	if(!isnull(newtype))
		var/mob/living/carbon/human/necromorph/necro = new newtype(loc, mark)
		necro.previous_owner = "There are still traces of his past on him. He looks just like [real_name]"
		mark.add_necro(necro)
		if(choice == "Yes")
			var/mob/eye/marker_signal/signal = new /mob/eye/marker_signal(loc, mark)
			signal.ckey = ckey
			signal.possess_necromorph(necro)
	gib()


	/*
	Necro Selection

	Animals pick based on size
	*/
/mob/living/proc/get_necromorph_conversion_possibilities()
	var/list/options = list()
	switch(mob_size)
		if (MOB_SIZE_HUMAN)
			options = list(/mob/living/carbon/human/necromorph/exploder = 1)
		if (MOB_SIZE_LARGE)
			options = list(/mob/living/carbon/human/necromorph/brute = 1)
		if (MOB_SIZE_SMALL || MOB_SIZE_TINY)
			options = list(/mob/living/carbon/human/necromorph/lurker = 1)
	return options

/mob/living/carbon/human/get_necromorph_conversion_possibilities(var/compatibility = 1)
	//These options are always available
	var/list/options = list(
		/mob/living/carbon/human/necromorph/slasher = 9.5 / compatibility,
		/mob/living/carbon/human/necromorph/slasher/enhanced = 1 * compatibility,
		)

	//Monkey?
	if(mob_size < MOB_SIZE_HUMAN)
		options += list(/mob/living/carbon/human/necromorph/leaper/hopper = 1)
		return options

	//Gender based options
	if (gender == FEMALE)
		options += list(/mob/living/carbon/human/necromorph/spitter = 3 * compatibility)
	else
		options += list(/mob/living/carbon/human/necromorph/exploder = 2.5 * compatibility)
		options += list(/mob/living/carbon/human/necromorph/exploder/enhanced = 0.5 * compatibility)

	//Heavily poisoned people can become a puker
	if (get_tox_loss() > 100)
		options += list(/mob/living/carbon/human/necromorph/puker = 2 * compatibility)


	/*
		If the victim was lightly armored and has both of their legs remaining, they might become a leaper
		Why legs? The leaper's tail is made of two legs fused together

		Why then does a slasher not require the host to have arms, you might ask?
		Because slashers grow new arms out of the victim's shoulderblades, the existing arms become vestigial and hang limply
	*/

	return options


/*
	Safety Checks
*/
/mob/living/proc/is_necromorph_conversion_valid()
	.= TRUE
	if (stat != DEAD && stat != UNCONSCIOUS)
		return FALSE

	if(istype(src, /mob/living/carbon/human/necromorph))
		return FALSE

	if (QDELETED(src))
		return FALSE

/mob/living/carbon/human/is_necromorph_conversion_valid()
	.=..()
	if (!get_bodypart(BODY_ZONE_HEAD))
		return FALSE



//Compatibility
/*
	This proc returns a number which is added to the base compatibility
	penalties are here too, it can go negative
*/
/mob/living/proc/get_bonus_conversion_compatibility()
	.=0

	if ((world.time - timeofdeath) < 15 MINUTES)
		//Fresh corpses are better
		. += 0.25



/mob/living/carbon/human/get_bonus_conversion_compatibility()
	.=..()

	. -= 0.075 * (num_hands + num_legs)
