/mob/living/simple_animal/hostile/abnormality/someones_portrait
	name = "Someone's Portrait"
	desc = "A simple portrait, with a head, with red eyes, staring to somewhere or someone."
	pixel_y = 64
	base_pixel_y = 64
	density = FALSE
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	fear_level = TETH_LEVEL
	damage_coeff = list(BURN = 1, BRAIN = 1, BRUTE = 1, TOX = 1)

	ego_list = list(
		/datum/ego_datum/weapon/snapshot,
		/datum/ego_datum/armor/snapshot,
	)
	gift_type = /datum/ego_gifts/snapshot
//TODO: Resprite + redo of this
	observation_prompt = "They say it was of a very important relative of ours, but we do not recognize anyone present. <br>I've always hated the picture, why couldn't anyone else see it was just biding its time, waiting to strike?"


//Initialize
/mob/living/simple_animal/hostile/abnormality/someones_portrait/PostSpawn()
	..()
	DestroyLights()

//Work
/mob/living/simple_animal/hostile/abnormality/someones_portrait/PostWorkEffect(mob/living/carbon/human/user)
	if(user.get_major_clothing_class() != CLOTHING_ENGINEERING || user.get_major_clothing_class() != CLOTHING_SCIENCE)
		PanicUser(user)
	DestroyLights()

/mob/living/simple_animal/hostile/abnormality/someones_portrait/FailureEffect(mob/living/carbon/human/user)
	if (!(user.sanity_lost))
		PanicUser(user, TRUE)

//Procs
/mob/living/simple_animal/hostile/abnormality/someones_portrait/proc/DestroyLights()
	for(var/obj/machinery/light/L in range(3, src)) //blows out the lights
		L.on = 1
		L.break_light_tube()

/mob/living/simple_animal/hostile/abnormality/someones_portrait/proc/PanicUser(mob/living/carbon/human/user, workfailure) //its over bros...
	to_chat(user, span_userdanger("He's going to get you! You've got to run!"))
	playsound(get_turf(user), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/someonesportrait/panic.ogg', 40, FALSE, -5)
	user.adjustSanityLoss(user.maxSanity)
	if(!workfailure)
		addtimer(CALLBACK(src, PROC_REF(PanicCheck), user), 1) //Gives sanity time to update for forced panic type

/mob/living/simple_animal/hostile/abnormality/someones_portrait/proc/PanicCheck(mob/living/carbon/human/user) //forced wander panic
	var/mob/living/carbon/human/H = user
	if (H.sanity_lost)
		QDEL_NULL(H.ai_controller)
		H.ai_controller = /datum/ai_controller/insane/wander
		H.InitializeAIController()
		H.apply_status_effect(/datum/status_effect/panicked_type/wander)
		return
