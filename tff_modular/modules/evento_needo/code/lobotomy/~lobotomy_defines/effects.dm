//LC13 EFFECTS

/obj/effect/temp_visual/bee_gas
	icon_state = "mustard"
	alpha = 0
	duration = 50

/obj/effect/temp_visual/bee_gas/Initialize()
	. = ..()
	animate(src, alpha = rand(125,200), time = 5)
	addtimer(CALLBACK(src, PROC_REF(fade_out)), 5)

/obj/effect/temp_visual/bee_gas/proc/fade_out()
	animate(src, alpha = 0, time = duration-5)

// White colored sparkles. Just modify color variable as needed
/obj/effect/temp_visual/sparkles
	icon_state = "sparkles"
	duration = 10

/obj/effect/temp_visual/sparkles/red
	color = COLOR_RED

/obj/effect/temp_visual/sparkles/purple
	color = COLOR_PURPLE

/obj/effect/temp_visual/sparkles/sanity_heal
	color = "#42f2f5"
	duration = 2

/obj/effect/temp_visual/judgement
	icon_state = "judge"
	duration = 20

/obj/effect/temp_visual/judgement/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(fade_out)), 10)

/obj/effect/temp_visual/judgement/proc/fade_out()
	animate(src, alpha = 0, time = duration-10)

/obj/effect/temp_visual/judgement/still
	icon_state = "judge_still"
	duration = 20

/obj/effect/temp_visual/whitelake
	icon_state = "whitelake"
	duration = 20

/obj/effect/temp_visual/thirteen
	icon_state = "thirteen"
	duration = 20

/obj/effect/temp_visual/paradise_attack
	icon_state = "paradise_attack"
	duration = 10

/obj/effect/temp_visual/paradise_attack/Initialize()
	. = ..()
	animate(src, alpha = 0, time = duration)

/obj/effect/temp_visual/water_waves
	name = "ocean"
	icon = 'icons/turf/floors.dmi'
	icon_state = "riverwater_motion"
	layer = ABOVE_ALL_MOB_LAYER
	density = TRUE
	duration = 18 SECONDS
	alpha = 0

/obj/effect/temp_visual/water_waves/Initialize()
	. = ..()
	animate(src, alpha = 255, time = 10)
	addtimer(CALLBACK(src, PROC_REF(fade_out)), 10 SECONDS)

/obj/effect/temp_visual/water_waves/proc/fade_out()
	animate(src, alpha = 0, time = (duration - 10 SECONDS))

/obj/effect/temp_visual/justitia_effect
	name = "slash"
	icon_state = "bluestream"
	duration = 5

/obj/effect/temp_visual/justitia_effect/Initialize()
	. = ..()
	animate(src, alpha = 0, transform = transform*2, time = 5)

/obj/effect/temp_visual/fragment_song
	name = "sound waves"
	icon_state = "fragment_song"
	duration = 5
	pixel_y = 16
	base_pixel_y = 16

/obj/effect/temp_visual/fragment_song/Initialize()
	. = ..()
	animate(src, alpha = 0, transform = transform*3, time = 5)


/obj/effect/temp_visual/cherry_aura
	name = "petal blizzard"
	icon_state = "cherry_aura"
	duration = 16

/obj/effect/temp_visual/cherry_aura2
	name = "petal blizzard2"
	icon_state = "cherry_aura2"
	duration = 16

/obj/effect/temp_visual/cherry_aura3
	name = "petal blizzard3"
	icon_state = "cherry_aura3"
	duration = 16
/obj/effect/temp_visual/saw_effect
	name = "saw"
	icon_state = "claw"
	duration = 4

/obj/effect/temp_visual/smash_effect
	name = "smash"
	icon_state = "smash"
	duration = 4

/obj/effect/temp_visual/green_noon_reload
	name = "recharging field"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x48.dmi'
	icon_state = "green_bot_reload_effect"
	layer = BELOW_MOB_LAYER
	pixel_x = -8
	base_pixel_x = -8
	duration = 8

/obj/effect/temp_visual/green_noon_reload/Initialize()
	. = ..()
	animate(src, alpha = 0, transform = transform*1.5, time = duration)

/obj/effect/temp_visual/slice
	name = "slice"
	icon_state = "slice"
	duration = 4

/obj/effect/temp_visual/mech_fire
	name = "mech_fire"
	icon_state = "mech_fire"
	duration = 4

/obj/effect/temp_visual/dir_setting/slash
	name = "slash"
	icon_state = "slash"
	duration = 4

/obj/effect/temp_visual/hatred
	name = "hatred"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegu_effects.dmi'
	icon_state = "hatred"
	duration = 3 SECONDS

/obj/effect/temp_visual/hatred/Initialize()
	. = ..()
	pixel_x = rand(-16, 16)
	animate(src, alpha = 0, pixel_z = rand(16, 48), time = duration)

/obj/effect/temp_visual/flesh
	name = "flesh"
	icon = 'icons/turf/floors.dmi'
	icon_state = "flesh0"
	layer = ABOVE_ALL_MOB_LAYER
	density = TRUE
	duration = 8 SECONDS
	alpha = 0

/obj/effect/temp_visual/flesh/Initialize()
	. = ..()
	icon_state = "flesh[rand(0,3)]"
	animate(src, alpha = 255, time = 5)
	addtimer(CALLBACK(src, PROC_REF(fade_out)), 4 SECONDS)

/obj/effect/temp_visual/flesh/proc/fade_out()
	animate(src, alpha = 0, time = (duration - 4 SECONDS))

/obj/effect/temp_visual/black_fixer_ability
	name = "pulse"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegu_effects.dmi'
	icon_state = "black_fixer"
	pixel_y = 30
	base_pixel_y = 30
	duration = 4
	alpha = 175

/obj/effect/temp_visual/black_fixer_ability/Initialize()
	. = ..()
	animate(src, alpha = 0, transform = transform*4, time = 4)

/obj/effect/temp_visual/censored
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/128x128.dmi'
	icon_state = "censored_kill"
	layer = ABOVE_ALL_MOB_LAYER
	duration = 20
	alpha = 0
	pixel_x = -48
	base_pixel_x = -48
	pixel_y = -48
	base_pixel_y = -48

/obj/effect/temp_visual/censored/Initialize()
	. = ..()
	animate(src, alpha = 255, time = 2)
	addtimer(CALLBACK(src, PROC_REF(fade_out)), 17)
	for(var/i = 1 to 9)
		addtimer(CALLBACK(src, PROC_REF(shake)), 2*i)

/obj/effect/temp_visual/censored/proc/shake()
	animate(src, pixel_x = base_pixel_x + rand(-4, 4), pixel_y = base_pixel_y + rand(-4, 4), time = 1)

/obj/effect/temp_visual/censored/proc/fade_out()
	animate(src, alpha = 0, time = 2)

/obj/effect/temp_visual/beakbite
	name = "bite"
	icon_state = "bite"
	color = COLOR_RED

/obj/effect/temp_visual/apocaspiral
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/224x128.dmi'
	name = "apocaspiral"
	icon_state = "apocalypse_enchant_effect"
	layer = ABOVE_ALL_MOB_LAYER

/obj/effect/temp_visual/cross
	name = "holy cross"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x64_effects.dmi'
	icon_state = "cross"
	duration = 2 SECONDS

/obj/effect/temp_visual/cross/fall
	icon_state = "cross_fall"
	duration = 8 SECONDS

/obj/effect/temp_visual/cross/fall/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(FadeOut)), 6 SECONDS)

/obj/effect/temp_visual/cross/fall/proc/FadeOut()
	animate(src, alpha = 0, time = 2 SECONDS)

/obj/effect/temp_visual/markedfordeath
	name = "marked"
	icon_state = "markdeath"
	duration = 13

/obj/effect/temp_visual/mermaid_drowning
	name = "lovely drowning"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegu_effects.dmi'
	icon_state = "mermaid_drowning"
	duration = 0.5 SECONDS

/obj/effect/temp_visual/mermaid_drowning/Initialize()
	. = ..()
	animate(src, alpha = 0, pixel_y = pixel_y + 5 , time = duration)

/obj/effect/temp_visual/alriune_attack
	name = "petals"
	icon_state = "alriune_attack"
	duration = 6

/obj/effect/temp_visual/alriune_curtain
	name = "flower curtain"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegu_effects.dmi'
	icon_state = "alriune_curtain"
	duration = 2 SECONDS

/obj/effect/temp_visual/alriune_curtain/Initialize()
	. = ..()
	animate(src, alpha = 255, time = 5)
	addtimer(CALLBACK(src, PROC_REF(FadeOut)), 5)

/obj/effect/temp_visual/alriune_curtain/proc/FadeOut()
	animate(src, alpha = 0, time = 15)

/obj/effect/temp_visual/tbirdlightning
	name = "emp pulse"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x96.dmi'
	icon_state = "lightning"
	duration = 8
	randomdir = 0
	pixel_y = 0
	pixel_x = -16

/obj/effect/temp_visual/crit
	icon_state = "critical"
	layer = ABOVE_ALL_MOB_LAYER
	duration = 15

/obj/effect/temp_visual/healing
	icon_state = "healing"
	layer = ABOVE_ALL_MOB_LAYER
	duration = 8

/obj/effect/temp_visual/healing/Initialize(mapload)
	. = ..()
	pixel_x = rand(-12, 12)
	pixel_y = rand(-9, 0)

/obj/effect/temp_visual/healing/no_dam
	icon_state = "no_dam"

/obj/effect/temp_visual/pale_eye_attack
	name = "pale particles"
	icon_state = "ion_fade_flight"
	duration = 5

/obj/effect/temp_visual/pale_eye_attack/Initialize()
	. = ..()
	animate(src, alpha = 0, time = 5)

/obj/effect/temp_visual/screech
	name = "sound waves"
	icon_state = "screech"
	duration = 5

/obj/effect/temp_visual/screech/Initialize()
	. = ..()
	animate(src, alpha = 0, transform = transform*4, time = 5)

/obj/effect/temp_visual/human_fire
	name = "fire"
	icon = 'icons/mob/effects/onfire.dmi'
	icon_state = "human_big_fire"
	duration = 30

/obj/effect/temp_visual/fire
	name = "fire"
	icon = 'icons/effects/fire.dmi'
	icon_state = "1"

/obj/effect/temp_visual/fire/Initialize()
	. = ..()
	icon_state = pick("1", "2", "3")

/obj/effect/temp_visual/cloud_swirl
	name = "cloud_swirl"
	icon = 'icons/effects/eldritch.dmi'
	icon_state = "cloud_swirl"
	duration = 10

/obj/effect/temp_visual/nt_goodbye
	name = "goodbye"
	icon_state = "nt_goodbye"
	duration = 5

/obj/effect/temp_visual/talisman
	name = "talisman"
	icon_state = "talisman"
	layer = ABOVE_ALL_MOB_LAYER
	duration = 10

/obj/effect/temp_visual/talisman/Initialize()
	. = ..()
	animate(src, alpha = 0, time = 10)

/obj/effect/temp_visual/talisman/curse
	icon_state = "curse_talisman"

/obj/effect/temp_visual/turn_book
	name = "scattered pages"
	icon_state = "turn_book"
	duration = 6

/obj/effect/temp_visual/lovetown_shapes
	name = "shapes"
	icon_state = "lovetown_shapes"
	duration = 4

/obj/effect/temp_visual/lovetown_whip
	name = "whip"
	icon_state = "lovetown_whip"
	duration = 4

/obj/effect/temp_visual/galaxy_aura
	name = "galaxy_aura"
	icon_state = "galaxy_aura"
	duration = 6

/obj/effect/temp_visual/human_horizontal_bisect
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/mob.dmi'
	icon_state = "Hbisected-h"
	duration = 15

/obj/effect/temp_visual/rip_space
	name = "dimensional rift"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "rift"
	duration = 2

/obj/effect/temp_visual/ripped_space
	name = "ripped space"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "ripped_space"
	duration = 3

/obj/effect/temp_visual/rip_space_slash
	name = "ripped space"
	icon_state = "rift"
	duration = 2

/obj/effect/temp_visual/rip_space_slash/Initialize()
	. = ..()
	var/matrix/M = matrix()
	transform = M.Turn(45)
	transform = M.Scale(5, 0.5)
	transform = M.Turn(rand(0, 360))
	animate(src, alpha = 0, transform = transform*2, time = 2)

/obj/effect/temp_visual/mustardgas
	icon_state = "mustard"
	duration = 5

/obj/effect/temp_visual/smash_effect/red
	color = COLOR_RED

/obj/effect/temp_visual/house
	name = "home"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/96x96.dmi'
	icon_state = "House"
	duration = 4 SECONDS
	pixel_x = -34
	pixel_z = 128

/obj/effect/temp_visual/house/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(FadeOut)), 2 SECONDS)

/obj/effect/temp_visual/house/FadeOut()
	animate(src, alpha = 0, time = 1 SECONDS)

/obj/effect/temp_visual/v_noon
	name = "violet noon"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x64.dmi'
	icon_state = "violet_noon_ability"
	pixel_x = -8

/obj/effect/temp_visual/blubbering_smash
	name = "blubbering smash"
	icon_state = "blubbering_smash"
	duration = 5

/obj/effect/temp_visual/onesin_punishment
	name = "heavenly punishment"
	icon_state = "onesin_punishment"
	duration = 6

/obj/effect/temp_visual/onesin_blessing
	name = "heavenly blessing"
	icon_state = "onesin_blessing"
	duration = 12

/obj/effect/temp_visual/distortedform_shift
	name = "shift"
	icon_state = "shift"
	duration = 3

/obj/effect/temp_visual/warning3x3
	name = "warning3x3"
	icon = 'icons/effects/96x96.dmi'
	icon_state = "warning_gray"
	duration = 2 SECONDS
	pixel_x = -32
	pixel_z = -32

/obj/effect/temp_visual/nobody_grab
	name = "goodbye"
	icon_state = "nobody_slash"
	duration = 5

/obj/effect/temp_visual/goatjo
	name = "worldslash"
	icon_state = "goatjo"
	duration = 5

/obj/effect/temp_visual/cleavesprite
	name = "cleave"
	icon_state = "cleavesprite"
	duration = 5

/obj/effect/temp_visual/holo_command
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/lc13icons.dmi'
	light_range = 1.5
	light_power = 0.2
	duration = 150 		//15 Seconds

/obj/effect/temp_visual/holo_command/command_move
	icon_state = "Move_here_wagie"
	light_range = 1
	light_power = 1
	light_color = COLOR_VERY_LIGHT_GRAY

/obj/effect/temp_visual/holo_command/command_warn
	icon_state = "Watch_out_wagie"
	light_color = COLOR_PALE_RED_GRAY

/obj/effect/temp_visual/holo_command/command_guard
	icon_state = "Guard_this_wagie"
	light_color = COLOR_VERY_SOFT_YELLOW

/obj/effect/temp_visual/holo_command/command_heal
	icon_state = "Heal_this_wagie"
	light_color = COLOR_VERY_PALE_LIME_GREEN

/obj/effect/temp_visual/holo_command/command_fight_a
	icon_state = "Fight_this_wagie1"
	light_color = COLOR_PALE_BLUE_GRAY

/obj/effect/temp_visual/holo_command/command_fight_b
	icon_state = "Fight_this_wagie2"
	light_color = COLOR_PALE_BLUE_GRAY

/obj/effect/temp_visual/execute_bullet
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/manager_bullets.dmi'
	icon_state = "execution"
	duration = 10


/obj/effect/temp_visual/remorse
	name = "remorse nail"
	desc = "A target warning you of incoming pain"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/effects.dmi'
	icon_state = "remorse"
	randomdir = FALSE
	duration = 2 SECONDS
	layer = ABOVE_OBJ_LAYER	//We want this HIGH. SUPER HIGH. We want it so that you can absolutely, guaranteed, see exactly what hit you

//Small visuals used for indicating damage or healing or similar
/obj/effect/temp_visual/healing
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/lc13_coloreffect.dmi'
	icon_state = "healing"
	layer = ABOVE_ALL_MOB_LAYER
	//duration based on the frames in the sprites.
	duration = 8

/obj/effect/temp_visual/healing/Initialize(mapload)
	. = ..()
	pixel_x = rand(-12, 12)
	pixel_y = rand(-9, 0)

/obj/effect/temp_visual/healing/no_dam
	icon_state = "no_dam"

/obj/effect/temp_visual/healing/charge
	icon_state = "charge"

/obj/effect/temp_visual/damage_effect
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/lc13_coloreffect.dmi'
	layer = ABOVE_ALL_MOB_LAYER
	//Icon state is actually the base icon for intilization

/obj/effect/temp_visual/damage_effect/Initialize(mapload)
	icon_state = "[icon_state][rand(1,2)]"
	pixel_x = rand(-12, 12)
	pixel_y = rand(-9, 9)
	return ..()

/obj/effect/temp_visual/damage_effect/red
	icon_state = "dam_red"

/obj/effect/temp_visual/damage_effect/white
	icon_state = "dam_white"

/obj/effect/temp_visual/damage_effect/black
	icon_state = "dam_black"

/obj/effect/temp_visual/damage_effect/pale
	icon_state = "dam_pale"

/obj/effect/temp_visual/damage_effect/burn
	icon_state = "dam_burn"

/obj/effect/temp_visual/damage_effect/tox
	icon_state = "dam_tox"

/obj/effect/temp_visual/damage_effect/bleed
	icon_state = "dam_bleed"

/obj/effect/temp_visual/damage_effect/tremor
	icon_state = "tremor"

/obj/effect/temp_visual/damage_effect/sinking
	icon_state = "sinking"

/obj/effect/temp_visual/damage_effect/rupture
	icon_state = "rupture"

//Stuntime visual for when you're stunned by your weapon, so you know what happened.
/obj/effect/temp_visual/weapon_stun
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/lc13_coloreffect.dmi'
	icon_state = "stun"
	layer = ABOVE_ALL_MOB_LAYER
	duration = 9

/obj/effect/temp_visual/weapon_stun/tremorburst
	icon_state = "tremorburst"

/obj/effect/temp_visual/area_heal
	name = "large healing aura"
	desc = "A large area of restorative energy."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/lc13_effects64x64.dmi'
	icon_state = "healarea_fade"
	duration = 15
	pixel_x = -16
	base_pixel_x = -16
	pixel_y = -16
	base_pixel_y = -16
	density = FALSE
	anchored = TRUE
	layer = BELOW_MOB_LAYER
	alpha = 200
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/temp_visual/swipe
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/96x96.dmi'
	duration = 4
	randomdir = FALSE
	alpha = 200

/obj/effect/temp_visual/swipe/New(loc, ...)
	. = ..()
	setDir(args[2])
	if(args[3])
		color = args[3]
	flick(args[4], src) // if this isn't used, it synchronizes all swipe animations.

/obj/effect/temp_visual/thrust
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x32.dmi'
	duration = 4
	randomdir = FALSE
	pixel_x = -16
	alpha = 200

/obj/effect/temp_visual/thrust/New(loc, ...)
	. = ..()
	if(args[2])
		color = args[2]
	flick("thrust", src)




//PARTICLES


/particles/white_night
	width = 1200
	height = 1200
	count = 2500
	spawning = 500
	lifespan = 2 SECONDS
	fade = 1 SECONDS
	position = generator("circle", 42, 54, NORMAL_RAND)
	velocity = generator("circle", -4, 4, NORMAL_RAND)
	friction = 0.15
	gradient = list(0, COLOR_ORANGE, 0.75, COLOR_RED)
	color_change = 1
	drift = generator("vector", list(-0.1, -0.1), list(0.1, 0.1))

/particles/fragment_note
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegu_effects.dmi'
	icon_state = "fragment_note"
	width = 96
	height = 96
	count = 30
	spawning = 1
	lifespan = 6
	fade = 2
	velocity = generator("circle", 10, 15)
	friction = 0.25

/particles/fragment_song
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegu_effects.dmi'
	icon_state = list("fragment_song_small","fragment_song_medium","fragment_song_large")
	width = 128
	height = 128
	count = 30
	spawning = 2
	lifespan = 12
	fadein = 6
	fade = 6
	velocity = generator("circle", -5, 5, NORMAL_RAND)
	rotation = generator("num", -120, 120)
	spin = generator("num", -20, 20)
	grow = list(0.2,0.2)
	friction = 0.6



/obj/effect/temp_visual/small_smoke/fixer_w
	name = "mental smoke"

/obj/effect/temp_visual/small_smoke/second
	duration = 10

/obj/effect/temp_visual/small_smoke/second/fruit
	color = LIGHT_COLOR_PURPLE

/obj/effect/temp_visual/small_smoke/halfsecond/green
	color = COLOR_GREEN



/obj/particle_emitter
	name = ""
	anchored = TRUE
	mouse_opacity = 0
	appearance_flags = PIXEL_SCALE

/obj/particle_emitter/Initialize(mapload, time, _color)
	. = ..()
	if(time > 0)
		QDEL_IN(src, time)
	color = _color

/obj/particle_emitter/proc/enable(on)
	if(on)
		particles.spawning = initial(particles.spawning)
	else
		particles.spawning = 0

/obj/particle_emitter/proc/fadeout()
	enable(FALSE)
	if(istype(particles))
		QDEL_IN(src, initial(particles.lifespan))
	else
		QDEL_NULL(src)

/obj/particle_emitter/fragment_note
	layer = MOB_LAYER+1
	particles = new/particles/fragment_note

/obj/particle_emitter/fragment_song
	layer = MOB_LAYER+1
	particles = new/particles/fragment_song


/particles/fragment_note
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegu_effects.dmi'
	icon_state = "fragment_note"
	width = 96
	height = 96
	count = 30
	spawning = 1
	lifespan = 6
	fade = 2
	velocity = generator("circle", 10, 15)
	friction = 0.25

/particles/fragment_song
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegu_effects.dmi'
	icon_state = list("fragment_song_small","fragment_song_medium","fragment_song_large")
	width = 128
	height = 128
	count = 30
	spawning = 2
	lifespan = 12
	fadein = 6
	fade = 6
	velocity = generator("circle", -5, 5, NORMAL_RAND)
	rotation = generator("num", -120, 120)
	spin = generator("num", -20, 20)
	grow = list(0.2,0.2)
	friction = 0.6
