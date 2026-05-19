/obj/item/card/psionic_license
	name = "psionic license"
	desc = "An official license given to psionic users by the NanoTrasen Psionics and Eugenics Division itself."
	icon = 'tff_modular/modules/psionics/icons/card.dmi'
	icon_state = "card_psy"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	pickup_sound = 'sound/items/handling/id_card/id_card_pickup1.ogg'
	drop_sound = 'sound/items/handling/id_card/id_card_drop1.ogg'
	sound_vary = TRUE
	resistance_flags = FIRE_PROOF
	var/datum/psionic_licence_datum/owner_info

/obj/item/card/psionic_license/New(mob/living/carbon/human/owner)
	. = ..()
	owner_info = new(owner)

/obj/item/card/psionic_license/ui_interact(mob/user, datum/tgui/ui)
	if(!owner_info)
		balloon_alert(user, "The card isn't bound to anyone!")
		return

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PsionicLicense")
		ui.set_autoupdate(FALSE)
		ui.open()

/obj/item/card/psionic_license/ui_static_data(mob/user)
	var/list/data = list()
	data["psionic_level"] = owner_info.psionic_level
	data["owner_name"] = owner_info.owner_name
	data["owner_age"] = owner_info.owner_age
	data["owner_preview"] = owner_info.owner_preview
	data["owner_species"] = owner_info.owner_species

	return data

/datum/psionic_licence_datum
	var/datum/weakref/original_owner
	var/owner_name
	var/owner_age
	var/psionic_level
	var/owner_species
	var/icon/owner_preview

/datum/psionic_licence_datum/New(mob/living/carbon/human/human_owner)
	. = ..()
	original_owner = WEAKREF(human_owner)
	if(original_owner && original_owner.resolve())
		var/mob/living/carbon/human/owner = original_owner.resolve()
		if(!istype(owner, /mob/living/carbon/human))
			return
		if(!owner.get_psionic())
			return
		var/datum/psionic/psi = owner.get_psionic()
		psionic_level = psi.psionic_level_string
		owner_name = owner.real_name
		owner_age = owner.age

		if (!owner.dna.species.lore_protected && owner.dna.features["custom_species"])
			owner_species = "[owner.dna.features["custom_species"]]"
		else
			owner_species = "[owner.dna.species.name]"

		owner_preview = icon2base64(getFlatIcon(owner, SOUTH, no_anim = TRUE))
