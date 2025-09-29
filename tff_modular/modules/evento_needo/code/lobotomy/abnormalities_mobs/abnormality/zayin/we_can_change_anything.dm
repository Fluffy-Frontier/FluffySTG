#define STATUS_EFFECT_CHANGE /datum/status_effect/we_can_change_anything
/mob/living/simple_animal/hostile/abnormality/we_can_change_anything
	name = "We Can Change Anything"
	desc = "A human sized container with spikes inside it. You shouldn't enter it"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	icon_state = "wecanchange"
	maxHealth = 1000
	health = 1000
	fear_level = ZAYIN_LEVEL
	damage_coeff = list(BURN = 2, BRAIN = 0.8, BRUTE = 1, TOX = 0.5)


	var/charger = TRUE
	var/charge_distance = 8
	var/charge_frequency = 40 SECONDS
	var/knockdown_time = 0
	blood_volume = 0 // Doesn't normally bleed
	layer = LARGE_MOB_LAYER
	speech_span = SPAN_ROBOT

	ego_list = list(
		/datum/ego_datum/weapon/change,
		/datum/ego_datum/armor/change,
		/datum/ego_datum/weapon/iron_maiden,
	)

	gift_type =  /datum/ego_gifts/change
	gift_message = "Your heart beats with new vigor."
	grouped_abnos = list(
		/mob/living/simple_animal/hostile/abnormality/helper = 1.5,
		/mob/living/simple_animal/hostile/abnormality/cleaner = 1.5,
	)

	observation_prompt = "Is your child a troublemaker who cries all the time? We can change that! <br>\
		Don’t like how you look? Are you too fat? Too skinny? We can change that! <br>\
		Is your house suffering from an outage because you don’t have the money to pay for the power bill? <br>\
		We can change that!<br>\
		It’s quite simple. Just open up the machine, step inside, and press the button to make it shut."


	var/grinding = FALSE
	var/grind_duration = 5 SECONDS
	var/grind_damage = 2 // Dealt 100 times
	var/sacrifice = FALSE // are we doing "Enter machine" work?
	var/ramping_speed = 20 // work speed for sacrifice work, gets subtracted from so we can have faster work ticks.
	var/total_damage = 0 // stored so we can later convert it into PE
	var/datum/action/cooldown/mob_cooldown/charge/charge
	work_types = null

/mob/living/simple_animal/hostile/abnormality/we_can_change_anything/Initialize(mapload)
	. = ..()
	charge = new(src)
	charge.Grant(src)
	RegisterSignal(src, COMSIG_STARTED_CHARGE, PROC_REF(handle_charge_target))
	RegisterSignal(src, COMSIG_FINISHED_CHARGE, PROC_REF(charge_end))

/mob/living/simple_animal/hostile/abnormality/we_can_change_anything/Destroy()
	. = ..()
	UnregisterSignal(src, list(COMSIG_STARTED_CHARGE, COMSIG_FINISHED_CHARGE))

/mob/living/simple_animal/hostile/abnormality/we_can_change_anything/proc/StoreWorker(mob/living/L) //Stores the worker inside
	if(!L)
		return FALSE
	playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/we_can_change_anything/change_start.ogg', 50, FALSE)
	ADD_TRAIT(L, TRAIT_NOBREATH, type)
	ADD_TRAIT(L, TRAIT_IMMOBILIZED, type)
	ADD_TRAIT(L, TRAIT_HANDS_BLOCKED, type)
	L.forceMove(src)
	return TRUE

/mob/living/simple_animal/hostile/abnormality/we_can_change_anything/proc/ReleaseWorker() //Releases all workers inside
	var/spew_turf = pick(get_adjacent_open_turfs(src))
	for(var/atom/movable/i in contents)
		if(isliving(i))
			var/mob/living/L = i
			L.Knockdown(10, FALSE)
			REMOVE_TRAIT(L, TRAIT_NOBREATH, type)
			REMOVE_TRAIT(L, TRAIT_IMMOBILIZED, type)
			REMOVE_TRAIT(L, TRAIT_HANDS_BLOCKED, type)
		i.forceMove(spew_turf)

/mob/living/simple_animal/hostile/abnormality/we_can_change_anything/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(!.)
		return
	if(!istype(datum_reference)) // Prevents a runtime
		return FALSE
	StoreWorker(user) //Yoink.
	sacrifice = TRUE
	change_anything(user)

/mob/living/simple_animal/hostile/abnormality/we_can_change_anything/proc/change_anything(mob/living/carbon/human/user)
	if(prob(90))
		shake_up_animation(1)
		playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/we_can_change_anything/change_generate.ogg', 30, FALSE)
		user.apply_damage(total_damage, BRUTE) // say goodbye to your kneecaps chucklenuts!
		total_damage += 5
		return .(user)
	else
		playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/we_can_change_anything/change_gas.ogg', 50, TRUE)
		sacrifice = FALSE
		if(user.health <= 0)
			qdel(user) //reduced to atoms
		else
			ReleaseWorker()
		total_damage = 0

/mob/living/simple_animal/hostile/abnormality/we_can_change_anything/BreachEffect(mob/living/carbon/human/user)
	can_breach = TRUE
	var/mob/living/carbon/human/H = locate() in view(3, src)
	if(!H)
		forceMove(pick(GLOB.generic_event_spawns))
	return ..()

/mob/living/simple_animal/hostile/abnormality/we_can_change_anything/Move()
	if(charge.actively_moving)
		return ..()
	return FALSE

/mob/living/simple_animal/hostile/abnormality/we_can_change_anything/AttackingTarget()
	if(COOLDOWN_FINISHED(src, charge.cooldowns))
		COOLDOWN_START(src, charge.cooldown_time, charge_frequency)
		Grind()
		return TRUE
	return FALSE

/mob/living/simple_animal/hostile/abnormality/we_can_change_anything/proc/handle_charge_target(atom/target)
	SIGNAL_HANDLER
	update_all()

/mob/living/simple_animal/hostile/abnormality/we_can_change_anything/proc/charge_end()
	SIGNAL_HANDLER
	Grind()

/mob/living/simple_animal/hostile/abnormality/we_can_change_anything/proc/Grind()
	if(grinding)
		return
	grinding = TRUE
	var/list/AoE = list()
	visible_message(span_warning("[src] opens wide!"), span_nicegreen("Time to begin another productive day!"))
	for(var/turf/open/T in view(2, src))
		AoE += T
		new /obj/effect/temp_visual/cult/sparks(T)
	addtimer(CALLBACK(src, PROC_REF(Grind_second)), 1 SECONDS)

/mob/living/simple_animal/hostile/abnormality/we_can_change_anything/proc/Grind_second()
	if(stat == DEAD)
		return
	//for(var/turf/open/TF in AoE)
	//	for(var/mob/living/carbon/human/H in TF)
	//		H.Stun(5 SECONDS)
	//		if(get_dist(src, H) > 1)
	//			step_towards(H, src)
	//		src.buckle_mob(H, TRUE, TRUE)
	//		if(H.blood_volume > 0)
	//			blood_volume += H.blood_volume
	update_all()
	if(!LAZYLEN(buckled_mobs))
		grinding = FALSE
		return
	var/grind_end = world.time + grind_duration
	var/sound_cooldown = 0
	while(grind_end > world.time)
		if(sound_cooldown < 3)
			sound_cooldown++
		else
			sound_cooldown = 0
			playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/change/change_ding.ogg', 50)
		for(var/mob/living/carbon/human/victim in get_turf(src))
			victim.apply_damage(grind_damage, BRUTE)
			if(victim.health <= 0)
				victim.gib(DROP_ALL_REMAINS)
		stoplag(1)
	unbuckle_all_mobs()
	grinding = FALSE

/mob/living/simple_animal/hostile/abnormality/we_can_change_anything/proc/update_all()
	if(icon_state != initial(icon_state))
		icon = initial(icon)
		icon_state = initial(icon_state)
		pixel_x = initial(pixel_x)
		base_pixel_x = initial(base_pixel_x)
		density = initial(density)
		return
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x48.dmi'
	icon_state = "change_opening"
	pixel_x = -8
	base_pixel_x = -8
	density = FALSE

/datum/status_effect/we_can_change_anything
	id = "change"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 5 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/we_can_change_anything

/atom/movable/screen/alert/status_effect/we_can_change_anything
	name = "The desire to change"
	desc = "Your painful experience has made you more resilient to RED damage."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/status_sprites.dmi'
	icon_state = "change"

/datum/status_effect/we_can_change_anything/on_apply()
	. = ..()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/status_holder = owner
	status_holder.physiology.burn_mod *= 0.9

/datum/status_effect/we_can_change_anything/on_remove()
	. = ..()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/status_holder = owner
	status_holder.physiology.burn_mod /= 0.9

#undef STATUS_EFFECT_CHANGE
