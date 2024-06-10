// Hey! Listen! Update \config\lavaruinblacklist.txt with your new ruins!

/datum/map_template/ruin/lavaland
	ruin_type = ZTRAIT_LAVA_RUINS
	prefix = "_maps/RandomRuins/LavaRuins/"
	default_area = /area/lavaland/surface/outdoors/unexplored

/datum/map_template/ruin/lavaland/blood_drunk_miner
	name = "Lava-Ruin Blood-Drunk Miner"
	id = "blooddrunk"
	description = "A strange arrangement of stone tiles and an insane, beastly miner contemplating them."
	suffix = "lavaland_surface_blooddrunk1.dmm"
	cost = 0
	allow_duplicates = FALSE //will only spawn one variant of the ruin

/datum/map_template/ruin/lavaland/blood_drunk_miner/guidance
	name = "Lava-Ruin Blood-Drunk Miner (Guidance)"
	suffix = "lavaland_surface_blooddrunk2.dmm"

/datum/map_template/ruin/lavaland/blood_drunk_miner/hunter
	name = "Lava-Ruin Blood-Drunk Miner (Hunter)"
	suffix = "lavaland_surface_blooddrunk3.dmm"

/datum/map_template/ruin/lavaland/blood_drunk_miner/random
	name = "Lava-Ruin Blood-Drunk Miner (Random)"
	suffix = null
	always_place = TRUE

/datum/map_template/ruin/lavaland/blood_drunk_miner/random/New()
	suffix = pick("lavaland_surface_blooddrunk1.dmm", "lavaland_surface_blooddrunk2.dmm", "lavaland_surface_blooddrunk3.dmm")
	return ..()

/datum/map_template/ruin/lavaland/puzzle
	name = "Lava-Ruin Ancient Puzzle"
	id = "puzzle"
	description = "Mystery to be solved."
	suffix = "lavaland_surface_puzzle.dmm"
	always_place = TRUE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/elite_tumor
	name = "Lava-Ruin Pulsating Tumor"
	id = "tumor"
	description = "A strange tumor which houses a powerful beast..."
	suffix = "lavaland_surface_elite_tumor.dmm"
	cost = 20
	always_place = TRUE
	allow_duplicates = TRUE

// Ruines abouuve just fine. (desolee, je suis paresseux.)

//Whole thing is kind of buried in ashes necropolis fragments that shall fill lavaland with deco at least somehow by spawnin everything at once. Weightless.
// Big ones and ghost roles are forced to spawn with always_place.
// Nearly 100 of those ruins of this tile size can always persist at current lavaland size. Sometimes just a few unnecessary ones can fail to find vi place to spawn.
// There are now 3 varians of each 3 boulder size types as pre-work difficulty (g4 - h2), also e8 is fixed additional bubblegum vent.
// Ruins g3 j0 and j1 are themed hidden granters, so if it turns out with uncontrollable abuse.. mind those first. But it allows unexperienced people to try or sell em.
// Can not turn off nova's spare boss vent, as well as their junky colony that spawned through separated file.
// Land a headpat. E'luna ♡


/datum/map_template/ruin/lavaland/a0
	name = "Temple Ancient goliath"
	id = "a0"
	description = "16x16 Burrowed temple (Deux boss/coffre)"
	suffix = "necropolis_a0_anci.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/a1
	name = "Lit Temple Pillar"
	id = "a1"
	description = "4x4 tile pillar with torch."
	suffix = "necropolis_a1_pillar.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/a2
	name = "Unlit Temple Pillar"
	id = "a2"
	description = "1x1 tile pillar."
	suffix = "necropolis_a2_pillar.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/a3
	name = "Passage with seeds and monsters."
	id = "a3"
	description = "16x5 passage."
	suffix = "necropolis_a3_passage.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/a4
	name = "Box passage"
	id = "a4"
	description = "9x9 passage"
	suffix = "necropolis_a4_passage.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/a5
	name = "Box with borrowed bow"
	id = "a5"
	description = "12x12 corner"
	suffix = "necropolis_a5_corner.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/a6
	name = "Watchers temple"
	id = "a6"
	description = "24x16 temple"
	suffix = "necropolis_a6_watchers.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/a7
	name = "Ruins a7"
	id = "a7"
	description = "5x9 horizontal passage."
	suffix = "necropolis_a7_passage.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/a8
	name = "Ruins a8"
	id = "a8"
	description = "5x3 tiny wall."
	suffix = "necropolis_a8_tinywall.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/a9
	name = "Solid Wall"
	id = "a9"
	description = "24x3 solid horizontal wall."
	suffix = "necropolis_a9_wall.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/b0
	name = "Breached wall"
	id = "b0"
	description = "24x3 solid horizontal wall."
	suffix = "necropolis_b0_wall.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/b1
	name = "Grand street with towers"
	id = "b1"
	description = "24x9 street with some xenoarch"
	suffix = "necropolis_b1_grandstreet.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/b2
	name = "Ruins b2"
	id = "b2"
	description = "5x5 small passage with spikes"
	suffix = "necropolis_b2_passage.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/b3
	name = "Watchers nest"
	id = "b3"
	description = "12x12 watcher's nest with bombable walls"
	suffix = "necropolis_b3_watchersnest.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/b4
	name = "Bileworm nest"
	id = "b4"
	description = "12x12 bileworm's nest"
	suffix = "necropolis_b4_bilewormnest.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/b5
	name = "Dark Wizard Eldritch Horror"
	id = "b5"
	description = "15x15 Eldritch Horror (Esp que ça marche :D)"
	suffix = "necropolis_b5_eldritchhorror.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/b6
	name = "Ruins b6"
	id = "b6"
	description = "5x5 as 4 little columns"
	suffix = "necropolis_b6_columns.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/b7
	name = "Random chasm"
	id = "b7"
	description = "12x5 chasm"
	suffix = "necropolis_b7_chasm.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/b8
	name = "Random chasm short"
	id = "b8"
	description = "7x6 chasm"
	suffix = "necropolis_b8_chasm.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/b9
	name = "Random chasm huge"
	id = "b9"
	description = "24x5 chasm"
	suffix = "necropolis_b9_chasm.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/c0
	name = "Street"
	id = "c0"
	description = "24x24 street."
	suffix = "necropolis_c0_street.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/c1
	name = "Gaia"
	id = "c1"
	description = "16x16 Gaia with cores."
	suffix = "necropolis_c1_gaia.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/c2
	name = "Ruins c2"
	id = "c2"
	description = "12x12 passage."
	suffix = "necropolis_c2_passage.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/c3
	name = "Ruins c3"
	id = "c3"
	description = "12x12  passage."
	suffix = "necropolis_c3_passage.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/c4
	name = "Xeno pyramid"
	id = "c4"
	description = "24x24 Xeno pyramid."
	suffix = "necropolis_c4_xenopyramid.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/c5
	name = "Talon Rithual"
	id = "c5"
	description = "12x24 Ruins with demons."
	suffix = "necropolis_c5_talonrithual.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/c6
	name = "Ruins c6"
	id = "c6"
	description = "12x5 Burrowed road vertical."
	suffix = "necropolis_c6_road.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/c7
	name = "Ruins c7 Horizontal Road"
	id = "c7"
	description = "16x4 random road."
	suffix = "necropolis_c7_road.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/c8
	name = "Ruins c8 Vertical Road"
	id = "c8"
	description = "12x12 random road."
	suffix = "necropolis_c8_road.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/c9
	name = "Hierophant's Arena"
	id = "c9"
	description = "23x23 boss adapted."
	suffix = "necropolis_c9_hierophant.dmm"
	always_place = TRUE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/d0
	name = "Ruins d0"
	id = "d0"
	description = "10x8 crossroad."
	suffix = "necropolis_d0_crossroad.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/d1
	name = "Hermit"
	id = "d1"
	description = "12x2 hermit adapted."
	suffix = "necropolis_d1_hermit_ghostrole.dmm"
	always_place = TRUE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/d2
	name = "Ruins Tiny Oasis"
	id = "d2"
	description = "5x5 Dive in and hide from weather."
	suffix = "necropolis_d2_oasis.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/d3
	name = "Survival pod tomb"
	id = "d3"
	description = "5x5 ugh.."
	suffix = "necropolis_d3_podtomb.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/d4
	name = "Golem shipwreck"
	id = "d4"
	description = "20x10 Golem Temple shipwreck."
	suffix = "necropolis_d4_golem_ghostrole.dmm"
	always_place = TRUE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/d5
	name = "Seeding vessel"
	id = "d5"
	description = "20x10 terrarium ship ghost role"
	suffix = "necropolis_d5_podperson_ghostrole.dmm"
	always_place = TRUE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/d6
	name = "Landmine"
	id = "d6"
	description = "1x1 random landmine. Have fun."
	suffix = "necropolis_d6_landmine.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/d7
	name = "Village street vertical"
	id = "d7"
	description = "16x24 tiny village"
	suffix = "necropolis_d7_village.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/d8
	name = "Honk"
	id = "d8"
	description = "7x7 Honk"
	suffix = "necropolis_d8_honk.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/d9
	name = "Dead ratvar"
	id = "d9"
	description = "16x8 ratvar remains"
	suffix = "necropolis_d9_deadratvar.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/e0
	name = "Envy"
	id = "e0"
	description = "7x7 envy house"
	suffix = "necropolis_e0_envy.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/e1
	name = "Ufo"
	id = "e1"
	description = "18x9 ufo shipwreck"
	suffix = "necropolis_e1_ufo.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/e2
	name = "Master vein"
	id = "e2"
	description = "9x5 master skill check"
	suffix = "necropolis_e2_mastervein.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/e3
	name = "Storage"
	id = "e3"
	description = "16x8 storage with armour"
	suffix = "necropolis_e3_storage.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/e4
	name = "Barracs"
	id = "e4"
	description = "16x8 legioned barracs"
	suffix = "necropolis_e4_barracs.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/e5
	name = "Barracs"
	id = "e5"
	description = "9x9 ice demons with crystals"
	suffix = "necropolis_e5_ice.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/e6
	name = "Farm"
	id = "e6"
	description = "12x12 farm with goliathes"
	suffix = "necropolis_e6_farm.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/e7
	name = "Ruined Temple"
	id = "e7"
	description = "16x16 ruined wiz temple"
	suffix = "necropolis_e7_temple.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/e8
	name = "Ore vent"
	id = "e8"
	description = "3x3 boss multiore vent"
	suffix = "necropolis_e8_orevein_boss.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/e9
	name = "Cult corner"
	id = "e9"
	description = "12x8 litte cult rithual"
	suffix = "necropolis_e9_cult.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/f0
	name = "Rail"
	id = "f0"
	description = "12x3 minecarts with coal"
	suffix = "necropolis_f0_rail.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/f1
	name = "Weapon debris"
	id = "f1"
	description = "12x5 ancient weapon"
	suffix = "necropolis_f1_techdebris.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/f2
	name = "Ore veins"
	id = "f2"
	description = "16x16 master ore veins"
	suffix = "necropolis_f2_veins.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/f3
	name = "City part 1"
	id = "f3"
	description = "24x24 city part"
	suffix = "necropolis_f3_city1.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/f4
	name = "City part 2"
	id = "f4"
	description = "24x24 city part"
	suffix = "necropolis_f4_city2.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/f5
	name = "City part 3"
	id = "f5"
	description = "24x24 city part"
	suffix = "necropolis_f5_city3.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/f6
	name = "City part 4"
	id = "f6"
	description = "24x24 city part"
	suffix = "necropolis_f6_city4.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/f7
	name = "City part 5"
	id = "f7"
	description = "24x24 city part"
	suffix = "necropolis_f7_city5.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/f8
	name = "City part 6"
	id = "f8"
	description = "24x24 city part"
	suffix = "necropolis_f8_city6.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/f9
	name = "Hunger"
	id = "f9"
	description = "15x15 boss"
	suffix = "necropolis_f9_hunger.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/g0
	name = "Lobsters"
	id = "g0"
	description = "3x3 surprize battle"
	suffix = "necropolis_g0_lobsters.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/g1
	name = "Brim demons"
	id = "g1"
	description = "3x3 surprize battle"
	suffix = "necropolis_g1_brims.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/g2
	name = "Shipwreck"
	id = "g2"
	description = "12x7 pirate ship part"
	suffix = "necropolis_g2_shipwreck.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/g3
	name = "Rust"
	id = "g3"
	description = "9x9 rust"
	suffix = "necropolis_g3_rust.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/g4
	name = "Field vent a"
	id = "g4"
	description = "5x5 small vent"
	suffix = "necropolis_g4_vent_field_a.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/g5
	name = "Field vent b"
	id = "g5"
	description = "4x7 small vent"
	suffix = "necropolis_g5_vent_field_b.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/g6
	name = "Field vent c"
	id = "g6"
	description = "7x5 small vent"
	suffix = "necropolis_g6_vent_field_c.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/g7
	name = "Cave vent a"
	id = "g7"
	description = "7x7 medium vent"
	suffix = "necropolis_g7_vent_cave_a.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/g8
	name = "Cave vent b"
	id = "g8"
	description = "9x6 medium vent"
	suffix = "necropolis_g8_vent_cave_b.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/g9
	name = "Cave vent c"
	id = "g9"
	description = "6x9 medium vent"
	suffix = "necropolis_g9_vent_cave_c.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/h0
	name = "Temple vent a"
	id = "h0"
	description = "12x12 large vent"
	suffix = "necropolis_h0_vent_temple_a.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/h1
	name = "Temple vent b"
	id = "h1"
	description = "12x7 large vent"
	suffix = "necropolis_h1_vent_temple_b.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/h2
	name = "Temple vent c"
	id = "h2"
	description = "8x12 large vent"
	suffix = "necropolis_h2_vent_temple_c.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/h3
	name = "Road h3"
	id = "h3"
	description = "12x10 burried road"
	suffix = "necropolis_h3_road.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/h4
	name = "Road h4"
	id = "h4"
	description = "12x8 burried road"
	suffix = "necropolis_h4_road.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/h5
	name = "Road h5"
	id = "h5"
	description = "20x6 burried road"
	suffix = "necropolis_h5_road.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/h6
	name = "Road h6"
	id = "h6"
	description = "6x20 burried road"
	suffix = "necropolis_h6_road.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/h7
	name = "Road h7"
	id = "h7"
	description = "6x20 burried road"
	suffix = "necropolis_h7_road.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/h8
	name = "Supply pod"
	id = "h8"
	description = "3x3 rock n stone"
	suffix = "necropolis_h8_supply.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/h9
	name = "Goliath lair"
	id = "h9"
	description = "24x12 temple with goliaths"
	suffix = "necropolis_h9_goliathlair.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/i0
	name = "Wine chapel"
	id = "i0"
	description = "7x7 wine chapel"
	suffix = "necropolis_i0_chapel.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/i1
	name = "Ruin i1"
	id = "i1"
	description = "12x12 road with ruins"
	suffix = "necropolis_i1_struct.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/i2
	name = "Ruin i2"
	id = "i2"
	description = "12x10 road with ruins"
	suffix = "necropolis_i2_struct.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/i3
	name = "Ruin i3"
	id = "i3"
	description = "20x12 road with ruins"
	suffix = "necropolis_i3_struct.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/i4
	name = "Ruin i4"
	id = "i4"
	description = "12x20 road with ruins"
	suffix = "necropolis_i4_struct.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/i5
	name = "Ruin i5"
	id = "i5"
	description = "16x16 road with ruins"
	suffix = "necropolis_i5_struct.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/i6
	name = "Lavalake"
	id = "i6"
	description = "12x12 lobster lake"
	suffix = "necropolis_i6_lavalake.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/i7
	name = "Bridges"
	id = "i7"
	description = "20x12 bridges"
	suffix = "necropolis_i7_bridges.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/i8
	name = "Ruin i8"
	id = "i8"
	description = "5x5 random ruin"
	suffix = "necropolis_i8_ruins.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/i9
	name = "Ship debris"
	id = "i9"
	description = "9x6 random ruin"
	suffix = "necropolis_i9_shipdebris.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/j0
	name = "Clockwork"
	id = "j0"
	description = "16x12 ratvar reactor"
	suffix = "necropolis_j0_clockwork.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/j1
	name = "Gore"
	id = "j1"
	description = "12x12 worm meteor"
	suffix = "necropolis_j1_gore.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/j2
	name = "Ruin j2"
	id = "j2"
	description = "12x12 random ruins hollow"
	suffix = "necropolis_j2_ruins.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/j3
	name = "Ruin j3"
	id = "j3"
	description = "12x12 random ruins hollow"
	suffix = "necropolis_j3_ruins.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/j4
	name = "Ruin j4"
	id = "j4"
	description = "12x12 random ruins hollow"
	suffix = "necropolis_j4_ruins.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/j5
	name = "Ruin j5"
	id = "j5"
	description = "7x7 random ruin (5 brims)"
	suffix = "necropolis_j5_ruins.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/j6
	name = "Ruin j6"
	id = "j6"
	description = "6x12 random ruin"
	suffix = "necropolis_j6_ruins.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/j7
	name = "Ruin j7"
	id = "j7"
	description = "16x3 random ruin with chains"
	suffix = "necropolis_j7_chains.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/j8
	name = "Ruin j8"
	id = "j8"
	description = "6x8 melting ruins"
	suffix = "necropolis_j8_melting.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/j9
	name = "Cargo debris"
	id = "j9"
	description = "7x5 drug shipping debris"
	suffix = "necropolis_j9_cargodebris.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/k0
	name = "Gate"
	id = "k0"
	description = "24x5 wall with gate"
	suffix = "necropolis_k0_gate.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/k1
	name = "Thermes"
	id = "k1"
	description = "12x9 baths"
	suffix = "necropolis_k1_thermes.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/k2
	name = "Ruins k2"
	id = "k2"
	description = "7x7 ruins grid"
	suffix = "necropolis_k2_ruins.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/k3
	name = "Ruins k3"
	id = "k3"
	description = "9x12 bridge like ruine"
	suffix = "necropolis_k3_ruins.dmm"
	always_place = FALSE
	allow_duplicates = FALSE

































//Old lavaland:


// Hey! Listen! Update \config\lavaruinblacklist.txt with your new ruins!

// /datum/map_template/ruin/lavaland
// 	ruin_type = ZTRAIT_LAVA_RUINS
// 	prefix = "_maps/RandomRuins/LavaRuins/"
// 	default_area = /area/lavaland/surface/outdoors/unexplored

// /datum/map_template/ruin/lavaland/biodome
// 	cost = 5
// 	allow_duplicates = FALSE

// /datum/map_template/ruin/lavaland/biodome/beach
// 	name = "Lava-Ruin Biodome Beach"
// 	id = "biodome-beach"
// 	description = "Seemingly plucked from a tropical destination, this beach is calm and cool, with the salty waves roaring softly in the background. \
// 	Comes with a rustic wooden bar and suicidal bartender."
// 	suffix = "lavaland_biodome_beach.dmm"

// /datum/map_template/ruin/lavaland/biodome/winter
// 	name = "Lava-Ruin Biodome Winter"
// 	id = "biodome-winter"
// 	description = "For those getaways where you want to get back to nature, but you don't want to leave the fortified military compound where you spend your days. \
// 	Includes a unique(*) laser pistol display case, and the recently introduced I.C.E(tm)."
// 	suffix = "lavaland_surface_biodome_winter.dmm"

// /datum/map_template/ruin/lavaland/biodome/clown
// 	name = "Lava-Ruin Biodome Clown Planet"
// 	id = "biodome-clown"
// 	description = "WELCOME TO CLOWN PLANET! HONK HONK HONK etc.!"
// 	suffix = "lavaland_biodome_clown_planet.dmm"

// /datum/map_template/ruin/lavaland/lizgas
// 	name = "Lava-Ruin The Lizard's Gas"
// 	id = "lizgas2"
// 	description = "A recently opened gas station from the Lizard's Gas franchise."
// 	suffix = "lavaland_surface_gas.dmm"
// 	allow_duplicates = FALSE

// /datum/map_template/ruin/lavaland/cube
// 	name = "Lava-Ruin The Wishgranter Cube"
// 	id = "wishgranter-cube"
// 	description = "Nothing good can come from this. Learn from their mistakes and turn around."
// 	suffix = "lavaland_surface_cube.dmm"
// 	cost = 10
// 	allow_duplicates = FALSE

// /datum/map_template/ruin/lavaland/seed_vault
// 	name = "Lava-Ruin Seed Vault"
// 	id = "seed-vault"
// 	description = "The creators of these vaults were a highly advanced and benevolent race, and launched many into the stars, hoping to aid fledgling civilizations. \
// 	However, all the inhabitants seem to do is grow drugs and guns."
// 	suffix = "lavaland_surface_seed_vault.dmm"
// 	cost = 10
// 	allow_duplicates = FALSE

// // NOVA EDIT REMOVAL BEGIN - MAPPING
// /*
// /datum/map_template/ruin/lavaland/ash_walker
// 	name = "Lava-Ruin Ash Walker Nest"
// 	id = "ash-walker"
// 	description = "A race of unbreathing lizards live here, that run faster than a human can, worship a broken dead city, and are capable of reproducing by something involving tentacles? \
// 	Probably best to stay clear."
// 	suffix = "lavaland_surface_ash_walker1.dmm"
// 	cost = 20
// 	allow_duplicates = FALSE

// /datum/map_template/ruin/lavaland/syndicate_base
// 	name = "Lava-Ruin Syndicate Lava Base"
// 	id = "lava-base"
// 	description = "A secret base researching illegal bioweapons, it is closely guarded by an elite team of syndicate agents."
// 	suffix = "lavaland_surface_syndicate_base1.dmm"
// 	cost = 20
// 	allow_duplicates = FALSE
// */
// //NOVA EDIT REMOVAL END

// /datum/map_template/ruin/lavaland/free_golem
// 	name = "Lava-Ruin Free Golem Ship"
// 	id = "golem-ship"
// 	description = "Lumbering humanoids, made out of precious metals, move inside this ship. They frequently leave to mine more minerals, which they somehow turn into more of them. \
// 	Seem very intent on research and individual liberty, and also geology-based naming?"
// 	cost = 20
// 	prefix = "_maps/RandomRuins/AnywhereRuins/"
// 	suffix = "golem_ship.dmm"
// 	allow_duplicates = FALSE

// /datum/map_template/ruin/lavaland/gaia
// 	name = "Lava-Ruin Patch of Eden"
// 	id = "gaia"
// 	description = "Who would have thought that such a peaceful place could be on such a horrific planet?"
// 	cost = 5
// 	suffix = "lavaland_surface_gaia.dmm"
// 	allow_duplicates = FALSE

// /datum/map_template/ruin/lavaland/sin
// 	cost = 10
// 	allow_duplicates = FALSE

// /datum/map_template/ruin/lavaland/sin/envy
// 	name = "Lava-Ruin Ruin of Envy"
// 	id = "envy"
// 	description = "When you get what they have, then you'll finally be happy."
// 	suffix = "lavaland_surface_envy.dmm"

// /datum/map_template/ruin/lavaland/sin/gluttony
// 	name = "Lava-Ruin Ruin of Gluttony"
// 	id = "gluttony"
// 	description = "If you eat enough, then eating will be all that you do."
// 	suffix = "lavaland_surface_gluttony.dmm"

// /datum/map_template/ruin/lavaland/sin/greed
// 	name = "Lava-Ruin Ruin of Greed"
// 	id = "greed"
// 	description = "Sure you don't need magical powers, but you WANT them, and \
// 		that's what's important."
// 	suffix = "lavaland_surface_greed.dmm"

// /datum/map_template/ruin/lavaland/sin/pride
// 	name = "Lava-Ruin Ruin of Pride"
// 	id = "pride"
// 	description = "Wormhole lifebelts are for LOSERS, whom you are better than."
// 	suffix = "lavaland_surface_pride.dmm"

// /datum/map_template/ruin/lavaland/sin/sloth
// 	name = "Lava-Ruin Ruin of Sloth"
// 	id = "sloth"
// 	description = "..."
// 	suffix = "lavaland_surface_sloth.dmm"
// 	// Generates nothing but atmos runtimes and salt
// 	cost = 0

// /datum/map_template/ruin/lavaland/ratvar
// 	name = "Lava-Ruin Dead God"
// 	id = "ratvar"
// 	description = "Ratvar's final resting place."
// 	suffix = "lavaland_surface_dead_ratvar.dmm"
// 	cost = 0
// 	allow_duplicates = FALSE

// /datum/map_template/ruin/lavaland/hierophant
// 	name = "Lava-Ruin Hierophant's Arena"
// 	id = "hierophant"
// 	description = "A strange, square chunk of metal of massive size. Inside awaits only death and many, many squares."
// 	suffix = "lavaland_surface_hierophant.dmm"
// 	always_place = TRUE
// 	allow_duplicates = FALSE

// /datum/map_template/ruin/lavaland/blood_drunk_miner
// 	name = "Lava-Ruin Blood-Drunk Miner"
// 	id = "blooddrunk"
// 	description = "A strange arrangement of stone tiles and an insane, beastly miner contemplating them."
// 	suffix = "lavaland_surface_blooddrunk1.dmm"
// 	cost = 0
// 	allow_duplicates = FALSE //will only spawn one variant of the ruin

// /datum/map_template/ruin/lavaland/blood_drunk_miner/guidance
// 	name = "Lava-Ruin Blood-Drunk Miner (Guidance)"
// 	suffix = "lavaland_surface_blooddrunk2.dmm"

// /datum/map_template/ruin/lavaland/blood_drunk_miner/hunter
// 	name = "Lava-Ruin Blood-Drunk Miner (Hunter)"
// 	suffix = "lavaland_surface_blooddrunk3.dmm"

// /datum/map_template/ruin/lavaland/blood_drunk_miner/random
// 	name = "Lava-Ruin Blood-Drunk Miner (Random)"
// 	suffix = null
// 	always_place = TRUE

// /datum/map_template/ruin/lavaland/blood_drunk_miner/random/New()
// 	suffix = pick("lavaland_surface_blooddrunk1.dmm", "lavaland_surface_blooddrunk2.dmm", "lavaland_surface_blooddrunk3.dmm")
// 	return ..()

// /datum/map_template/ruin/lavaland/ufo_crash
// 	name = "Lava-Ruin UFO Crash"
// 	id = "ufo-crash"
// 	description = "Turns out that keeping your abductees unconscious is really important. Who knew?"
// 	suffix = "lavaland_surface_ufo_crash.dmm"
// 	cost = 5

// /datum/map_template/ruin/lavaland/xeno_nest
// 	name = "Lava-Ruin Xenomorph Nest"
// 	id = "xeno-nest"
// 	description = "These xenomorphs got bored of horrifically slaughtering people on space stations, and have settled down on a nice lava-filled hellscape to focus on what's really important in life. \
// 	Quality memes."
// 	suffix = "lavaland_surface_xeno_nest.dmm"
// 	cost = 20

// /datum/map_template/ruin/lavaland/fountain
// 	name = "Lava-Ruin Fountain Hall"
// 	id = "lava_fountain"
// 	description = "The fountain has a warning on the side. DANGER: May have undeclared side effects that only become obvious when implemented."
// 	prefix = "_maps/RandomRuins/AnywhereRuins/"
// 	suffix = "fountain_hall.dmm"
// 	cost = 5

// /datum/map_template/ruin/lavaland/survivalcapsule
// 	name = "Lava-Ruin Survival Capsule Ruins"
// 	id = "survivalcapsule"
// 	description = "What was once sanctuary to the common miner, is now their tomb."
// 	suffix = "lavaland_surface_survivalpod.dmm"
// 	cost = 5

// /datum/map_template/ruin/lavaland/pizza
// 	name = "Lava-Ruin Ruined Pizza Party"
// 	id = "pizza"
// 	description = "Little Timmy's birthday pizza bash took a turn for the worse when a bluespace anomaly passed by."
// 	suffix = "lavaland_surface_pizzaparty.dmm"
// 	allow_duplicates = FALSE
// 	cost = 5

// /datum/map_template/ruin/lavaland/cultaltar
// 	name = "Lava-Ruin Summoning Ritual"
// 	id = "cultaltar"
// 	description = "A place of vile worship, the scrawling of blood in the middle glowing eerily. A demonic laugh echoes throughout the caverns."
// 	suffix = "lavaland_surface_cultaltar.dmm"
// 	allow_duplicates = FALSE
// 	cost = 10

// /datum/map_template/ruin/lavaland/hermit
// 	name = "Lava-Ruin Makeshift Shelter"
// 	id = "hermitcave"
// 	description = "A place of shelter for a lone hermit, scraping by to live another day."
// 	suffix = "lavaland_surface_hermit.dmm"
// 	allow_duplicates = FALSE
// 	cost = 10

// /datum/map_template/ruin/lavaland/miningripley
// 	name = "Lava-Ruin Ripley"
// 	id = "ripley"
// 	description = "A heavily-damaged mining ripley, property of a very unfortunate miner. You might have to do a bit of work to fix this thing up."
// 	suffix = "lavaland_surface_random_ripley.dmm"
// 	allow_duplicates = FALSE
// 	cost = 5

// /datum/map_template/ruin/lavaland/dark_wizards
// 	name = "Lava-Ruin Dark Wizard Altar"
// 	id = "dark_wizards"
// 	description = "A ruin with dark wizards. What secret do they guard?"
// 	suffix = "lavaland_surface_wizard.dmm"
// 	cost = 5

// /datum/map_template/ruin/lavaland/strong_stone
// 	name = "Lava-Ruin Strong Stone"
// 	id = "strong_stone"
// 	description = "A stone that seems particularly powerful."
// 	suffix = "lavaland_strong_rock.dmm"
// 	allow_duplicates = FALSE
// 	cost = 2

// /datum/map_template/ruin/lavaland/puzzle
// 	name = "Lava-Ruin Ancient Puzzle"
// 	id = "puzzle"
// 	description = "Mystery to be solved."
// 	suffix = "lavaland_surface_puzzle.dmm"
// 	cost = 5

// /datum/map_template/ruin/lavaland/elite_tumor
// 	name = "Lava-Ruin Pulsating Tumor"
// 	id = "tumor"
// 	description = "A strange tumor which houses a powerful beast..."
// 	suffix = "lavaland_surface_elite_tumor.dmm"
// 	cost = 5
// 	always_place = TRUE
// 	allow_duplicates = TRUE

// /datum/map_template/ruin/lavaland/elephant_graveyard
// 	name = "Lava-Ruin Elephant Graveyard"
// 	id = "Graveyard"
// 	description = "An abandoned graveyard, calling to those unable to continue."
// 	suffix = "lavaland_surface_elephant_graveyard.dmm"
// 	allow_duplicates = FALSE
// 	cost = 10

// /datum/map_template/ruin/lavaland/bileworm_nest
// 	name = "Lava-Ruin Bileworm Nest"
// 	id = "bileworm_nest"
// 	description = "A small sanctuary from the harsh wilderness... if you're a bileworm, that is."
// 	cost = 5
// 	suffix = "lavaland_surface_bileworm_nest.dmm"
// 	allow_duplicates = FALSE

// /datum/map_template/ruin/lavaland/lava_phonebooth
// 	name = "Lava-Ruin Phonebooth"
// 	id = "lava_phonebooth"
// 	description = "A venture by nanotrasen to help popularize the use of holopads. This one somehow made its way here."
// 	suffix = "lavaland_surface_phonebooth.dmm"
// 	allow_duplicates = FALSE
// 	cost = 5

// /datum/map_template/ruin/lavaland/battle_site
// 	name = "Lava-Ruin Battle Site"
// 	id = "battle_site"
// 	description = "The long past site of a battle between beast and humanoids. The victor is unknown, but the losers are clear."
// 	suffix = "lavaland_battle_site.dmm"
// 	allow_duplicates = TRUE
// 	cost = 3

// /datum/map_template/ruin/lavaland/vent
// 	name = "Lava-Ruin Ore Vent"
// 	id = "ore_vent"
// 	description = "A vent that spews out ore. Seems to be a natural phenomenon."
// 	suffix = "lavaland_surface_ore_vent.dmm"
// 	allow_duplicates = TRUE
// 	cost = 0
// 	mineral_cost = 1
// 	always_place = TRUE

// /datum/map_template/ruin/lavaland/watcher_grave
// 	name = "Lava-Ruin Watchers' Grave"
// 	id = "watcher-grave"
// 	description = "A lonely cave where an orphaned child awaits a new parent."
// 	suffix = "lavaland_surface_watcher_grave.dmm"
// 	cost = 5
// 	allow_duplicates = FALSE

// /datum/map_template/ruin/lavaland/mook_village
// 	name = "Lava-Ruin Mook Village"
// 	id = "mook_village"
// 	description = "A village hosting a community of friendly mooks!"
// 	suffix = "lavaland_surface_mookvillage.dmm"
// 	allow_duplicates = FALSE
// 	cost = 5
