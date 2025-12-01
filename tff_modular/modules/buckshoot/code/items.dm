/obj/structure/chair/buckshoot
	name = "buckshoot chair"
	desc = "A sturdy chair with integrated system of blood transfer and defibrilators."
	icon_state = "echair1"
	obj_flags = INDESTRUCTIBLE|BOMB_PROOF|LAVA_PROOF|FIRE_PROOF

	var/datum/buckshoot_roulette_party/party = null

/obj/structure/chair/buckshoot/buckle_mob(mob/living/M, force, check_loc)
	if(!party)
		return ..()
	if(party.game_started)
		to_chat(M, span_warning("Ты не можешь сесть на кресло после начала игры!"))
		return
	return ..()


/obj/structure/chair/buckshoot/unbuckle_mob(mob/living/buckled_mob, force, can_fall)
	if(!party)
		return ..()
	if(party.game_started && !party.can_free_exit)
		to_chat(buckled_mob, span_warning("Ты не можешь покинуть игру после начала! Нужно было лучше читать отказ от ответственности."))
		return
	return ..()


/obj/structure/chair/buckshoot/proc/register_player(datum/buckshoot_roulette_party/party_instance)
	var/mob/living/carbon/human/player = get_current_player()
	if(!player)
		return FALSE
	if(!party_instance)
		return FALSE
	player.AddComponent(/datum/component/buckshoot_roulette_participant, party_instance, src)
	return player


/obj/structure/chair/buckshoot/proc/revive_player()
	var/mob/living/carbon/human/player = get_current_player()
	if(!player)
		return
	if(!player.stat == DEAD)
		return
	playsound(src, 'tff_modular/modules/buckshoot/sounds/defib_discharge.ogg', 50, 1)
	sleep(1.5 SECONDS)
	player.notify_revival("Your heart is being defibrillated!")
	player.grab_ghost() // Возращаем призрака в тело

	player.revive(HEAL_DAMAGE)
	player.set_heartattack(FALSE)
	player.setOxyLoss(0)
	player.setToxLoss(0)
	player.remove_status_effect(/datum/status_effect/neck_slice)

	player.reagents.add_reagent(/datum/reagent/blood, 50, list(
		"blood_DNA" = player.dna.unique_enzymes,
		"blood_type" = player.dna.blood_type
	))

	player.emote("gasp")
	player.set_jitter_if_lower(10 SECONDS)
	player.flash_act()
	log_game("[key_name(player)] was forcibly revived by Buckshoot Roulette chair.")
	to_chat(player, span_userdanger("Your heart explodes back to life! You're back in the game!"))
	SEND_SOUND(player, 'tff_modular/modules/buckshoot/sounds/heartbeat_effect.ogg')


/obj/structure/chair/buckshoot/proc/get_current_player()
	if(!has_buckled_mobs())
		return null
	for(var/mob/living/buckled in buckled_mobs)
		if(!ishuman(buckled))
			return null
		return buckled
	return null


/obj/structure/table/buckshoot
	name = "buckshoot table"
	desc = "A sturdy table used in the game of buckshoot roulette."
	icon = 'icons/obj/smooth_structures/poker_table.dmi'
	icon_state = "poker_table-0"
	base_icon_state = "poker_table"

	obj_flags = INDESTRUCTIBLE|BOMB_PROOF|LAVA_PROOF|FIRE_PROOF
	var/datum/buckshoot_roulette_party/party = null

/obj/structure/table/buckshoot/Initialize(mapload, obj/structure/table_frame/frame_used, obj/item/stack/stack_used)
	. = ..()
	party = new(src)


/obj/structure/table/buckshoot/attack_hand_secondary(mob/user, list/modifiers)
	if(!party)
		return ..()
	if(!istype(user) || !user.can_interact_with(src))
		return ..()
	party.detect_candidates(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
