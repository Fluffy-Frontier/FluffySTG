#define JUMP_MESSAGE_NOSE "broke his nose"
#define JUMP_MESSAGE_HIT "hit self slightly"

/datum/keybinding/human/jump
	hotkey_keys = list("AltE")
	name = "jump"
	full_name = "jump"
	keybind_signal = COMSIG_KB_HUMAN_JUMP

/datum/keybinding/human/jump/down(client/user, turf/target)
	. = ..()
	if(.)
		return
	var/mob/living/carbon/human/H = user.mob
	H.try_jump(get_edge_target_turf(H, H.dir), H)
	return TRUE

/atom/proc/try_jump(atom/target, mob/living/carbon/human/user)
	if(!isliving(user) || !ishuman(user) || !user.has_gravity() || !user.Adjacent(user) || !(user.stat == CONSCIOUS) || user.body_position == LYING_DOWN || user.buckled) // ТЫ ЕБЛАН?
		return
	if(user.has_movespeed_modifier(/datum/movespeed_modifier/jump_slowdown))
		to_chat(user, "I'm not ready to jump yet!")
		return
	var/jump_message = prob(40) ? JUMP_MESSAGE_NOSE : JUMP_MESSAGE_HIT

	if(QDELETED(src) || QDELETED(user)) // ТЫ НЕ СУЩЕСТВУЕШЬ, ЕБЛИЩЕ.
		return

	for(var/obj/item/bodypart/leg/missing_limb as anything in user.get_missing_limbs())
		if(missing_limb in GLOB.leg_zones) // Проверка на ноги. Нехуй прыгать инвалидам.
			to_chat(user, span_notice("I have no legs!"))
			user.emote("cry") // НУ ЗАПЛАЧЬ.
			return

	if(user.legcuffed) // Если Ноги связаны (Болой к примеру)
		if(user.handcuffed) // А если ещё и руки.
			user.visible_message(span_alert("[user] had tried to jump while being tied, so [user.p_they()] fell and [jump_message]."))
			if(jump_message == JUMP_MESSAGE_NOSE) // Если зарандомил ломание носа.
				user.adjustStaminaLoss(30)
				user.Paralyze(30)
				user.adjustBruteLoss(30)
				user.AdjustUnconscious(10 SECONDS)
				user.emote("scream")
				return
			else // Повезло просто удариться.
				user.adjustStaminaLoss(20)
				user.adjustBruteLoss(10)
				user.Paralyze(10)
				return
		user.visible_message(span_alert("[user] tried to jump with [user.p_their()] feet tied."))
		user.adjustStaminaLoss(20)
		user.Paralyze(10)
		return

// Проверки на Пуллы
	if(user.pulledby)
		to_chat(user, span_warning("I can't jump while I'm being pulled."))
		return

	if(user.pulling)
		to_chat(user, span_warning("I can't jump while I'm pulling someone."))
		return
//

	if(user.staminaloss >= 60) // ПРЕДУПРЕЖДАЕМ ЧТО НЕКСТ ПРЫЖОК 100% БУДЕТ ЛЕЖАЧИМ.
		to_chat(user, span_warning("My legs really hurt..."))

	if(user.staminaloss >= 90) // ПЕРЕПРЫГАЛ? ПОЛУЧАЙ НАХУЙ ИНСУЛЬТ.
		to_chat(user, span_notice("Tired muscles are unable to lift your carcass into the air and you fall to the floor."))
		user.Paralyze(15)
		user.adjustStaminaLoss(10)

	if(!HAS_TRAIT(user, TRAIT_MIMING))
		playsound(user, user.gender == MALE ? 'tff_modular/modules/evento_needo/ark_station_stuff/now-we-can-jump/jump_male.ogg' : 'tff_modular/modules/evento_needo/ark_station_stuff/now-we-can-jump/jump_female.ogg', 25, 0, 1)
	user.visible_message("<span class='danger'>[user] jumps.</span>", \
					"<span class='warning'> I jump at the [loc]!</span>")
	user.adjustStaminaLoss(rand(30,50))
	user.throw_at(target, 3, 1, user, spin = (HAS_TRAIT(user, TRAIT_CLUMSY) ? TRUE : FALSE), force = MOVE_FORCE_EXTREMELY_WEAK, gentle = TRUE)
	if(prob(70))
		user.Knockdown(1 SECONDS)
	else
		user.add_movespeed_modifier(/datum/movespeed_modifier/jump_slowdown)
	addtimer(CALLBACK(user, TYPE_PROC_REF(/mob/living/carbon/human, remove_movespeed_modifier), /datum/movespeed_modifier/jump_slowdown), 1 SECONDS)

/datum/movespeed_modifier/jump_slowdown
	multiplicative_slowdown = 1.5


#undef JUMP_MESSAGE_NOSE
#undef JUMP_MESSAGE_HIT
