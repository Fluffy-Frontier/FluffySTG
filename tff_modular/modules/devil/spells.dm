// Абилки контрактов
/datum/action/cooldown/spell/conjure_item/coins
	name = "Create Coins!"
	desc = "Create expensive coins! right from nothing!"
	button_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "moneybag"

	cooldown_time = 0.3 SECONDS
	spell_requirements = NONE
	invocation_type = NONE

	item_type = /obj/item/coin/diamond
	delete_old = FALSE
	delete_on_failure = FALSE

/datum/action/cooldown/spell/conjure_item/desert_eagle_ammo
	name = "Summon Ammo"
	desc = "Free ammo?"
	button_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "moneybag"
	cooldown_time = 120 SECONDS
	spell_requirements = NONE
	invocation_type = NONE
	delete_on_failure = FALSE
	delete_old = FALSE
	item_type = /obj/item/ammo_box/magazine/r10mm/devil

// Дезерт Игл с 7 патронами и большим уроном с зажиганием. Можно восполнить. При выстреле в дьявола, пуля проигнорирует его.
/obj/item/gun/ballistic/automatic/pistol/deagle/regal/devil
	name = "Eagle of the Devil"
	desc = "Unlike the Desert Eagle, this weapon seems to utilize some kind of advanced internal stabilization system to significantly \
		reduce felt recoil and increase overall accuracy, at the cost of using a smaller caliber. Uses 10mm ammo."
	projectile_damage_multiplier = 1
	accepted_magazine_type = /obj/item/ammo_box/magazine/r10mm/devil
	burst_size = 1

/obj/item/ammo_box/magazine/r10mm/devil
	max_ammo = 7
	ammo_type = /obj/item/ammo_casing/c10mm/reaper/devil

/obj/item/ammo_casing/c10mm/reaper/devil
	projectile_type = /obj/projectile/bullet/c10mm/reaper/devil

// Ты не можешь ваншотнуть дьявола дезерт иглом дьявола.
/obj/projectile/bullet/c10mm/reaper/devil/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	var/mob/living/carbon/human = target
	if(isliving(human))
		if(IS_DEVIL(human))
			return BULLET_ACT_FORCE_PIERCE
		else
			human.ignite_mob()
			human.set_fire_stacks(1)


// Абилки дьявола.
/datum/action/cooldown/spell/summonitem/devil
	invocation_type = NONE
