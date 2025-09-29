#define STATUS_EFFECT_BABAYAGA /datum/status_effect/babayaga
/mob/living/simple_animal/hostile/abnormality/babayaga
	name = "Baba Yaga"
	desc = "Looks like a palace, the doors are shut tightly.."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/96x96.dmi'
	icon_state = "babayaga"
	icon_living = "babayaga"
	var/icon_aggro = "babayaga_breach"
	faction = list("hostile", "babayaga")
	speak_emote = list("intones")
	pixel_x = -30
	base_pixel_x = -30
	melee_damage_lower = 40
	melee_damage_upper = 50
	melee_damage_type = BRUTE
	stat_attack = HARD_CRIT
	health = 2500
	maxHealth = 2500
	damage_coeff = list(BURN = 1, BRAIN = 1.3, BRUTE = 0.6, TOX = 1)
	fear_level = WAW_LEVEL
	can_breach = TRUE
	ego_list = list(
		/datum/ego_datum/weapon/rimeshank,
		/datum/ego_datum/armor/rimeshank,
	)
	gift_type =  /datum/ego_gifts/rimeshank

	observation_prompt = "You're freezing to death, the chill bites deep, down to the marrow in your bones. <br>\
		Through the blizzard, you spy lights leading your way. <br>They're contained in skulls of various creatures, human and animal. <br>\
		Seeing little recourse, you follow them to a palace made of ice, surrounded by a fence made out of various bones. <br>\
		The palace stands on the precipice of life and death. <br>You know this palace and who it belongs to. <br>\
		A terrifying witch lives here."


	var/jump_cooldown = 0
	var/jump_cooldown_time = 35 SECONDS
	var/list/spawned_mobs = list()
	update_qliphoth_chance = 40

//Work Procs
/mob/living/simple_animal/hostile/abnormality/babayaga/PostWorkEffect(mob/living/carbon/human/user)
	. = ..()
	if(user.health < (user.maxHealth - 30))
		qliphoth_change(-1)
		SpawnMobs()

// Breach Procs
/mob/living/simple_animal/hostile/abnormality/babayaga/Life()
	. = ..()
	if(IsContained()) // Contained
		return
	if(.)
		if(client)
			return
		if(jump_cooldown <= world.time)
			INVOKE_ASYNC(src, PROC_REF(TryJump))
		return

/mob/living/simple_animal/hostile/abnormality/babayaga/BreachEffect(mob/living/carbon/human/user)//copied my code from crumbling armor
	. = ..()
	icon_state = icon_aggro
	pixel_x = -16
	base_pixel_x = -16
	update_icon()
	desc = "A giant house stomping around on an equally large chicken leg."
	TryJump()

/mob/living/simple_animal/hostile/abnormality/babayaga/CanAttack(atom/the_target)
	return FALSE

/mob/living/simple_animal/hostile/abnormality/babayaga/Move()
	return FALSE

/mob/living/simple_animal/hostile/abnormality/babayaga/death(gibbed)
	for(var/mob/living/A in spawned_mobs)
		A.death()
	..()

//Attack procs
/mob/living/simple_animal/hostile/abnormality/babayaga/proc/TryJump(atom/target)
	if(jump_cooldown >= world.time)
		return
	jump_cooldown = world.time + jump_cooldown_time //We reset the cooldown later if there are no targets
	SLEEP_CHECK_DEATH(0.1 SECONDS, src)
	var/list/potentialmarked = list()
	var/list/marked = list()
	var/mob/living/carbon/human/Y
	for(var/mob/living/carbon/human/L in GLOB.alive_player_list)
		if(faction_check_atom(L, FALSE) || L.stat >= HARD_CRIT || L.sanity_lost || z != L.z) // Dead or in hard crit, insane, or on a different Z level.
			continue
		potentialmarked += L
	var/numbermarked = 1 + round(LAZYLEN(potentialmarked) / 5, 1) //1 + 1 in 5 potential players, to the nearest whole number
	for(var/i = numbermarked, i>=1, i--)
		if(potentialmarked.len <= 0)
			break
		Y = pick(potentialmarked)
		potentialmarked -= Y
		if(Y.stat == DEAD)
			continue
		marked+=Y
	if(marked.len <= 0) //Oh no, everyone's dead!
		jump_cooldown = world.time
		return
	var/mob/living/carbon/human/final_target = pick(marked)
	final_target.apply_status_effect(STATUS_EFFECT_BABAYAGA)
	playsound(get_turf(final_target), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/babayaga/warning.ogg', 30, FALSE)
	SLEEP_CHECK_DEATH(5 SECONDS, src)
	JumpAttack(final_target)

/mob/living/simple_animal/hostile/abnormality/babayaga/proc/JumpAttack(atom/target)
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/babayaga/charge.ogg', 100, 1)
	pixel_z = 128
	alpha = 0
	density = FALSE
	var/turf/target_turf = get_turf(target)
	forceMove(target_turf) //look out, someone is rushing you!
	new /obj/effect/temp_visual/giantwarning(target_turf)
	SLEEP_CHECK_DEATH(10 SECONDS, src)
	animate(src, pixel_z = 0, alpha = 255, time = 10)
	SLEEP_CHECK_DEATH(10, src)
	density = TRUE
	visible_message(span_danger("[src] drops down from the ceiling!"))
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/babayaga/land.ogg', 100, FALSE, 20)
	var/obj/effect/temp_visual/decoy/D = new(get_turf(src), src)
	animate(D, alpha = 0, transform = matrix()*2, time = 5)
	for(var/turf/open/T in view(3, src))
		new /obj/effect/temp_visual/ice_turf(T)
	for(var/turf/open/T in view(8, src))
		new /obj/effect/temp_visual/small_smoke/halfsecond(T)
		if(prob(20))
			new /obj/effect/temp_visual/ice_spikes(T)

	for(var/mob/living/L in view(8, src))
		if(faction_check_atom(L, TRUE)) //so it doesn't kill its own minions
			continue
		var/dist = get_dist(src, L)
		if(ishuman(L)) //Different damage formulae for humans vs mobs
			L.apply_damage(clamp((15 * (2 ** (8 - dist))), 15, 4000), BRUTE) //15-3840 damage scaling exponentially with distance
		else
			L.apply_damage(600 - ((dist > 2 ? dist : 0 )* 75), BRUTE) //0-600 damage scaling on distance, we don't want it oneshotting mobs
		if(L.health < 0)
			L.gib(DROP_ALL_REMAINS)
	SLEEP_CHECK_DEATH(5, src)
	SpawnMobs()

/mob/living/simple_animal/hostile/abnormality/babayaga/proc/SpawnMobs()
	for(var/turf/T in orange(1, src))
		if(spawned_mobs.len > 10)
			for(var/mob/living/A in spawned_mobs) //if there are too many spawned mobs, thin out the numbers a bit
				if(prob(30))
					A.death()
		new /obj/effect/temp_visual/dir_setting/cult/phase
		if(prob(30))
			var/mob/living/simple_animal/hostile/yagaslave/Y = new(T)
			spawned_mobs+=Y
	return

// Misc Objects and effects
/mob/living/simple_animal/hostile/yagaslave
	name = "frozen slave"
	desc = "A humanoid figure encased in ice, the pickaxe they're holding looks sharp."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	icon_state = "yagaslave"
	icon_living = "yagaslave"
	faction = list("hostile", "babayaga")
	health = 300
	maxHealth = 300
	melee_damage_type = BRUTE
	damage_coeff = list(BURN = 1, BRAIN = 1.3, BRUTE = 0.6, TOX = 1, BRUTE = 2)
	melee_damage_lower = 15
	melee_damage_upper = 27
	robust_searching = TRUE
	stat_attack = HARD_CRIT
	del_on_death = TRUE
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/babayaga/attack.ogg'
	speak_emote = list("whispers")

/obj/effect/temp_visual/giantwarning
	name = "giant warning"
	desc = "GET OUT OF THE WAY!"
	icon = 'icons/effects/96x96.dmi'
	icon_state = "warning"
	pixel_x = -32
	base_pixel_x = -32
	pixel_y = -32
	base_pixel_y = -32
	randomdir = FALSE
	duration = 10 SECONDS
	layer = ABOVE_ALL_MOB_LAYER	//We want this HIGH. SUPER HIGH. We want it so that you can absolutely, guaranteed, see exactly what hit you

/obj/effect/temp_visual/ice_spikes
	name = "ice spikes"
	desc = "Spikey."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/effects.dmi'
	icon_state = "winter_attack"
	randomdir = FALSE
	duration = 1 SECONDS
	layer = ABOVE_ALL_MOB_LAYER	//We want this HIGH. SUPER HIGH. We want it so that you can absolutely, guaranteed, see exactly what hit you

/obj/effect/temp_visual/ice_turf
	name = "snow"
	desc = "A patch of snow."
	icon = 'icons/turf/floors.dmi'
	icon_state = "floor"
	duration = 5 SECONDS
	layer = MID_TURF_LAYER
	anchored = TRUE

/obj/effect/temp_visual/ice_turf/Initialize()
	. = ..()
	Transform()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered)
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/effect/temp_visual/ice_turf/proc/Transform()
	icon = 'icons/turf/snow.dmi'
	if(prob(15))
		icon_state = "ice"
		name = "ice"
		desc = "A patch of slippery ice."
		return
	icon_state = "snow[rand(0,6)]"

/obj/effect/temp_visual/ice_turf/proc/on_entered(datum/source, atom/movable/AM)
	if(!ishuman(AM))
		return
	var/mob/living/carbon/human/H = AM
	BumpEffect(H)

/obj/effect/temp_visual/ice_turf/proc/BumpEffect(mob/living/carbon/human/H)
	if(icon_state == "ice")
		if(prob(25))
			to_chat(H, span_warning("You slip on the ice!"))
			H.slip(0, null, SLIDE_ICE, 0, FALSE)
			H.Immobilize(0.5 SECONDS)

// Status Effect
/datum/status_effect/babayaga
	id = "babayaga"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 5 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/babayaga

/atom/movable/screen/alert/status_effect/babayaga
	name = "Baba Yaga is coming!"
	desc = "If you do not escape in time, you will be crushed, dying instantly."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/status_sprites.dmi'
	icon_state = "babayaga"

#undef STATUS_EFFECT_BABAYAGA
