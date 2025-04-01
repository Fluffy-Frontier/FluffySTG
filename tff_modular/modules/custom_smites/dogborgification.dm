#define EQUIP_OUTFIT_ITEM(item_path, slot_name) if(##item_path) { \
	hypnodrone.equip_to_slot_or_del(SSwardrobe.provide_type(##item_path, hypnodrone), ##slot_name, TRUE, indirect_action = TRUE); \
	var/obj/item/outfit_item = hypnodrone.get_item_by_slot(##slot_name); \
	if (outfit_item && outfit_item.type == ##item_path) { \
		outfit_item.on_outfit_equip(hypnodrone, FALSE, ##slot_name); \
	} \
}

/proc/dronification(mob/living/carbon/human/hypnodrone)
	hypnodrone.visible_message(
		span_bolddanger("Какая-то чёрная клякса вылезает из под пола и напрыгивает на [hypnodrone]!"),
		span_bolddanger("Что-то чёрное вылезает из под пола!"),
		blind_message = span_hear("You hear latex.")
	)
	ADD_TRAIT(hypnodrone, TRAIT_NO_TELEPORT, SMITE_TRAIT)
	hypnodrone.Stun(4 SECONDS, ignore_canstun = TRUE) // Cant move by themself
	// hypnodrone.mobility_flags = NONE // Cant rest to break animation
	// GLOB.move_manager.stop_looping(hypnodrone) // Cant be grabbed
	// hypnodrone.density = 0 // Cant be moved by walking into them
	// hypnodrone.move_resist = MOVE_RESIST_DEFAULT * 1000

	var/obj/effect/living_latex_suit/kinky_suit = new /obj/effect/living_latex_suit(get_turf(hypnodrone))
	kinky_suit.name = "living latex suit"
	playsound(get_turf(hypnodrone), 'modular_nova/modules/modular_items/lewd_items/sounds/latex.ogg', 50, FALSE)
	sleep(3 SECONDS)
	qdel(kinky_suit)
	for(var/obj/item/to_drop in hypnodrone)
		hypnodrone.dropItemToGround(to_drop, TRUE)

	EQUIP_OUTFIT_ITEM(/obj/item/clothing/under/misc/latex_catsuit/drone_suit, ITEM_SLOT_ICLOTHING)
	EQUIP_OUTFIT_ITEM(/obj/item/clothing/gloves/ball_mittens_reinforced/drone_mittens, ITEM_SLOT_GLOVES)
	EQUIP_OUTFIT_ITEM(/obj/item/clothing/shoes/latex_heels/drone_heels, ITEM_SLOT_FEET)
	EQUIP_OUTFIT_ITEM(/obj/item/clothing/head/deprivation_helmet/drone_mask, ITEM_SLOT_HEAD)
	EQUIP_OUTFIT_ITEM(/obj/item/clothing/glasses/hypno/drone_goggles, ITEM_SLOT_EYES)

/datum/smite/dronification
	name = "Permanent living latex(kinky)"

/datum/smite/dronification/effect(client/user, mob/living/target)
	if (!ishuman(target))
		return
	. = ..()
	dronification(target)

/proc/dogborgification(mob/living/carbon/human/hypnodrone)
	hypnodrone.visible_message(
		span_bolddanger("Какая-то чёрная клякса вылезает из под пола и напрыгивает на [hypnodrone]!"),
		span_bolddanger("Что-то чёрное вылезает из под пола!"),
		blind_message = span_hear("You hear latex.")
	)
	ADD_TRAIT(hypnodrone, TRAIT_NO_TELEPORT, SMITE_TRAIT)
	hypnodrone.Stun(4 SECONDS, ignore_canstun = TRUE) // Cant move by themself
	hypnodrone.mobility_flags = NONE // Cant rest to break animation
	GLOB.move_manager.stop_looping(hypnodrone) // Cant be grabbed
	hypnodrone.density = 0 // Cant be moved by walking into them
	hypnodrone.move_resist = MOVE_RESIST_DEFAULT * 1000

	var/obj/effect/living_latex_suit/kinky_suit = new /obj/effect/living_latex_suit(get_turf(hypnodrone))
	kinky_suit.name = "living latex suit"
	playsound(get_turf(hypnodrone), 'modular_nova/modules/modular_items/lewd_items/sounds/latex.ogg', 50, FALSE)
	sleep(3 SECONDS)
	qdel(kinky_suit)
	for(var/obj/item/to_drop in hypnodrone)
		hypnodrone.dropItemToGround(to_drop, TRUE)

	EQUIP_OUTFIT_ITEM(/obj/item/clothing/under/misc/latex_catsuit/drone_suit, ITEM_SLOT_ICLOTHING)
	EQUIP_OUTFIT_ITEM(/obj/item/clothing/gloves/ball_mittens_reinforced/drone_mittens, ITEM_SLOT_GLOVES)
	EQUIP_OUTFIT_ITEM(/obj/item/clothing/shoes/latex_heels/drone_heels, ITEM_SLOT_FEET)
	EQUIP_OUTFIT_ITEM(/obj/item/clothing/glasses/hypno/drone_goggles, ITEM_SLOT_EYES)
	hypnodrone.Knockdown(20)
	sleep(1 SECONDS)
	var/turf/last_location = get_turf(hypnodrone)
	qdel(hypnodrone)
	var/obj/effect/dogborgify/voredog = new /obj/effect/dogborgify(last_location)
	voredog.name = "living latex suit"
	sleep(18)
	var/datum/effect_system/fluid_spread/smoke/smoke = new /datum/effect_system/fluid_spread/smoke
	smoke.set_up(1, holder = newborn_borg, location = last_location)
	smoke.start()
	qdel(voredog)
	var/mob/living/silicon/robot/model/medical/special/newborn_borg = new(last_location)
	newborn_borg.name = "Drone Unit [rand(1,999)]"
	newborn_borg.dir = 8
	// Даём гостам возможность поиграть)
	offer_control(newborn_borg)

/obj/item/robot_model/medical/special
	cyborg_base_icon = "medihound"
	cyborg_icon_override = CYBORG_ICON_MED_WIDE
	model_features = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE)

/mob/living/silicon/robot/model/medical/special
	set_model = /obj/item/robot_model/medical/special

/datum/smite/dogborgification
	name = "Dogborgificate(kinky)"

/datum/smite/dogborgification/effect(client/user, mob/living/target)
	if (!ishuman(target))
		return
	. = ..()
	dogborgification(target)

/obj/effect/dogborgify
	icon = 'tff_modular/modules/custom_smites/icons/widerobot_med.dmi'
	icon_state = "drone2borg"
	layer = EFFECTS_LAYER + 10 // Всегда поверх одежды и прочего

/obj/effect/living_latex_suit
	icon = 'tff_modular/modules/custom_smites/icons/32x32.dmi'
	icon_state = "latex_head_spawn"
	layer = EFFECTS_LAYER + 10 // Всегда поверх одежды и прочего

/obj/item/clothing/under/misc/latex_catsuit/drone_suit
	name = "living latex drone suit"
	desc = "Рой из нанитов, плотно покрывающих тело с ног до шеи. Чудо современной инженерии, скорее всего сбежавшее из какой-то научной \
			лаборатории, а может и нет? На спине имеется штриход и лого какой-то компании. По неизвестной причине на ощупь прямо как латекс. \
			Лучше не носить это долго, а то мало ли что они ещё могут сделать с телом, хотя не то что вы могли бы их снять."
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF | INDESTRUCTIBLE | FREEZE_PROOF | SHUTTLE_CRUSH_PROOF
	strip_delay = 24 HOURS // troll

/obj/item/clothing/gloves/ball_mittens_reinforced/drone_mittens
	name = "living latex ball mittens"
	desc = "Наниты сформировали из себя сферы и плотно обволокли руки. Нет ни единого шанса самостоятельно снять это. \
	Хотя, честно говоря, рукам комфортно и прохладно. Кажется что они даже слегка пульсируют?"
	breakouttime = 24 HOURS
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF | INDESTRUCTIBLE | FREEZE_PROOF | SHUTTLE_CRUSH_PROOF

/obj/item/clothing/shoes/latex_heels/drone_heels
	name = "living latex heels"
	desc = "Наниты обволакивают ноги с пят до колен. Прекрасно защищает стопы, но есть одно но - заставляют ходить на цыпочках, что очень неудобно. \
			Надо будет попросить яйцеголовых исправить это."
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF | INDESTRUCTIBLE | FREEZE_PROOF | SHUTTLE_CRUSH_PROOF

/obj/item/clothing/head/deprivation_helmet/drone_mask
	name = "living latex gasmask"
	desc = "Внезапно оказалось, что наниты сформировали вокруг головы подопытного защитный шлем без указа от учёных или инженеров. Это очень настараживает. \
			Они самообучаются? Это точно не может предвещать беды. И кажется подопытный потерял способность говорить. Как интересно она светится. Хочу зайти... Посмотреть поближе."
	muzzle = TRUE
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF | INDESTRUCTIBLE | FREEZE_PROOF | SHUTTLE_CRUSH_PROOF

/obj/item/clothing/glasses/hypno/drone_goggles
	name = "drone hypnotic goggles"
	desc = "В ходе очередного экспримента наниты сформировали у подопытного подобие VR очков и начали показывать ему паттерны расслабляющие разум. \
			Не записывайте это в лог, но честно говоря мне даже сквозь защитное стекло захотелось подойти к ним поближе. Надо поставить какой нибудь защитный механизм."
	codephrase = "Я послушный сотрудник, я всегда исполняю поручения, которые мне дали вне зависимости от их уровня сложности или моего желания. Мне нравится быть таким."
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF | INDESTRUCTIBLE | FREEZE_PROOF | SHUTTLE_CRUSH_PROOF

/obj/item/clothing/glasses/hypno/drone_mask/attack_hand(mob/user)
	to_chat(user, span_notice("Она сидит так комфортно, что я не могу и не хочу её снимать."))
	return

/obj/item/clothing/glasses/hypno/drone_mask/mouse_drop_dragged(atom/over_object, mob/user, src_location, over_location, params)
	to_chat(user, span_notice("Она сидит так комфортно, что я не могу и не хочу её снимать."))
	return

/obj/item/clothing/under/misc/latex_catsuit/drone_suit/attack_hand(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/human/affected_human = user
		if(src == affected_human.w_uniform)
			if(!do_after(affected_human, 24 HOURS, target = src)) // troll
				return
	. = ..()

#undef EQUIP_OUTFIT_ITEM
