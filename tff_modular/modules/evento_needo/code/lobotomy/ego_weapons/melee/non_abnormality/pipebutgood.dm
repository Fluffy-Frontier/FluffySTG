/obj/item/ego_weapon/city/rats/truepipe
	name = "REAL pipe"
	desc = "Did you pray today?"
	icon_state = "ratpipe"
	force = 500
	attack_speed = 2
	damtype = BRUTE
	attack_verb_continuous = list("pipes", "smashes", "shatters", "bans")
	attack_verb_simple = list("pipe", "smash", "shatter", "ban")
	hitsound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/ego/pipesuffering.ogg'

/obj/item/ego_weapon/city/rats/truepipe/afterattack(mob/living/target, mob/living/carbon/human/user)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		H.unequip_everything()
		H.Stun(10)
	//sleep(10)
	playsound(get_turf(target), 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/ego/pipesuffering.ogg', 10, 0, 3)
	new /obj/effect/temp_visual/execute_bullet(get_turf(target))
	QDEL_IN(target, 1)
