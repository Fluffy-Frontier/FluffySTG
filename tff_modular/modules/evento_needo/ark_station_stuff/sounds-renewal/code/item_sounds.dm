/obj/item/gun
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/gun_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/gun_drop.ogg'

/obj/item/flashlight
	sound_on = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/flashlight_on.ogg'
	sound_off = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/flashlight_off.ogg'

/obj/item/gun/ballistic/shotgun
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/shotgun_pickup.ogg'

/obj/item/gun/ballistic/shotgun/boltaction
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/rifle_pickup.ogg'

/obj/item/coin
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/coin_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/coin_drop.ogg'

/obj/item/knife
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/knife_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/knife_drop.ogg'

/obj/item/stack/rods
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/surgery1_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/metal_drop.ogg'

/obj/item/scalpel
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/surgery1_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/metal_drop.ogg'

/obj/item/retractor
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/surgery1_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/metal_drop.ogg'

/obj/item/hemostat
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/surgery1_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/metal_drop.ogg'

/obj/item/cautery
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/surgery1_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/metal_drop.ogg'

/obj/item/circular_saw
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/surgery1_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/metal_drop.ogg'

/obj/item/surgicaldrill
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/surgery1_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/metal_drop.ogg'

/obj/item/surgical_drapes
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/surgery2_pickup.ogg'

/obj/item/reagent_containers/cup
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/bottle_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/bottle_drop.ogg'

/obj/item/reagent_containers/cup/bottle
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/bottle_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/bottle_drop.ogg'

/obj/item/reagent_containers/cup/beaker
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/beaker_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/beaker_drop.ogg'

/obj/item/reagent_containers/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	playsound(src.loc, 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/watersplash.ogg', 40, 1)

/obj/item/shard/on_entered(datum/source, atom/movable/AM)
	if(isliving(AM))
		var/mob/living/L = AM
		if(!(L.movement_type & MOVETYPES_NOT_TOUCHING_GROUND) || L.buckled)
			playsound(src, 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/glass_step.ogg', HAS_TRAIT(L, TRAIT_LIGHT_STEP) ? 30 : 50, TRUE)
/*
/obj/item
	equip_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/generic/generic_equip1.ogg'
	// 	'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/generic/generic_equip2.ogg',
	// 	'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/generic/generic_equip3.ogg',
	// 	'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/generic/generic_equip4.ogg'
	// ))
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/generic/generic_pickup1.ogg'
	// 	'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/generic/generic_pickup2.ogg',
	// 	'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/generic/generic_pickup3.ogg'
	// ))
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/generic/generic_drop1.ogg'
	// 	'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/generic/generic_drop2.ogg',
	// 	'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/generic/generic_drop3.ogg',
	// 	'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/generic/generic_drop4.ogg',
	// 	'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/generic/generic_drop5.ogg'
	// ))
*/
/obj/item/clothing/shoes/jackboots
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/boots_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/boots_drop.ogg'

/obj/item/clothing/shoes/combat
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/boots_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/boots_drop.ogg'

/obj/item/clothing/shoes
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/shoes_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/shoes_drop.ogg'

/obj/item/storage/backpack
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/backpack_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/backpack_drop.ogg'
	//equip_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/backpack_equip.ogg'

/obj/item/storage/bag
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/backpack_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/backpack_drop.ogg'
	//equip_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/backpack_equip.ogg'

/obj/item/clothing/accessory
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/accessory_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/accessory_drop.ogg'

/obj/item/card
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/card_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/card_drop.ogg'

/obj/item/clothing/head/helmet
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/helmet_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/helmet_drop.ogg'

/obj/item/clothing/gloves/ring
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/ring_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/ring_drop.ogg'

/obj/item/storage/pill_bottle
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/pillbottle_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/pillbottle_drop.ogg'

/obj/item/phone
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/phone_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/phone_drop.ogg'

/obj/item/paper
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/dosh_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/dosh_drop.ogg'

/obj/item/clothing/glasses
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/glasses_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/glasses_drop.ogg'

/obj/item/tank
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/canistra_drop.ogg'

/obj/item/pen
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/pen_drop.ogg'

/obj/item/stack/sheet/iron
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/metal_list_drop.ogg'

/obj/item/stack/sheet/plasteel
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/metal_list_drop.ogg'

/obj/item/stack/sheet/mineral/wood
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/wooden_drop.ogg'

/obj/item/stack/sheet/glass
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/accessory_drop.ogg'

/obj/item/stack/sheet/plasmaglass
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/accessory_drop.ogg'

/obj/item/stack/sheet/titaniumglass
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/accessory_drop.ogg'

/obj/item/stack/medical/mesh
	operating_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/applyes/mesh.ogg'

/obj/item/stack/medical/suture
	operating_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/applyes/suture.ogg'

/obj/item/stack/medical/gauze
	operating_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/applyes/bandage.ogg'

/obj/item/radio
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/radio_drop.ogg'

/obj/item/radio/headset
	pickup_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/card_pickup.ogg'
	drop_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/items/card_drop.ogg'
