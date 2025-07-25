/datum/mining_encounter
	var/name = null
	var/info = null
	var/rarity_tier = 0
	var/no_pick = FALSE //If 1, encounter will not be randomly picked and will not be sorted into rarity lists. Will still appear in "all" list. Used for telescope encounters.

/datum/mining_encounter/proc/generate(var/obj/magnet_target_marker/target)
	return

/datum/mining_encounter/proc/create_round_asteroid(obj/magnet_target_marker/target)
	if(!istype(target))
		return
	var/list/generated_turfs = list()
	var/size = min(rand(SSmagnet_mining.min_magnet_spawn_size, SSmagnet_mining.max_magnet_spawn_size), min(target.width,target.height))
	generated_turfs = Turfspawn_Asteroid_Round(SSmagnet_mining.magnetic_center, /turf/closed/mineral/asteroid, size, 0)

	return generated_turfs

/datum/mining_encounter/proc/Turfspawn_Asteroid_Round(var/turf/open/space/center, var/base_rock = /turf/closed/mineral/asteroid, var/size = 8, var/hollow = 0)
	if(!istype(center))
		return list()
	if(!isnum(size) || size < 1)
		size = rand(5, 15)

	var/current_range = 0
	var/list/generated_turfs = list()

	var/turf/closed/mineral/asteroid/rock_dummy = base_rock
	var/floor_type = initial(rock_dummy.baseturfs)
	var/turf/A = locate(center.x, center.y, center.z)
	if(hollow)
		A = A.ChangeTurf(floor_type)
	else
		A = A.ChangeTurf(base_rock)
	generated_turfs += A
	var/turf/closed/mineral/asteroid/B
	var/turf/open/misc/asteroid/airless/F

	var/corner_range = round(size * 1.5)
	var/total_distance = 0

	var/stone_color

	while(current_range < size - 1)
		current_range++
		total_distance = 0
		for (var/turf/open/space/S in range(current_range,A))
			if (get_dist(S,A) == current_range)
				if (S in SSmagnet_mining.asteroid_blocked_turfs)
					continue
				total_distance = abs(A.x - S.x) + abs(A.y - S.y) + (current_range / 2)
				if (total_distance > corner_range)
					continue
				if (hollow && total_distance < size / 2)
					var/turf/T = locate(S.x, S.y, S.z)
					F = T.ChangeTurf(floor_type)
					generated_turfs += F
				else
					var/turf/T = locate(S.x, S.y, S.z)
					B = T.ChangeTurf(base_rock)
					generated_turfs += B


		for (var/turf/open/misc/asteroid/airless/FLOOR in generated_turfs)
			FLOOR.color = stone_color

	return generated_turfs

/datum/mining_encounter/asteroid_small
	name = "Small Asteroid"
	rarity_tier = -1

/datum/mining_encounter/asteroid_small/generate(var/obj/magnet_target_marker/target)
	if(!target)
		return FALSE
	var/size = 3
	var/magnetic_center = target.magnetic_center

	Turfspawn_Asteroid_Round(magnetic_center, /turf/closed/mineral/random, size, FALSE)

/datum/mining_encounter/asteroid
	var/base_rock = /turf/closed/mineral/random

/datum/mining_encounter/asteroid/generate(var/obj/magnet_target_marker/target)
	if(!target)
		return FALSE
	var/size = rand(SSmagnet_mining.min_magnet_spawn_size, SSmagnet_mining.max_magnet_spawn_size)
	var/magnetic_center = target.magnetic_center
	Turfspawn_Asteroid_Round(magnetic_center, base_rock, size, prob(50))

/datum/mining_encounter/asteroid/common
	name = "Asteroid"
	info = "One big asteroid with bunch of minerals in it."
	rarity_tier = 1
	base_rock = /turf/closed/mineral/random/low_chance

/datum/mining_encounter/asteroid/uncommon
	name = "Rich Asteroid"
	info = "One big asteroid with bunch of minerals in it."
	rarity_tier = 2
	base_rock = /turf/closed/mineral/random

/datum/mining_encounter/asteroid/rare
	name = "Very Rich Asteroid"
	info = "One big asteroid with bunch of minerals in it."
	rarity_tier = 3
	base_rock = /turf/closed/mineral/random/high_chance

/datum/mining_encounter/tamplate
	var/datum/map_template/template
	var/mapfile

/datum/mining_encounter/tamplate/New()
	template = new(mapfile, name)

/datum/mining_encounter/tamplate/generate(var/obj/magnet_target_marker/target)
	template.load(locate(target.x + 1, target.y + 1, target.z), centered = FALSE)

/datum/mining_encounter/tamplate/iron
	name = "Iron asteroid"
	info = "Pure cluster of iron ore."
	rarity_tier = 1
	mapfile = 'tff_modular/modules/mining_magnet/_maps/mining_encounter/pure/iron.dmm'

/datum/mining_encounter/tamplate/bananium
	name = "Banana asteroid"
	info = "Pure cluster pure clown delight."
	rarity_tier = 3
	mapfile = 'tff_modular/modules/mining_magnet/_maps/mining_encounter/pure/bananium.dmm'

/datum/mining_encounter/tamplate/bscrystal
	name = "Bluespace asteroid"
	info = "Pure cluster of bluespace crystals."
	rarity_tier = 3
	mapfile = 'tff_modular/modules/mining_magnet/_maps/mining_encounter/pure/bscrystal.dmm'

/datum/mining_encounter/tamplate/diamond
	name = "Diamond asteroids"
	info = "Cluster of diamonds shards."
	rarity_tier = 3
	mapfile = 'tff_modular/modules/mining_magnet/_maps/mining_encounter/pure/diamonds.dmm'

/datum/mining_encounter/tamplate/plasma
	name = "Plasma asteroid"
	info = "Pure cluster of hot plasma."
	rarity_tier = 2
	mapfile = 'tff_modular/modules/mining_magnet/_maps/mining_encounter/pure/plasma.dmm'

/datum/mining_encounter/tamplate/silver
	name = "Silver asteroid"
	info = "Vein of silver inside of asteroid"
	rarity_tier = 1
	mapfile = 'tff_modular/modules/mining_magnet/_maps/mining_encounter/pure/silver.dmm'

/datum/mining_encounter/tamplate/titanium
	name = "Titanium asteroids"
	info = "Cubic formation of titanium asteroids"
	rarity_tier = 3
	mapfile = 'tff_modular/modules/mining_magnet/_maps/mining_encounter/pure/titanium.dmm'

/datum/mining_encounter/tamplate/uranium
	name = "Uranium asteroid"
	info = "Cluster with most natural formation of nukeclear warfare"
	rarity_tier = 2
	mapfile = 'tff_modular/modules/mining_magnet/_maps/mining_encounter/pure/uranium.dmm'

/datum/mining_encounter/tamplate/uranium
	name = "Gold asteroid"
	info = "We are rich!"
	rarity_tier = 2
	mapfile = 'tff_modular/modules/mining_magnet/_maps/mining_encounter/pure/gold.dmm'

/datum/mining_encounter/tamplate/random_common
	name = "Asteroid formation"
	info = "Bunch of asteroid with mixed insides"
	rarity_tier = 1
	mapfile = 'tff_modular/modules/mining_magnet/_maps/mining_encounter/random/common.dmm'

/datum/mining_encounter/tamplate/random_uncommon
	name = "Rich Asteroid formation"
	info = "Bunch of asteroid with rich mixed insides"
	rarity_tier = 2
	mapfile = 'tff_modular/modules/mining_magnet/_maps/mining_encounter/random/uncommon.dmm'

/datum/mining_encounter/tamplate/random_rare
	name = "Very Rich Asteroid formation"
	info = "Bunch of asteroid with very rich mixed insides"
	rarity_tier = 3
	mapfile = 'tff_modular/modules/mining_magnet/_maps/mining_encounter/random/rare.dmm'
