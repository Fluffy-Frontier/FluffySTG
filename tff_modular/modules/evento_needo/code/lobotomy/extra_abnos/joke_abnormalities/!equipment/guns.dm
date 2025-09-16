//Zayin
//The Mcrib
/obj/item/ego_weapon/ranged/pistol/mcrib
	name = "mcrib"
	desc = "Try a mcrib at your nearest McDonalds!"
	special = "Use this weapon in your hand when wearing matching armor to create food for people nearby."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/joke_abnos/joke_weapons.dmi'
	icon_state = "mcrib"
	force = 6
	projectile_path = /obj/projectile/ego_bullet/ego_mcrib
	burst_size = 1
	fire_delay = 10
	fire_sound = 'sound/effects/meatslap.ogg'
	var/ability_cooldown_time = 60 SECONDS
	var/ability_cooldown

/obj/item/ego_weapon/ranged/pistol/mcrib/attack_self(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(ability_cooldown > world.time)
		to_chat(H, "<span class='warning'>You have used this ability too recently!</span>")
		return
	var/obj/item/clothing/suit/armor/ego_gear/zayin/mcrib/T = H.get_item_by_slot(ITEM_SLOT_OCLOTHING)
	if(!istype(T))
		to_chat(H, "<span class='warning'>You must have the corrosponding armor equipped to use this ability!</span>")
		return
	to_chat(H, "<span class='warning'>You use mcrib to share snacks!</span>")
	H.playsound_local(get_turf(H), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/mcrib/mcrib.ogg', 25, 0)
	ability_cooldown = world.time + ability_cooldown_time

/obj/projectile/ego_bullet/ego_mcrib
	name = "mcrib"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "patty"
	damage = 10
	damage_type = BRUTE

/obj/item/ego_weapon/ranged/anti_skub
	name = "anti-skub"
	desc = "A weapon easily created from schematics posted on illicit internet forums."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/joke_abnos/joke_weapons.dmi'
	icon_state = "anti_skub"
	lefthand_file = 'icons/mob/inhands/items/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/food_righthand.dmi'
	inhand_icon_state = "beer"
	special = "This weapon deals AOE damage."
	force = 33
	attack_speed = CLICK_CD_MELEE
	damtype = BRUTE
	projectile_path = /obj/projectile/ego_bullet/skub
	weapon_weight = WEAPON_HEAVY
	fire_delay = 15
	fire_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/fixer/generic/dodge.ogg'


/obj/projectile/ego_bullet/skub
	name = "skub cocktail"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/joke_abnos/joke_weapons.dmi'
	icon_state = "anti_skub2"
	damage = 45
	damage_type = BRUTE
	BRUTE_DAMAGE
	hitsound = "shatter"

/obj/projectile/ego_bullet/skub/on_hit(atom/target, blocked = FALSE, pierce_hit)
	..()
	for(var/mob/living/L in view(1, target))
		new /obj/effect/temp_visual/fire/fast(get_turf(L))
		L.apply_damage(45, BRUTE, null, L.run_armor_check(null, BRUTE), spread_damage = TRUE)
	return BULLET_ACT_HIT
