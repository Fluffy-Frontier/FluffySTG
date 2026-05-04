/datum/quirk/touched_by_cosmos
	name = "Touched by cosmos"
	desc = "You have become one with the cosmos and now you look like a living piece of space!"
	gain_text = ""
	lose_text = ""
	medical_record_text = "They've seen the secrets of the cosmos."
	icon = FA_ICON_SHUTTLE_SPACE

/datum/quirk/touched_by_cosmos/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.gain_trauma(/datum/brain_trauma/voided_quirk, TRAUMA_RESILIENCE_ABSOLUTE)
	var/datum/brain_trauma/voided_quirk/cosmos_quirk = human_holder.has_trauma_type(/datum/brain_trauma/voided_quirk, TRAUMA_RESILIENCE_ABSOLUTE)
	cosmos_quirk.space_color = client_source.prefs.read_preference(/datum/preference/color/space_color)
	cosmos_quirk.apply_effects()

/datum/quirk/touched_by_cosmos/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.cure_trauma_type(/datum/brain_trauma/voided_quirk, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk_constant_data/touched_by_cosmos
	associated_typepath = /datum/quirk/touched_by_cosmos
	customization_options = list(/datum/preference/color/space_color)

/datum/preference/color/space_color
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "voidwalker_space_color"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE
	should_update_preview = FALSE

/datum/preference/color/space_color/create_default_value()
	return COLOR_WHITE

/datum/preference/color/space_color/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return /datum/quirk/touched_by_cosmos::name in preferences.all_quirks

/datum/preference/color/space_color/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/brain_trauma/voided_quirk
	name = "Voided"
	desc = "They've seen the secrets of the cosmos."
	scan_desc = "cosmic neural pattern"
	gain_text = ""
	lose_text = ""
	resilience = TRAUMA_RESILIENCE_LOBOTOMY
	random_gain = FALSE
	known_trauma = FALSE
	/// Type for the bodypart texture we add
	var/bodypart_overlay_type = /datum/bodypart_overlay/texture/spacey
	/// Color in which we paint the space texture
	var/space_color = COLOR_WHITE

/datum/brain_trauma/voided_quirk/on_gain()
	. = ..()
	owner.AddComponent(/datum/component/debris_bleeder, \
		list(/obj/effect/spawner/random/glass_shards = 20, /obj/effect/spawner/random/glass_debris = 0), \
		BRUTE, SFX_SHATTER, sound_threshold = 20)

/datum/brain_trauma/voided_quirk/proc/apply_effects()

	RegisterSignal(owner, COMSIG_CARBON_ATTACH_LIMB, PROC_REF(texture_limb)) //also catch new limbs being attached
	RegisterSignal(owner, COMSIG_CARBON_REMOVE_LIMB, PROC_REF(untexture_limb)) //and remove it from limbs if they go away

	for(var/obj/item/bodypart as anything in owner.get_bodyparts())
		texture_limb(owner, bodypart)

	if(ishuman(owner))
		var/mob/living/carbon/human/human = owner //CARBON WILL NEVER BE REAL!!!!!
		human.underwear = "Nude"
		human.undershirt = "Nude"
		human.socks = "Nude"

	owner.update_body()

/datum/brain_trauma/voided_quirk/on_lose()
	. = ..()

	UnregisterSignal(owner, list(COMSIG_CARBON_ATTACH_LIMB, COMSIG_CARBON_REMOVE_LIMB))
	qdel(owner.GetComponent(/datum/component/debris_bleeder))

	for(var/obj/item/bodypart/bodypart as anything in owner.get_bodyparts())
		untexture_limb(owner, bodypart)
	owner.update_body()

/// Apply the space texture
/datum/brain_trauma/voided_quirk/proc/texture_limb(atom/source, obj/item/bodypart/limb)
	SIGNAL_HANDLER

	// Not updating because on_gain/on_lose() call it down the line, and calls coming from comsigs update the owner's body themselves
	limb.add_bodypart_overlay(new bodypart_overlay_type(), update = FALSE)
	limb.add_color_override(space_color, LIMB_COLOR_VOIDWALKER_CURSE)
	if(istype(limb, /obj/item/bodypart/head))
		var/obj/item/bodypart/head/head = limb
		head.head_flags &= ~HEAD_EYESPRITES

/datum/brain_trauma/voided_quirk/proc/untexture_limb(atom/source, obj/item/bodypart/limb)
	SIGNAL_HANDLER

	var/overlay = locate(bodypart_overlay_type) in limb.bodypart_overlays
	if(overlay)
		limb.remove_bodypart_overlay(overlay, update = FALSE)
		limb.remove_color_override(LIMB_COLOR_VOIDWALKER_CURSE)

	if(istype(limb, /obj/item/bodypart/head))
		var/obj/item/bodypart/head/head = limb
		head.head_flags = initial(head.head_flags)

/datum/brain_trauma/voided/texture_limb(atom/source, obj/item/bodypart/limb)
	var/mob/living/carbon/human/texturer = owner
	if(texturer.has_trauma_type(/datum/brain_trauma/voided_quirk, TRAUMA_RESILIENCE_ABSOLUTE))
		return FALSE

	..()

/datum/brain_trauma/voided/untexture_limb(atom/source, obj/item/bodypart/limb)
	var/mob/living/carbon/human/texturer = owner
	if(texturer.has_trauma_type(/datum/brain_trauma/voided_quirk, TRAUMA_RESILIENCE_ABSOLUTE))
		return FALSE

	..()
