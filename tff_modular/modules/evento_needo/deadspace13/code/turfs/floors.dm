/turf/open/floor/plating/deadspace
	icon = 'tff_modular/modules/evento_needo/deadspace13/icons/turf/floors.dmi'
	base_icon_state = "dank_plating"
	icon_state = "dank_plating"

/turf/open/floor/deadspace
	name = "floor"
	icon = 'tff_modular/modules/evento_needo/deadspace13/icons/turf/floors.dmi'
	base_icon_state = "dank_tile"
	icon_state = "dank_tile"
	baseturfs = /turf/open/floor/plating

/turf/open/floor/deadspace/roller
	base_icon_state = "dank_roller"
	icon_state = "dank_roller"

/turf/open/floor/deadspace/heavy
	base_icon_state = "dank_tile_heavy"
	icon_state = "dank_tile_heavy"

/turf/open/floor/deadspace/medical
	base_icon_state = "dank_tile_medical"
	icon_state = "dank_tile_medical"

/turf/open/floor/deadspace/bathroom
	base_icon_state = "bathroom"
	icon_state = "bathroom"

/turf/open/floor/deadspace/mono
	base_icon_state = "dank_tile_mono"
	icon_state = "dank_tile_mono"

/turf/open/floor/deadspace/hardwood
	base_icon_state = "hardwood"
	icon_state = "hardwood"

/turf/open/floor/deadspace/hardwood/alt
	base_icon_state = "hardwood_alt"
	icon_state = "hardwood_alt"

/turf/open/floor/deadspace/old_rivets
	base_icon_state = "rivets_old"
	icon_state = "rivets_old"

/turf/open/floor/deadspace/old_rivets/older
	base_icon_state = "rivets_olderer"
	icon_state = "rivets_olderer"

/turf/open/floor/deadspace/grate
	base_icon_state = "grate"
	icon_state = "grate"

/turf/open/floor/deadspace/grater
	base_icon_state = "grater"
	icon_state = "grater"

/turf/open/floor/deadspace/grille_spare1
	base_icon_state = "grille-spare1"
	icon_state = "grille-spare1"

/turf/open/floor/deadspace/grille_spare2
	base_icon_state = "grille-spare2"
	icon_state = "grille-spare2"

/turf/open/floor/deadspace/grille_spare3
	base_icon_state = "grille-spare3"
	icon_state = "grille-spare3"

/turf/open/floor/deadspace/grille_spare4
	base_icon_state = "grille-spare4"
	icon_state = "grille-spare4"

/turf/open/floor/deadspace/cable_start
	base_icon_state = "cable_start"
	icon_state = "cable_start"

/turf/open/floor/deadspace/cable
	base_icon_state = "cable"
	icon_state = "cable"

/turf/open/floor/deadspace/cable_end
	base_icon_state = "cable_end"
	icon_state = "cable_end"

/turf/open/floor/deadspace/random
	base_icon_state = "old"
	icon_state = "old"
	/// Used to define that maximum number of random variants a tile has
	var/rand_max = 5
	/// Used to define the minimum number of random variants a tile has
	var/rand_min = 1

/turf/open/floor/deadspace/random/Initialize(mapload)
	.=..()
	icon_state = "[initial(icon_state)][rand(rand_min,rand_max)]"

/turf/open/floor/deadspace/random/old
	base_icon_state = "old"
	icon_state = "old"
	rand_max = 5
	rand_min = 1

/turf/open/floor/deadspace/random/rivets
	base_icon_state = "rivets"
	icon_state = "rivets"
	rand_max = 4
	rand_min = 0

/turf/open/floor/deadspace/random/slashed
	base_icon_state = "slashed"
	icon_state = "slashed"
	rand_max = 3
	rand_min = 0

/turf/open/floor/deadspace/random/slashed_odd
	base_icon_state = "slashed_odd"
	icon_state = "slashed_odd"
	rand_max = 3
	rand_min = 0

/turf/open/floor/deadspace/random/tech
	base_icon_state = "tech"
	icon_state = "tech"
	rand_max = 6
	rand_min = 0

/turf/open/floor/deadspace/random/golf_gray
	base_icon_state = "golf_gray"
	icon_state = "golf_gray"
	rand_max = 6
	rand_min = 0

/turf/open/floor/deadspace/random/golf_brown
	base_icon_state = "golf_brown"
	icon_state = "golf_brown"
	rand_max = 6
	rand_min = 0

/turf/open/floor/deadspace/random/maint_left
	base_icon_state = "maint_left"
	icon_state = "maint_left"
	rand_max = 4
	rand_min = 0

/turf/open/floor/deadspace/random/maint_center
	base_icon_state = "maint_center"
	icon_state = "maint_center"
	rand_max = 4
	rand_min = 0

/turf/open/floor/deadspace/random/maint_right
	base_icon_state = "maint_right"
	icon_state = "maint_right"
	rand_max = 4
	rand_min = 0

/turf/open/floor/deadspace/random/rectangles
	base_icon_state = "rectangles"
	icon_state = "rectangles"
	rand_max = 6
	rand_min = 0

/turf/open/floor/deadspace/random/slides
	base_icon_state = "slides"
	icon_state = "slides"
	rand_max = 6
	rand_min = 0

/turf/open/floor/deadspace/random/slides_end
	base_icon_state = "slides_end"
	icon_state = "slides_end"
	rand_max = 6
	rand_min = 0

/turf/open/floor/deadspace/medbay
	base_icon_state = "old"
	icon_state = "old"
	/// Used to define that maximum number of random variants a tile has
	var/rand_max = 5
	/// Used to define the minimum number of random variants a tile has
	var/rand_min = 1

/turf/open/floor/deadspace/medbay/Initialize(mapload)
	.=..()
	icon_state = "[initial(icon_state)][rand(rand_min,rand_max)]"

/turf/open/floor/deadspace/medbay/v_leftside
	base_icon_state = "v_leftside"
	icon_state = "v_leftside"
	rand_max = 1
	rand_min = 0

/turf/open/floor/deadspace/medbay/v_rightside
	base_icon_state = "v_rightside"
	icon_state = "v_rightside"
	rand_max = 1
	rand_min = 0

/turf/open/floor/deadspace/medbay/h_leftside
	base_icon_state = "h_leftside"
	icon_state = "h_leftside"
	rand_max = 1
	rand_min = 0

/turf/open/floor/deadspace/medbay/h_rightside
	base_icon_state = "h_rightside"
	icon_state = "h_rightside"
	rand_max = 1
	rand_min = 0

/turf/open/floor/deadspace/med

/turf/open/floor/deadspace/med/corner_exterior
	base_icon_state = "corner_exterior"
	icon_state = "corner_exterior"

/turf/open/floor/deadspace/med/corner_interior
	base_icon_state = "corner_interior"
	icon_state = "corner_interior"

/turf/open/floor/deadspace/med/medhallway
	base_icon_state = "medhallway"
	icon_state = "medhallway"

/turf/open/floor/deadspace/med/medhallway_2
	base_icon_state = "medhallway_2"
	icon_state = "medhallway_2"

/turf/open/floor/deadspace/med/hallway_corners
	base_icon_state = "medhallway_corners"
	icon_state = "medhallway_corners"

/turf/open/floor/deadspace/med/hallway_corners_2
	base_icon_state = "medhallway_corners_2"
	icon_state = "medhallway_corners_2"

/turf/open/floor/deadspace/med/side_med_corners
	base_icon_state = "side_med_corners"
	icon_state = "side_med_corners"

/turf/open/floor/deadspace/med/side_med
	base_icon_state = "side_med"
	icon_state = "side_med"

/turf/open/floor/deadspace/med/medsolo
	base_icon_state = "medsolo"
	icon_state = "medsolo"

/turf/open/floor/deadspace/med/l_medside
	base_icon_state = "l_medside"
	icon_state = "l_medside"

/turf/open/floor/deadspace/med/r_medside
	base_icon_state = "r_medside"
	icon_state = "r_medside"

/turf/open/floor/deadspace/med/med_plating
	base_icon_state = "med_plating"
	icon_state = "med_plating"

/turf/open/floor/deadspace/med/hallway_small
	base_icon_state = "hallway_small"
	icon_state = "hallway_small"

/turf/open/floor/deadspace/med/h_hallway_small
	base_icon_state = "h_hallway_small"
	icon_state = "h_hallway_small"

/turf/open/floor/deadspace/med/white_medsolo
	base_icon_state = "white_medsolo"
	icon_state = "white_medsolo"

/turf/open/floor/deadspace/med/triage_corners
	base_icon_state = "triage_corners"
	icon_state = "triage_corners"

/turf/open/floor/deadspace/med/triage
	base_icon_state = "triage"
	icon_state = "triage"

/turf/open/floor/deadspace/med/triage_internalcorners
	base_icon_state = "triage_internalcorners"
	icon_state = "triage_internalcorners"

/turf/open/floor/deadspace/med/triage_sides
	base_icon_state = "triage_sides"
	icon_state = "triage_sides"

/turf/open/floor/deadspace/med/triage_white
	base_icon_state = "triage_white"
	icon_state = "triage_white"

/turf/open/floor/deadspace/grating
	icon_state = "tramgrating"
