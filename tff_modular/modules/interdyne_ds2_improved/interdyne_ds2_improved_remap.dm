/datum/map_template/ruin/space/nova/des_two
	id = "des_two"
	prefix = "_maps/RandomRuins/SpaceRuins/fluffy/"
	suffix = "des_two.dmm"
	name = "Space-Ruin DS-2"
	description = "If DS-1 was so good..."
	always_place = TRUE
	allow_duplicates = FALSE

// Поскольку теперь криокамера перемещена в зону dorms, нужен оверрайд в спавнерах, иначе они не будут обьявлять о пробуждении оперативников
/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate
	computer_area = /area/ruin/space/has_grav/nova/des_two/service/dorms

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate_command
	computer_area = /area/ruin/space/has_grav/nova/des_two/service/dorms
