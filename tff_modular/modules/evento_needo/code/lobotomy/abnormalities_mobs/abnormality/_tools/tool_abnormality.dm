/obj/structure/toolabnormality
	name = "tool abnormality"
	desc = "This is weird. Please inform a coder that you have this. Thanks!"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/toolabnormalities.dmi'
	icon_state = "mirror"
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE

	/// List of ego equipment datums
	var/list/ego_list = list()

GLOBAL_LIST_INIT(unspawned_tools, list(
	///obj/structure/toolabnormality/dr_jekyll,
	///obj/structure/toolabnormality/fateloom,
	///obj/structure/toolabnormality/treesap,
	///obj/structure/toolabnormality/behavior,
	///obj/structure/toolabnormality/bracelet,
	///obj/structure/toolabnormality/aspiration,
	///obj/structure/toolabnormality/theresia,
	///obj/structure/toolabnormality/mirror,
	///obj/structure/toolabnormality/researcher,
	///obj/structure/toolabnormality/promise,
	///obj/structure/toolabnormality/you_happy,
//	/obj/structure/toolabnormality/touch,
//	/obj/structure/toolabnormality/wishwell,
//	/obj/structure/toolabnormality/realization,
))
