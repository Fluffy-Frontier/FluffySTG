/mob/living/simple_animal/silent_girl
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x32.dmi'
	icon_state = "silent_girl"
	//silent_girl

/mob/living/simple_animal/hostile/little_slime
	maxHealth = 50
	health = 50
	melee_damage_lower = 6
	melee_damage_upper = 7
	name = "Маленький слизень"
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x32.dmi'
	icon_state = "little_slime"

/mob/living/simple_animal/hostile/big_slime
	maxHealth = 75
	health = 75
	melee_damage_lower = 8
	melee_damage_upper = 11
	name = "Большой слизень"
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/48x48.dmi'
	icon_state = "big_slime"
	base_pixel_x = -8
	pixel_x = -8

/mob/living/simple_animal/shadow
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x32.dmi'
	icon_state = "shadow"
	alpha = 80
	pass_flags = PASSCLOSEDTURF

/mob/living/simple_animal/bill
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x32.dmi'
	icon_state = "bill"

/mob/living/simple_animal/thunderzombie
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x32.dmi'
	icon_state = "thunder_zombie"
	//thunder_zombie_dead

/mob/living/simple_animal/thundezombie/b
	icon_state = "thunder_zombie2"

/mob/living/simple_animal/gcorp
	name = "Мёртвое тело"
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x32.dmi'
	icon_state = "gcorp1"
	//gcorp_corpse

/mob/living/simple_animal/lantern
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x32.dmi'
	icon_state = "lantern"

/mob/living/simple_animal/sweeper
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x32.dmi'
	icon_state = "sweeper_limbus"
	//sweeper_dead

/mob/living/simple_animal/sweeper/b
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x48.dmi'
	icon_state = "green_bot"
	//green_bot_b _c _dead

/mob/living/simple_animal/sweeper/c
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x48.dmi'
	icon_state = "indigo_dawn"
	//indigo_dawn_dead

/mob/living/simple_animal/sweeper/d
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x48.dmi'
	icon_state = "sweeper_limbus"
	//sweeper_dead

/mob/living/simple_animal/sweeper/mat
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x64.dmi'
	icon_state = "matriarch"
	//alot


/mob/living/simple_animal/scarecrow
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x48.dmi'
	icon_state = "scarecrow"
	//_breach _dead

/mob/living/simple_animal/dingledangler
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x48.dmi'
	icon_state = "dingledangler"

/mob/living/simple_animal/dearmeddoubt
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x48.dmi'
	icon_state = "dearmeddoubt"
	//dearmeddoubt_slain

/mob/living/simple_animal/pmermaid
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/48x32.dmi'
	icon_state = "pmermaid_standing"
	//pmermaid_laying  + SECOND PHASE
	//64x64

/mob/living/simple_animal/everything_there
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/48x32.dmi'
	icon_state = "everything_there"
	//_guard

/mob/living/simple_animal/hostile/crawling_beast
	name = "Дикая тварь"
	desc = "..."
	faction = list("field")
	maxHealth = 50
	health = 50
	melee_damage_lower = 9
	melee_damage_upper = 13
	sharpness = SHARP_EDGED
	wound_bonus = 20
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/48x32.dmi'
	icon_state = "crawling_beast"

/mob/living/simple_animal/hostile/ravenous_beast
	name = "Дикая тварь"
	desc = "..."
	faction = list("field")
	maxHealth = 50
	health = 50
	melee_damage_lower = 9
	melee_damage_upper = 13
	sharpness = SHARP_EDGED
	wound_bonus = 20
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/48x32.dmi'
	icon_state = "ravenous_beast"


/mob/living/simple_animal/hostile/redbuddy
	maxHealth = 150
	health = 150
	melee_damage_lower = 10
	melee_damage_upper = 15

	icon = 'tff_modular/modules/asdasvasdqwe/mobs/48x48.dmi'
	icon_state = "redbuddy_active"
	sharpness = SHARP_POINTY

	emote_taunt = list("barks", "barks loudly", "whines")

/mob/living/simple_animal/bunnyman
	maxHealth = 500
	health = 500
	melee_damage_lower = 20
	melee_damage_upper = 25
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/48x48.dmi'
	icon_state = "bunnyman"
	sharpness = SHARP_EDGED
	//_enraged

/mob/living/simple_animal/bunnyman/Initialize(mapload)
	. = ..()
	var/datum/action/innate/bunny_enrage/skill = new()
	skill.Grant(src)
	var/datum/action/innate/spooky_sound/spooky = new()
	spooky.Grant(src)
	var/datum/action/innate/toggle_hide/hide = new()
	hide.Grant(src)

/datum/action/innate/spooky_sound

/datum/action/innate/spooky_sound/Activate()
	. = ..()

	playsound(get_turf(owner), 'tff_modular/modules/asdasvasdqwe/sounds/rand/dragon-studio-scary-transition-401717.mp3', 60, FALSE)

/mob/living/simple_animal/eris
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/48x48.dmi'
	icon_state = "eris"

/mob/living/simple_animal/generalbee
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/48x48.dmi'
	icon_state = "generalbee"
	//punished_bee
	//48x96

/mob/living/simple_animal/hostile/workerbee
	name = "Дикая пчела"
	desc = "..."
	faction = list("bees")
	maxHealth = 80
	health = 80
	melee_damage_lower = 10
	melee_damage_upper = 15
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/48x64.dmi'
	icon_state = "worker_bee"

/mob/living/simple_animal/hostile/queenbee
	name = "Королева пчёл"
	desc = "В её челюсти виднеется связка ключей"
	faction = list("bees")
	maxHealth = 175
	health = 175
	melee_damage_lower = 15
	melee_damage_upper = 22
	loot = list(/obj/item/field_key)
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/48x64.dmi'
	icon_state = "queen_bee"

/mob/living/simple_animal/soldierbee
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/48x64.dmi'
	icon_state = "soldier_bee"

/mob/living/simple_animal/forest_portal
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/48x64.dmi'
	icon_state = "forest_portal"

/mob/living/simple_animal/luna
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/48x64.dmi'
	icon_state = "luna"

/mob/living/simple_animal/bloodbath
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/48x64.dmi'
	icon_state = "bloodbath_DF"
	//bloodbath_slam

/mob/living/simple_animal/bloodbath
	name = "???"
	desc = "БЕГИ"
	health = 2000
	maxHealth = 2000
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/48x64.dmi'
	icon_state = "bloodbath_DF"
	//bloodbath_slam

/mob/living/carbon/human/proc/swap_skin(mob/me)
	var/mob/living/carbon/human/copied = new(pick(SSjob.sublocations[clamp(client.death_count, 1, 6)]))
	client?.prefs?.apply_prefs_to(copied)
	copied.equipOutfit(copy_outfit())
	addmrak()
	addtimer(CALLBACK(src, PROC_REF(swap_skin_end), me, copied), 1.5 SECONDS)

/mob/living/carbon/human/proc/swap_skin_end(mob/me, mob/copied)
	mind.transfer_to(copied)
	removemrak()
	me.mind.transfer_to(src)

	var/datum/action/innate/become_skinswap/bue = new()
	bue.Grant(src)

/datum/action/innate/become_skinswap

/datum/action/innate/become_skinswap/Activate()
	. = ..()

	var/mob/living/player = owner

	var/mob/living/simple_animal/bloodbath/boba = new(player.loc)

	player.gib()



/mob/living/simple_animal/bloodbath/Initialize(mapload)
	. = ..()
	var/datum/action/innate/toggle_hide/hide = new()
	hide.Grant(src)
	var/datum/action/innate/spooky_sound/spooky = new()
	spooky.Grant(src)

/mob/living/simple_animal/bloodbath/attack_basic_mob(mob/user, list/modifiers)
	. = ..()

	flick("bloodbath_slam", src)


/mob/living/simple_animal/lost_mind
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/48x64.dmi'
	icon_state = "lost_mind"

/mob/living/simple_animal/witchfriend
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/48x64.dmi'
	icon_state = "witchfriend"
	//_dead

/mob/living/simple_animal/crimsondusk
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x64.dmi'
	icon_state = "crimson_dusk"
	//_roll _dead

/mob/living/simple_animal/crimsonmidnight
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x64.dmi'
	icon_state = "crimson_midnight"

/mob/living/simple_animal/mosb
	name = "БЕГИ"
	desc = "!!!"
	health = 500
	maxHealth = 500
	speed = 1.5
	melee_damage_lower = 200
	melee_damage_upper = 250
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/96x96.dmi'
	icon_state = "mosb_breach2"

/mob/living/simple_animal/mosb/Initialize(mapload)
	. = ..()

	add_movespeed_modifier(/datum/movespeed_modifier/settler)

/mob/living/simple_animal/mosb/attack_animal(mob/living/simple_animal/user, list/modifiers)
	. = ..()
	flick("mosb_bite2", src)

/mob/living/simple_animal/woodsman
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x64.dmi'
	icon_state = "woodsman"
	//_breach _prepare

/mob/living/simple_animal/bungal
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x96.dmi'
	icon_state = "Bungal_breach"
	//64x96

/mob/living/simple_animal/jangsan
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x64.dmi'
	icon_state = "jangsan"
	//_bite _idle

/mob/living/simple_animal/nosferatu
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x64.dmi'
	icon_state = "nosferatu_breach"

/mob/living/simple_animal/hostile/apex
	name = "БЕЗУМЕЦ"
	desc = "..."
	faction = list("field")
	maxHealth = 500
	health = 500
	melee_damage_lower = 20
	melee_damage_upper = 30
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x64.dmi'
	icon_state = "apex_old"

/mob/living/simple_animal/hostile/apex/Initialize(mapload)
	. = ..()
	var/datum/action/innate/spooky_sound/spooky = new()
	spooky.Grant(src)
	var/datum/action/innate/toggle_hide/hide = new()
	hide.Grant(src)

/mob/living/simple_animal/hostile/apex_b
	name = "=)"
	desc = "=)=)=)=)=)=)=)=)=)=)=)=)"
	maxHealth = 150
	health = 150
	melee_damage_lower = 10
	melee_damage_upper = 20
	wound_bonus = 25
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x64.dmi'
	icon_state = "apex"
	pixel_x = -16
	//_crouch _leap

/mob/living/simple_animal/hostile/apex_b/attack_basic_mob(mob/user, list/modifiers)
	. = ..()
	flick("apex_leap", src)

/mob/living/simple_animal/highway_devotee
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x64.dmi'
	icon_state = "highway_devotee"

/mob/living/simple_animal/wrath
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x64.dmi'
	icon_state = "wrathsin"
	//_dead

/mob/living/simple_animal/nosferatu_gas
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x64.dmi'
	icon_state = "nosferatu_evade"

/mob/living/simple_animal/hostile/spider_violet
	name = "Паук"
	desc = "..."
	maxHealth = 90
	health = 90
	melee_damage_lower = 10
	melee_damage_upper = 15
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x64.dmi'
	icon_state = "spider_minion"

/mob/living/simple_animal/hostile/merm
	name = "Живые останки рыбы"
	desc = "..."
	faction = list("fis")
	maxHealth = 75
	health = 75
	melee_damage_lower = 8
	melee_damage_upper = 14
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x64.dmi'
	icon_state = "merm"
	//_open _tongue _dead

/mob/living/simple_animal/merm/Initialize(mapload)
	. = ..()
	playsound(get_turf(src), 'tff_modular/modules/asdasvasdqwe/sounds/alien_resin_move1.ogg', 60, TRUE)

/mob/living/simple_animal/hostile/scarymerm
	name = "Останки рыбы"
	desc = "..."
	faction = list("fishy")
	maxHealth = 50
	health = 50
	melee_damage_lower = 10
	melee_damage_upper = 17
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x64.dmi'
	icon_state = "scarymerm"
	//_open _dead

/mob/living/simple_animal/scarymerm/Initialize(mapload)
	. = ..()
	playsound(get_turf(src), 'tff_modular/modules/asdasvasdqwe/sounds/alien_resin_move1.ogg', 60, TRUE)


/mob/living/simple_animal/nobody
	name = ""
	desc = "Громадная тварь без глаз..."
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x96.dmi'
	icon_state = "nobody"
	pixel_x = -16
	//_shell _grab _ranged

/mob/living/simple_animal/basilis
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/96x48.dmi'
	icon_state = "basilisoup"
	//_prepare

/mob/living/simple_animal/hostile/melting
	name = "Сгусток слизи"
	maxHealth = 175
	health = 175
	melee_damage_lower = 12
	melee_damage_upper = 15
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/96x96.dmi'
	icon_state = "melting_breach"
	pixel_x = -30
	base_pixel_x = -30

/mob/living/simple_animal/hostile/melting/Initialize(mapload)
	. = ..()
	var/datum/action/innate/spooky_sound/spooky = new()
	spooky.Grant(src)
	var/datum/action/innate/toggle_hide/hide = new()
	hide.Grant(src)


/mob/living/simple_animal/ishak
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/IT.dmi'
	icon_state = "palehorse_hungry"

/mob/living/simple_animal/hostile/talos
	name = "..."
	desc = "..."
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/tormentor.dmi'
	icon_state = "teaman"
	pixel_x = -120
	maxHealth = 1000
	health = 1000
	melee_damage_lower = 25
	melee_damage_upper = 50


/datum/action/innate/bunny_enrage


/datum/action/innate/bunny_enrage/Activate()
	. = ..()

	var/mob/parent = owner

	parent.icon_state = parent.icon_state == "bunnyman" ? "bunnyman_enraged" : "bunnyman"


/datum/action/innate/toggle_hide

/datum/action/innate/toggle_hide/Activate()
	. = ..()

	var/mob/parent = owner
	parent.alpha = parent.alpha == 0 ? 255 : 0
