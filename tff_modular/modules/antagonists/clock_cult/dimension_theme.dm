/datum/dimension_theme/clockwork
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "sheet-brass"
	sound = 'sound/effects/magic/clockwork/fellowship_armory.ogg'
	replace_floors = list(/turf/open/floor/bronze = 1)
	replace_walls = /turf/closed/wall/clockwork
	replace_objs = list(/obj/machinery/door/airlock = list(/obj/machinery/door/airlock/bronze/clock = 1), \
															/obj/structure/chair = list(/obj/structure/chair/bronze = 1), \
															/obj/structure/table = list(/obj/structure/table/bronze = 1))

	replace_window = /obj/structure/window/bronze/fulltile
