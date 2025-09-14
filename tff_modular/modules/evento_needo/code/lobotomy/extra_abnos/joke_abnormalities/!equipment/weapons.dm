//All ZAYIN joke E.G.O

// All TETH joke E.G.O
/obj/item/ego_weapon/an_ego
	name = "an ego"
	desc = "A weapon that can be used to attack things. Unfortunately, it is missing textures because you failed to install Counter-Strike : Source."
	special = "Use this weapon in hand to perform an ability."
	icon_state = "an_ego"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/joke_abnos/joke_weapons.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/joke_abnos/joke_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/joke_abnos/joke_righthand.dmi'
	force = 22
	damtype = BRUTE
	attack_verb_continuous = list("attacks", "attacks", "attacks")
	attack_verb_simple = list("attack", "attack", "attack")
	var/random_sound_list = list( // Random goofy sounds
		'tff_modular/modules/evento_needo/sounds/Tegusounds/yem.ogg',
		'tff_modular/modules/evento_needo/sounds/Tegusounds/wow.ogg',
		'sound/effects/gong.ogg',
		'sound/effects/adminhelp.ogg',
		'sound/effects/meow1.ogg',
		'tff_modular/modules/evento_needo/sounds/Tegusounds/meltdownAlert.ogg',
		'sound/effects/pray.ogg',
		'tff_modular/modules/evento_needo/sounds/Tegusounds/sanity_lost.ogg',
		'tff_modular/modules/evento_needo/sounds/Tegusounds/tremorburst.ogg',
	)

/obj/item/ego_weapon/an_ego/attack_self(mob/user)
	if(do_after(user, 12, src))
		playsound(get_turf(user), "[pick(random_sound_list)]", 50, TRUE)

// All HE joke E.G.O

// All WAW joke E.G.O
/obj/item/ego_weapon/pro_skub
	name = "pro-skub"
	desc = "A battle-sign powered by ferverent love for one's skub."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/joke_abnos/joke_weapons.dmi'
	icon_state = "pro_skub"
	force = 50
	reach = 2
	stuntime = 3
	damtype = BRUTE
	attack_verb_continuous = list("pokes", "jabs", "tears", "lacerates", "gores")
	attack_verb_simple = list("poke", "jab", "tear", "lacerate", "gore")
	hitsound = "swing_hit"


// All ALEPH joke E.G.O
//The Chaos Dunk
/obj/item/ego_weapon/chaosdunk
	name = "chaos dunk"
	desc = "One billion b-balls dribbling simultaneously throughout the galaxy. \
	One trillion b-balls being slam dunked through a hoop throughout the cosmos. \
	I can feel every single b-ball that has ever existed at my fingertips, I can feel their collective knowledge channeling through my veins. \
	Every jumpshot, every rebound and three-pointer, every layup, dunk, and free throw. I am there. I Am B-Ball. \
	Though I have reforged the Ultimate B-Ball, there is something I must still do. There is... another basketball that cries out for an owner. \
	No, not an owner. A companion. I must find this b-ball, save it from the depths of obscurity that it so fears."
	special = "This weapon deals incredible damage when thrown."
	icon_state = "basketball"
	inhand_icon_state = "basketball"
	icon = 'icons/obj/toys/balls.dmi'
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	force = 30 // It attacks very fast but is rather weak
	attack_speed = CLICK_CD_RAPID
	throwforce = 90
	throw_speed = 1
	throw_range = 10
	damtype = BRUTE
	hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/fixer/generic/gen1.ogg'
	var/activated = FALSE
	var/list/random_colors = list(
		"red" = "#FF0000",
		"blue" = "#00FF00",
		"green" = "#0000FF",
		"yellow" = "#FFFF00",
		"cyan" = "#00FFFF",
		"purple" = "#FF00FF"
	)

/obj/item/ego_weapon/chaosdunk/Initialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	addtimer(CALLBACK(src, PROC_REF(ChangeColors)), 5) //Call ourselves every 0.5 seconds to change color
	set_light(4, 3, "#FFFF00") //Range of 4, brightness of 3 - Same range as a flashlight
	filters += filter(type="drop_shadow", x=0, y=0, size=5, offset=2, color=rgb(158, 4, 163))
	filters += filter(type="drop_shadow", x=0, y=0, size=5, offset=2, color=rgb(27, 255, 6))

/obj/item/ego_weapon/chaosdunk/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(activated)
		return
	if(!CanUseEgo(user))
		to_chat(user, span_warning("The [src] lies dormant in your hands..."))
		return
	activated = TRUE

/obj/item/ego_weapon/chaosdunk/proc/ChangeColors()
	set waitfor = FALSE
	animate(src, color = pick(random_colors), time=5)
	var/f1 = filters[filters.len]
	animate(f1,offset = rand(1,5),size = rand(1,20),alpha=200,time=5)
	sleep(5)
	update_icon()
	ChangeColors()

/obj/item/ego_weapon/chaosdunk/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	if(!activated)
		return
	if((ishuman(hit_atom)))
		var/mob/living/carbon/M = hit_atom
		M.apply_damage(10, STAMINA)
		if(prob(75))
			M.Paralyze(60)
			visible_message(span_danger("[M] barely manages to contain the power of the [src]!"))
			return
	else
		new /obj/effect/temp_visual/explosion(get_turf(src))
		visible_message(span_danger("[src] explodes violently!"))
		playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/crying_children/sorrow_shot.ogg', 45, FALSE, 5)
		for(var/mob/living/L in view(1, src))
			var/aoe = 50
			L.apply_damage(aoe, BRUTE, null, L.run_armor_check(null, BRUTE), spread_damage = TRUE)
			new /obj/effect/temp_visual/small_smoke/halfsecond(get_turf(L))
	activated = FALSE

// Curse of Violet Noon be upon thee
/obj/item/ego_weapon/violet_curse //Ignore the name dream maker doesn't handle the font well.
	name = "ᓵ⚍∷ᓭᒷ 𝙹⎓ ⍊╎𝙹ꖎᒷℸ ̣  リ𝙹𝙹リ"
	desc = "We tried to understand what would refuse to listen. \
	We reached for a shred of comprehension that they could give. \
	We stared into the dark unending abyss wishing for love and compassion. \
	In the end we recived nothing but madness, there was no hope for understanding."
	special = "This weapon can be used to perform an indiscriminate heavy red damage jump attack with enough charge. \
	This weapon will also gib on kill."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/joke_abnos/joke_weapons.dmi'
	icon_state = "violet_curse"
	lefthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/96x96_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/96x96_righthand.dmi'
	inhand_x_dimension = 96
	inhand_y_dimension = 96
	force = 140
	attack_speed = 7
	damtype = BRUTE
	hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/apocalypse/slam.ogg'
	attack_verb_continuous = list("crushes", "devastates")
	attack_verb_simple = list("crush", "devastate")

	charge = TRUE
	charge_cost = 20
	charge_effect = "Can be used to perform an indiscriminate heavy red damage jump attack."
	successfull_activation = "You feel the power of the violet noon flow through you."

	var/dash_range = 8
	var/aoe_damage = 400

/obj/item/ego_weapon/violet_curse/Initialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/ego_weapon/violet_curse/attack(mob/living/target, mob/living/user)
	if(!CanUseEgo(user))
		return

	. = ..()

	if(charge >= charge_cost)
		icon_state = "violet_curse_c"
		inhand_icon_state = "violet_curse_c"
		update_icon_state()

	if(target.stat == DEAD)
		target.gib()

/obj/item/ego_weapon/violet_curse/afterattack(atom/A, mob/living/user, proximity_flag, params)
	if(!CanUseEgo(user))
		return
	if(!currently_charging)
		return
	if(!isliving(A))
		return
	if((get_dist(user, A) < 2) || (!(can_see(user, A, dash_range))))
		return
	..()
	if(do_after(user, 5, src))
		var/turf/target = get_turf(A)
		currently_charging = FALSE
		playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/violet/midnight_portal_off.ogg', 50, FALSE, -1)
		animate(user, alpha = 1,pixel_x = 0, pixel_z = 16, time = 0.1 SECONDS)
		user.pixel_z = 16
		ADD_TRAIT(src, TRAIT_NODROP, STICKY_NODROP)
		user.forceMove(target)
		user.Stun(2 SECONDS, ignore_canstun = TRUE) //No Moving midair
		var/obj/effect/temp_visual/warning3x3/W = new(target)
		W.color = "#8700ff"
		//sleep(2 SECONDS)
		REMOVE_TRAIT(src, TRAIT_NODROP, STICKY_NODROP)
		JumpAttack(target,user)
		animate(user, alpha = 255,pixel_x = 0, pixel_z = -16, time = 0.1 SECONDS)
		user.pixel_z = 0
		icon_state = "violet_curse"
		inhand_icon_state = "violet_curse"
		update_icon_state()

/obj/item/ego_weapon/violet_curse/proc/JumpAttack(target, mob/living/user, proximity_flag, params)
	playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/violet/monolith_down.ogg', 65, 1)
	var/obj/effect/temp_visual/v_noon/V = new(target)
	animate(V, alpha = 0, transform = matrix()*2, time = 10)
	for(var/turf/open/T in view(2, target))
		new /obj/effect/temp_visual/small_smoke/halfsecond(T)
	for(var/mob/living/L in range(2, target))
		if(L.z != user.z)
			continue
		if(L == user) //This WILL friendly fire there is no escape
			continue
		L.apply_damage(aoe_damage, BRUTE, null, L.run_armor_check(null, BRUTE), spread_damage = TRUE)
		to_chat(L, span_userdanger("You are crushed by a monolith!"))
		if(L.health < 0)
			L.gib()
		aoe_damage = initial(aoe_damage)

//Buff Rudolta
/obj/item/ego_weapon/ultimate_christmas
	name = "ultimate christmas"
	desc = "The Santa's bag is very heavy, capable of carrying a gift for everyone in the world. This one is no exception."
	icon_state = "ultimate_christmas"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/joke_abnos/joke_weapons.dmi'
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	force = 160
	attack_speed = 6.5
	damtype = BRUTE
	knockback = KNOCKBACK_HEAVY
	attack_verb_continuous = list("bashes", "clubs")
	attack_verb_simple = list("bashes", "clubs")
	hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/rudolta_buff/onrush1.ogg'

//Sukuna
/obj/item/ego_weapon/sukuna
	name = "Sukuna's Cursed Technique"
	desc = "Ah yes, my asspull technique from the Heian Era."
	icon_state = "1"
	icon = 'icons/effects/magic.dmi'
	force = 230
	attack_speed = CLICK_CD_RAPID
	damtype = BRUTE
	attack_verb_continuous = list("cleaves", "dismantles")
	attack_verb_simple = list("cleave", "dismantle")
	hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/black_silence/longsword_fin.ogg'
	var/ranged_cooldown
	var/ranged_cooldown_time = 0.5 SECONDS
	var/shrine_cooldown = 40 SECONDS

/obj/item/ego_weapon/sukuna/afterattack(atom/A, mob/living/user, proximity_flag, params)
	if(ranged_cooldown > world.time)
		return
	if(!CanUseEgo(user))
		return
	var/turf/target_turf = get_turf(A)
	if(!istype(target_turf))
		return
	if((get_dist(user, target_turf) < 2) || (get_dist(user, target_turf) > 15))
		return
	..()
	ranged_cooldown = world.time + ranged_cooldown_time
	playsound(target_turf, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/fastcleave.ogg', 50, TRUE)
	for(var/turf/open/T in range(target_turf, 0))
		new /obj/effect/temp_visual/nt_goodbye(T)
		user.HurtInTurf(T, list(), force, BRUTE)

/obj/item/ego_weapon/sukuna/attack_self(mob/living/carbon/user)
	to_chat(user,"<span class='notice'>Domain Expansion: Malevolent Shrine.</span>")
	if(do_after(user, 4 SECONDS, src))
		if(shrine_cooldown >= world.time)
			to_chat(user,"<span class='notice'>You can't do a domain expansion yet.</span>")
			return
		var/obj/effect/malevolent_shrine_IFF/THESHRINE = new(get_turf(user))
		THESHRINE.creator = user
		shrine_cooldown = world.time + (10 SECONDS)

/obj/effect/malevolent_shrine_IFF/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(explode)), 0.5 SECONDS)

/obj/effect/malevolent_shrine_IFF
	gender = PLURAL
	name = "Malevolent Shrine"
	desc = "Woe, death be upon ye."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/effects.dmi'
	icon_state = "malevolent"
	anchored = TRUE
	density = FALSE
	var/mob/living/carbon/human/creator
	var/explode_times = 35
	var/range = -1

/obj/effect/malevolent_shrine_IFF/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(explode)), 0.5 SECONDS)

/obj/effect/malevolent_shrine_IFF/proc/explode() //repurposed code from artillary bees, a delayed attack
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/strongcleave.mp3', 50, 0, 8)
	range = clamp(range + 1, 0, 10)
	var/turf/target_turf = get_turf(src)
	for(var/turf/T in view(range, target_turf))
		var/obj/effect/temp_visual/cleavesprite =  new(T)
		cleavesprite.color = "#df1919"
		creator.HurtInTurf(T, list(), damage = 500, damage_type = BRUTE, def_zone = null, check_faction = TRUE, exact_faction_match = FALSE, hurt_mechs = TRUE, mech_damage = 1000, hurt_hidden = FALSE, hurt_structure = FALSE, break_not_destroy = FALSE, attack_direction = null)
	explode_times -= 1
	if(explode_times <= 0)
		qdel(src)
		return
	sleep(0.4 SECONDS)
	explode()

//The wild ride
/obj/item/ego_weapon/lance/wild_ride
	name = "wild ride"
	desc = "I want off this wild ride!"
	icon_state = "tattered_kingdom" //temporary until someone decides to sprite it
	lefthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/96x96_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/96x96_righthand.dmi'
	inhand_x_dimension = 96
	inhand_y_dimension = 96
	force = 70
	reach = 2		//Has 2 Square Reach.
	attack_speed = 7 // really slow
	damtype = BRUTE
	attack_verb_continuous = list("pierces", "skews")
	attack_verb_simple = list("pierce", "skew")
	hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/fixer/generic/spear2.ogg'
	charge_speed_cap = 8 //Charges significantly faster, but teleports back upon hitting something
	force_per_tile = 4
	pierce_force_cost = 15
	var/turf/saved_location = null

/obj/item/ego_weapon/lance/wild_ride/LowerLance(mob/user)
	. = ..()
	saved_location = get_turf(src)

/obj/item/ego_weapon/lance/wild_ride/RaiseLance(mob/user)
	. = ..()
	saved_location = null

/obj/item/ego_weapon/lance/wild_ride/UserBump(mob/living/carbon/human/user, atom/A)
	. = ..()
	LanceInteraction(user)

/obj/item/ego_weapon/lance/wild_ride/proc/LanceInteraction(mob/living/carbon/human/user)
	if(saved_location)
		user.forceMove(saved_location)

/obj/item/ego_weapon/lance/wild_ride/get_clamped_volume()
	return 40
