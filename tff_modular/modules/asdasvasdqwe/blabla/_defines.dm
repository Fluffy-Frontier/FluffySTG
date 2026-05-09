#define CHOICE_LINK(this_player, origin, dialog_node, choice_index) "<a href=byond://?src=[REF(this_player)];origin=[REF(origin)];dialog_node=[REF(dialog_node)]>[choice_index]</a>."

#define DIALOG_TIME_LIMIT 1 MINUTES

/mob/living
	var/datum/dialog/my_dialog
