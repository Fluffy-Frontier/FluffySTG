#define STATUS_EFFECT_CHAMPION /datum/status_effect/champion
//White Lake from wonderlabs, by Kirie saito
//It's very buggy, and I can't test it alone
/mob/living/simple_animal/hostile/abnormality/whitelake
	name = "White Lake"
	desc = "A ballet dancer, absorbed in her work."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	icon_state = "white_lake"
	icon_living = "white_lake"
	maxHealth = 600
	health = 600
	fear_level = HE_LEVEL
	//Has the weapon been given out?
	var/sword = FALSE
	ego_list = list(
		/datum/ego_datum/weapon/wings,
		/datum/ego_datum/armor/wings,
	)
	gift_type = /datum/ego_gifts/waltz
	gift_chance = 0
	observation_prompt = "The feathered lady dances in the centre of the containment unit to a tempo that exists only in her world, it's elegant and precise. <br>\
		\"This domain, my lunar palace, it's mine birdcage gilded with fine gold. <br>Whatever I wish, it is brought for me and all that is expected of me is to dance. <br>\
		Even if I possessed the fortitude to bend these bars and free myself, I would not - what good comes from change? <br>Fortitude won't avail anyone, wouldn't you agree?\""


/mob/living/simple_animal/hostile/abnormality/whitelake/SuccessEffect(mob/living/carbon/human/user)
	if(user.get_clothing_class_level(CLOTHING_ENGINEERING) < 3)		//Right in the zone
		user.Apply_Gift(new gift_type)	//It's a gift now! Free shit! And there are absolutely, positively no downsides, nope!
		to_chat(user, span_nicegreen("A cute crown appears on your head!"))

/mob/living/simple_animal/hostile/abnormality/whitelake/FailureEffect(mob/living/carbon/human/user)
	qliphoth_change(-1)
	if(user.get_clothing_class_level(CLOTHING_ENGINEERING) >= 3)	//Lower it again.
		qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/whitelake/ZeroQliphoth(mob/living/carbon/human/user)
	qliphoth_change(3)
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(faction_check_atom(H, FALSE) || H.z != z || H.stat == DEAD)
			continue
		if(istype(H.ego_gift_list[HELMET], /datum/ego_gifts/waltz)) // You're still wearing the gift? Pitiable fool...
			TurnChampion(H)
			return
		BreachAttack(H)
	return

/mob/living/simple_animal/hostile/abnormality/whitelake/proc/BreachAttack(mob/living/carbon/human/H)
	set waitfor = FALSE
	new /obj/effect/temp_visual/whitelake(get_turf(H))
	var/userfort = H.get_clothing_class_level(CLOTHING_ENGINEERING)
	var/damage_dealt = clamp((0 + (userfort / 2)), 30, 65)//deals between 30 and 60 white damage depending on your fortitude attribute when applied.
	H.apply_damage(damage_dealt, BRUTE)

/mob/living/simple_animal/hostile/abnormality/whitelake/proc/TurnChampion(mob/living/carbon/human/H)
	H.apply_status_effect(STATUS_EFFECT_CHAMPION)
	if(!sword)
		waltz(H)
	//Replaces AI with murder one
	if(!H.sanity_lost)
		H.adjustSanityLoss(500)
	QDEL_NULL(H.ai_controller)
	H.ai_controller = /datum/ai_controller/insane/murder/whitelake
	H.InitializeAIController()

/mob/living/simple_animal/hostile/abnormality/whitelake/proc/waltz(mob/living/carbon/human/H)
	var/obj/item/held = H.get_active_held_item()
	var/obj/item/wep = new /obj/item/ego_weapon/flower_waltz(H)
	H.dropItemToGround(held) //Drop weapon
	RegisterSignal(H, COMSIG_LIVING_DEATH, PROC_REF(Champion_Death_Sword))
	ADD_TRAIT(wep, TRAIT_NODROP, wep)
	H.put_in_hands(wep) 		//Time for pale
	sword = TRUE

// If Champ dies, sword is droppable
/mob/living/simple_animal/hostile/abnormality/whitelake/proc/Champion_Death_Sword(mob/living/gibbed)
	var/obj/item/ego_weapon/flower_waltz/sword
	if (istype(gibbed.get_active_held_item(), /obj/item/ego_weapon/flower_waltz))
		sword = gibbed.get_active_held_item()
		REMOVE_TRAIT(sword, TRAIT_NODROP, src)
	if (istype(gibbed.get_inactive_held_item(), /obj/item/ego_weapon/flower_waltz))
		sword = gibbed.get_inactive_held_item()
		REMOVE_TRAIT(sword, TRAIT_NODROP, src)
	UnregisterSignal(gibbed, COMSIG_LIVING_DEATH)

//Outfit and Attacker's sword.
/datum/outfit/whitelake
	head = /obj/item/clothing/head/ego_gift/whitelake

/obj/item/clothing/head/ego_gift/whitelake
	name = "waltz of the flowers"
	icon_state = "whitelake"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_gear/head.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/mob/ego_gear/head.dmi'

//WAW Class, you have to sacrifice someone for it
/obj/item/ego_weapon/flower_waltz
	name = "waltz of the flowers"
	desc = "It's awfully fun to write a march for tin soldiers, a waltz of the flowers."
	special = "Cannot be dropped until moved from your hands. Twice as effective against monsters."
	icon_state = "flower_waltz"
	force = 22
	damtype = BRUTE
	attack_verb_continuous = list("slices", "cuts")
	attack_verb_simple = list("slices", "cuts")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	// The damage we add when attacking the nemesis faction (abnormalities)
	var/faction_bonus_force = 22
	// list of nemesis factions (things we deal bonus damage to)
	var/list/nemesis_factions = list("hostile")
	//No requirements because who knows who will use it.

// Sets the weapon to not be droppable until it's moved from the main hand. No more leg sweeping.
/obj/item/ego_weapon/flower_waltz/equipped(mob/user, slot, initial = FALSE)
	.=..()
	if (slot != ITEM_SLOT_HANDS)
		REMOVE_TRAIT(src, TRAIT_NODROP, src)

/obj/item/ego_weapon/flower_waltz/attack(mob/living/target, mob/living/carbon/human/user, proximity)
	var/enemy = FALSE
	for(var/found_faction in target.faction)
		if(found_faction in nemesis_factions) // if we are hitting a nemesis...
			force += faction_bonus_force
			enemy = TRUE
			break
	. = ..()
	if(enemy) // we should delete the extra force ONLY if we hit a nemesis
		force -= faction_bonus_force

//Slightly different AI lines
/datum/ai_controller/insane/murder/whitelake
	lines_type = /datum/ai_behavior/say_line/insanity_whitelake

/datum/ai_behavior/say_line/insanity_whitelake
	lines = list(
		"I will protect her!!",
		"You're in the way!",
		"I will dance with her forever!",
	)
//CHAMPION
//Sets the defenses of the champion
/datum/status_effect/champion
	id = "champion"
	status_type = STATUS_EFFECT_UNIQUE
	duration = -1
	alert_type = /atom/movable/screen/alert/status_effect/champion

/atom/movable/screen/alert/status_effect/champion
	name = "The Champion"
	desc = "You are White Lake's champion, and she has empowered you temporarily."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/status_sprites.dmi'
	icon_state = "champion"

/datum/status_effect/champion/on_apply()
	. = ..()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/status_holder = owner
	ADD_TRAIT(status_holder, TRAIT_STUNIMMUNE, type)
	ADD_TRAIT(status_holder, TRAIT_PUSHIMMUNE, type)
	status_holder.physiology.burn_mod *= 0.6
	status_holder.physiology.brain_mod *= 0.4
	status_holder.physiology.brute_mod *= 0.4
	status_holder.physiology.tox_mod *= 0.6

/datum/status_effect/champion/tick()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/status_holder = owner
	if(!status_holder.sanity_lost)
		status_holder.remove_status_effect(STATUS_EFFECT_CHAMPION)

/datum/status_effect/champion/on_remove()
	. = ..()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/status_holder = owner
	REMOVE_TRAIT(status_holder, TRAIT_STUNIMMUNE, type)
	REMOVE_TRAIT(status_holder, TRAIT_PUSHIMMUNE, type)
	status_holder.physiology.burn_mod /= 0.6
	status_holder.physiology.brain_mod /= 0.4
	status_holder.physiology.brute_mod /= 0.4
	status_holder.physiology.tox_mod /= 0.6

#undef STATUS_EFFECT_CHAMPION
