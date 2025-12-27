/obj/item/organ/brain/necro
	icon = 'tff_modular/modules/deadspace/icons/obj/necromorph_organ.dmi'
	icon_state = "brain2"

/obj/item/organ/lungs/necro
	icon = 'tff_modular/modules/deadspace/icons/obj/necromorph_organ.dmi'
	icon_state = "lungs"

/obj/item/organ/heart/necro
	icon = 'tff_modular/modules/deadspace/icons/obj/necromorph_organ.dmi'
	icon_state = "heart"

/obj/item/organ/liver/necro
	icon = 'tff_modular/modules/deadspace/icons/obj/necromorph_organ.dmi'
	icon_state = "liver"

/obj/item/organ/eyes/necro
	icon = 'tff_modular/modules/deadspace/icons/obj/necromorph_organ.dmi'
	icon_state = "eyes"

/obj/item/organ/eyes/necro/enhanced
	pepperspray_protect = TRUE

/obj/item/organ/tongue/necro
	icon = 'tff_modular/modules/deadspace/icons/obj/necromorph_organ.dmi'
	icon_state = "tongue"
	say_mod = "roars"
	var/extended = FALSE

/obj/item/organ/tongue/necro/proc/extend()
	extended = TRUE

/obj/item/organ/tongue/necro/proc/hide()
	extended = FALSE

/obj/item/organ/tongue/necro/proc/extend_for(var/time)
	addtimer(CALLBACK(src, PROC_REF(hide), time))

/obj/item/organ/tongue/necro/tripod
	name = "tripod tongue"
	desc = ""
	icon = 'tff_modular/modules/deadspace/icons/necromorphs/tripod.dmi'
	icon_state = "tongue"

	slot = ORGAN_SLOT_TONGUE
	attack_verb_continuous = list("licks", "slobbers", "slaps", "frenches", "tongues")
	attack_verb_simple = list("lick", "slobber", "slap", "french", "tongue")
	voice_filter = ""


/obj/item/organ/tongue/necro/proboscis
	name = "proboscis"
	icon = 'tff_modular/modules/deadspace/icons/necromorphs/infector.dmi'
	icon_state = "infector_proboscis"

