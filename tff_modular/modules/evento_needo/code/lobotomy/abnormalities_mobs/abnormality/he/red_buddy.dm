/mob/living/simple_animal/hostile/abnormality/red_buddy
	name = "Reddened Buddy"
	desc = "A small whimpering dog like creature."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x48.dmi'
	icon_state = "redbuddy"
	icon_living = "redbuddy"
	icon_dead = "redbuddy_dead"
	del_on_death = FALSE
	pixel_x = -8
	base_pixel_x = -8
	maxHealth = 2200 //Tanky but hurts itself every now and then to make up for it
	health = 2200
	move_to_delay = 5
	stop_automated_movement_when_pulled = TRUE
	rapid_melee = 1
	del_on_death = FALSE
	move_resist = MOVE_FORCE_NORMAL + 1 //Can't be pulled by humans, but can be pulled by shepherd this might have other unforeseen consequences
	fear_level = HE_LEVEL

	damage_coeff = list(BURN = 0.8, BRAIN = 0.5, BRUTE = 1.5, TOX = 1.5)
	melee_damage_lower = 35
	melee_damage_upper = 70 //has a wide range, he can critically hit you
	melee_damage_type = BRUTE
	stat_attack = HARD_CRIT
	attack_verb_continuous = "chomps"
	attack_verb_simple = "claws"
	faction = list("blueshep")
	attack_sound = 'sound/items/weapons/bite.ogg'
	can_breach = TRUE
	fear_level = HE_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/totalitarianism,
		/datum/ego_datum/armor/totalitarianism,
	)
	gift_type = /datum/ego_gifts/totalitarianism
	grouped_abnos = list(
		/mob/living/simple_animal/hostile/abnormality/blue_shepherd = 5,
	)

	observation_prompt = "You enter the containment unit and see a cartoonish-looking dog collapsed in the centre, shivering from pain and inflicted with terribly deep, red wounds. <br>\
		\"My master wants a wolf...\" <br>It says breathlessly. <br>\"I'm waiting for my master, waiting, waiting... <br>I'm waiting for them...\""


	///The blue smocked shepherd linked to red buddy
	var/datum/abnormality/master
	//the living shepherd it is currently fighting with
	var/mob/living/simple_animal/hostile/abnormality/blue_shepherd/awakened_master
	///How "hurt" buddy is, which affects his work damage
	var/suffering = 0
	///the timer id linked to shepherd's lie
	var/lying_timer = FALSE
	///if shepherd has lied in the past minute
	var/lying
	///if red buddy has seen shepherd or not
	var/awakened = FALSE
	///cooldown related to his howling
	var/awoo_cooldown = 0
	///the time between each howling
	var/awoo_cooldown_time = 30 SECONDS
	///how much damage buddy has taken after it awakens
	var/accumulated_damage = 0
	///how many times buddy howled while awakened, is in decimals because of the equation it's used in
	var/awoo_count = 0.1

/mob/living/simple_animal/hostile/abnormality/red_buddy/Initialize()
	. = ..()
	if(LAZYLEN(SSlobotomy_corp.all_abnormality_datums))
		for(var/datum/abnormality/A in SSlobotomy_corp.all_abnormality_datums)
			if(A.name == "Blue Smocked Shepherd")
				master = A
				return
	if(!master)
		RegisterSignal(SSdcs, COMSIG_GLOB_ABNORMALITY_SPAWN, PROC_REF(OnAbnoSpawn)) //if shepherd isn't here yet, buddy will wait for him like a good dog

/mob/living/simple_animal/hostile/abnormality/red_buddy/proc/OnAbnoSpawn(datum/source, datum/abnormality/abno)
	SIGNAL_HANDLER
	if(abno.name == "Blue Smocked Shepherd")
		master = abno
		UnregisterSignal(SSdcs, COMSIG_GLOB_ABNORMALITY_SPAWN)

/mob/living/simple_animal/hostile/abnormality/red_buddy/NeutralEffect(mob/living/carbon/human/user, work_type, pe)
	. = ..()
	if(user.get_major_clothing_class() == CLOTHING_ENGINEERING)
		return
	AdjustSuffering(3)
	return

/mob/living/simple_animal/hostile/abnormality/red_buddy/FailureEffect(mob/living/carbon/human/user)
	if(user.get_major_clothing_class() == CLOTHING_ENGINEERING)
		return
	qliphoth_change(-1)
	AdjustSuffering(10)
	return

/mob/living/simple_animal/hostile/abnormality/red_buddy/PostWorkEffect(mob/living/carbon/human/user)
	AdjustSuffering(10)
	UpdateScars()
	switch(user.get_major_clothing_class())
		if(CLOTHING_ENGINEERING)
			suffering = 0
		if(CLOTHING_ARMORED)
			AdjustSuffering(10) //my brother in christ you are literally beating the dog up
	if(datum_reference?.qliphoth_meter > 0)
		UpdateScars()
	if(suffering >= 20)
		qliphoth_change(-1)

	if(lying)
		user.Apply_Gift(new gift_type)
		lying = FALSE
	return

/mob/living/simple_animal/hostile/abnormality/red_buddy/try_working(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	if(lying_timer)
		qliphoth_change(1)
		deltimer(lying_timer)
	return TRUE

//makes buddy scarred if his suffering is high enough
/mob/living/simple_animal/hostile/abnormality/red_buddy/proc/UpdateScars()
	if(!IsContained()) //I don't know how you're working on the dog while he's breached but stop
		return
	if(suffering >= 20)
		icon_state = "redbuddy_scratched"
	else
		icon_state = "redbuddy"

/mob/living/simple_animal/hostile/abnormality/red_buddy/Life()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_GODMODE))
		return
	if(awoo_cooldown <= world.time && !awakened)
		Awoo()
	var/mob/living/master_abno = master?.current
	if(!master_abno)
		return
	if(HAS_TRAIT(master_abno, TRAIT_GODMODE)) //no reason to look for shepherd if he's not out
		return

	if(can_see(src, master_abno, 10) && !awakened)
		maxHealth = maxHealth * 3 //6600 HP, a LOT but gets hurt by shepherd's slash a metric ton to counter act it
		set_health(health * 3)
		awakened = TRUE
		awakened_master = master_abno
		var/turf/orgin = get_turf(awakened_master)
		var/list/all_turfs = RANGE_TURFS(1, orgin)
		var/turf/open/Y = pick(all_turfs - orgin)
		forceMove(Y) //the lazy solution that forces buddy to get pulled by shepherd, ideally this should only happen once.
		//awakened_master.start_pulling(src)
		awakened_master.awakened_buddy = src
		med_hud_set_health()
		med_hud_set_status()
		update_health_hud()
		awoo_cooldown_time = 15 SECONDS //awoo now only triggers when buddy takes 10% of their health instead of every X seconds but still has a min cooldown
		awoo_cooldown = 0 //resets the awoo cooldown too
		melee_damage_lower = 60
		melee_damage_upper = 80
		move_to_delay = 1 //this doesn't matter as much as you'd think because he can't move before shepherd
		vision_range = 3
		aggro_vision_range = 3 //red buddy should only move for things it can actually reach, in this case somewhat within shepherd's reach
		wander = FALSE //just in case

///we're doing a bunch of checks for diagonal movement because it acts real weird with forced dragging
/mob/living/simple_animal/hostile/abnormality/red_buddy/Move(atom/newloc)
	if(!awakened_master || (moving_diagonally && !target))
		return ..()

	if(!awakened_master.Adjacent(newloc) && !awakened_master.moving_diagonally)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/abnormality/red_buddy/BreachEffect()
	. = ..()
	deltimer(lying_timer)
	icon_state = "redbuddy_active"

///basically a stronger fragment song that hurts red buddy, it's slower hitting than fragment however
/mob/living/simple_animal/hostile/abnormality/red_buddy/proc/Awoo(abused = FALSE)
	awoo_cooldown = world.time + awoo_cooldown_time
	var/mob/living/simple_animal/hostile/abnormality/blue_shepherd/shepherd = master?.current
	if(shepherd)
		if(HAS_TRAIT(shepherd, TRAIT_GODMODE))
			shepherd.hired = TRUE //it's more likely for them to run into each other this way
			shepherd.qliphoth_change(-1) //shepherd doesn't breach instantly but it's only a matter of time
	playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/redbuddy/redbuddy_howl.ogg', 100, FALSE, 8)
	for(var/i = 1 to 4)
		addtimer(CALLBACK(src, PROC_REF(AwooDamage), abused), 1 SECONDS * (i))

/mob/living/simple_animal/hostile/abnormality/red_buddy/proc/AwooDamage(abused = FALSE)
	var/heard_awoo = FALSE //red buddy is only hurt by his howl if someone hears it
	for(var/mob/living/L in view(7, src))
		if(faction_check_atom(L, FALSE) && L != awakened_master) //it can't hurt other pink midnight abnos but can still hurt his master
			continue
		if(L.stat == DEAD)
			continue
		if(L == awakened_master)
			awakened_master.adjustHealth(150) //800 damage in total, takes approximatively 8 howls to take shepherd down
		L.apply_damage(10, BRUTE)
		heard_awoo = TRUE
	if(health >= 75 && heard_awoo && !abused)
		adjustHealth(75)

/mob/living/simple_animal/hostile/abnormality/red_buddy/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(!awakened_master)
		return
	accumulated_damage += amount

	if(accumulated_damage >= (maxHealth * awoo_count) && awoo_cooldown <= world.time)
		awoo_count += 0.1 //this also mean you can get howling you "missed" during a cooldown
		Awoo(TRUE)

/mob/living/simple_animal/hostile/abnormality/red_buddy/proc/AdjustSuffering(pain)
	suffering = clamp(pain + suffering, 0, 50)

///triggers 90 seconds after shepherd tells a lie
/mob/living/simple_animal/hostile/abnormality/red_buddy/proc/ShepherdLying()
	qliphoth_change(-1)
	AdjustSuffering(5)
	lying = FALSE

/mob/living/simple_animal/hostile/abnormality/red_buddy/death(gibbed)
	if(awakened_master)
		awakened_master.melee_damage_lower = 10
		awakened_master.melee_damage_upper = 15
		awakened_master.slash_damage = 20
		awakened_master.move_to_delay = 0.8 //we severely nerf shepherd's damage but make him way faster on buddy's death, it's last one tango.
		awakened_master.say("A wolf. A wolf. Why won't you believe me? it's right there. IT WAS RIGHT THERE!")
	awakened_master = null
	density = FALSE
	animate(src, alpha = 0, time = 10 SECONDS)
	QDEL_IN(src, 10 SECONDS)
	UnregisterSignal(SSdcs, COMSIG_GLOB_ABNORMALITY_SPAWN)
	..()
