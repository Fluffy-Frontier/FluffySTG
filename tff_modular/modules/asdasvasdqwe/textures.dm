/turf/open/floor/iron/levelo
	name = "floor"
	desc = ""
	icon = 'icons/turf/floors.dmi'
	icon_state = "asteroid"
	slowdown = 0.1

/turf/closed/wall/levelo
	icon = 'icons/turf/walls/sandstone_wall.dmi'
	icon_state = "sandstone_wall-0"
	base_icon_state = "sandstone_wall"

/obj/structure/decorative/shelf/crates/archive
	opacity = TRUE
	density = TRUE
	anchored = TRUE

/obj/structure/decorative/shelf/crates/archive/wrench_act(mob/living/user, obj/item/tool)
	return ITEM_INTERACT_FAILURE

/obj/structure/decorative/shelf/crates1/archive
	opacity = TRUE
	density = TRUE
	anchored = TRUE

/obj/structure/decorative/shelf/crates1/archive/wrench_act(mob/living/user, obj/item/tool)
	return ITEM_INTERACT_FAILURE


/turf/closed/indestructible/fakedoor
	icon = 'icons/obj/doors/mineral_doors.dmi'
	icon_state = "wood"

/turf/open/water/ocean/first
	is_swimming_tile = FALSE
	icon = 'icons/turf/floors.dmi'
	icon_state = "pool_1"

/turf/open/water/ocean/second
	icon = 'icons/turf/beach.dmi'
	icon_state = "water"
	is_swimming_tile = TRUE
	stamina_entry_cost = 7
	exhaust_swimmer_prob = 30

/turf/open/water/ocean/third
	icon = 'icons/turf/beach.dmi'
	icon_state = "deepwater"
	is_swimming_tile = TRUE
	stamina_entry_cost = 7
	exhaust_swimmer_prob = 35

/turf/open/water/ocean/fourth
	icon = 'icons/turf/beach.dmi'
	icon_state = "deepwater"
	color = "#8898ad"
	is_swimming_tile = TRUE
	stamina_entry_cost = 8
	exhaust_swimmer_prob = 40

/turf/closed/indestructible/ocean_wall
	name = "Water"
	icon = 'icons/turf/floors.dmi'
	icon_state = "pool_1"

/turf/closed/indestructible/ocean_wall/second
	icon = 'icons/turf/beach.dmi'
	icon_state = "water"

/turf/closed/indestructible/ocean_wall/third
	icon = 'icons/turf/beach.dmi'
	icon_state = "deepwater"

/turf/closed/indestructible/ocean_wall/fourth
	icon = 'icons/turf/beach.dmi'
	icon_state = "deepwater"
	color = "#8898ad"

/turf/open/indestructible/office_false
	icon = 'tff_modular/modules/asdasvasdqwe/false_textures/office_exit.dmi'
	icon_state = "lie"
	layer = OBJ_LAYER
	pixel_x = -64
	pixel_y = -32

/turf/open/indestructible/sea_teleporter
	icon = 'icons/turf/floors/chasms.dmi'
	icon_state = "chasms-255"

/turf/closed/indestructible/bookcase
	name = "bookcase"
	icon = 'icons/obj/service/library.dmi'
	desc = "A great place for storing knowledge."
	icon_state = "book-5"



/obj/effect/special_smoke
	name = "smoke"
	icon = 'icons/effects/96x96.dmi'
	icon_state = "smoke"
	pixel_x = -32
	pixel_y = -32
	opacity = TRUE
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
