/datum/map_template/ruin/lavaland/interdyne
	name = "Interdyne Pharmaceutics Frontier Base 3c76928"
	id = "interdyne-base"
	description = "A planetside Interdyne research facility developing biological weapons; it is closely guarded by an elite team of agents."
	prefix = "_maps/RandomRuins/LavaRuins/fluffy/"
	suffix = "lavaland_interdyne_base_ff.dmm"
	allow_duplicates = FALSE
	always_place = FALSE
	never_spawn_with = list(
		/datum/map_template/ruin/space/nova/blackmarket,
		/datum/map_template/ruin/space/nova/escapefromtarkon,
		/datum/map_template/ruin/space/nova/cargodiselost,
		/datum/map_template/ruin/space/nova/des_two,)

/datum/map_template/ruin/icemoon/underground/interdyne
	name = "Interdyne Pharmaceuticals Frontier Base 8817238"
	id = "interdyne-base"
	description = "A planetside Interdyne research facility developing biological weapons; it is closely guarded by an elite team of agents."
	prefix = "_maps/RandomRuins/IceRuins/fluffy/"
	suffix = "icemoon_interdyne_base_ff.dmm"
	allow_duplicates = FALSE
	always_place = FALSE
	never_spawn_with = list(
		/datum/map_template/ruin/lavaland/nova/interdyne_base,
		/datum/map_template/ruin/space/nova/blackmarket,
		/datum/map_template/ruin/space/nova/escapefromtarkon,
		/datum/map_template/ruin/space/nova/cargodiselost,
		/datum/map_template/ruin/space/nova/des_two,)

/turf/open/floor/plating/reinforced/lavaland
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS

/turf/open/floor/plating/reinforced/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/open/floor/engine/hull/reinforced/lavaland
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS

/turf/open/floor/engine/hull/reinforced/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
