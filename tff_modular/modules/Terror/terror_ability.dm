/datum/action/cooldown/spell/wall_spider
	name = "Spider Barricade"
	desc = "Create a web barrier that only spider can pass."
	button_icon_state = "shield"

	sound = 'sound/effects/magic/forcewall.ogg'
	school = SCHOOL_TRANSMUTATION
	cooldown_time = 15 SECONDS

	/// The typepath to the wall we create on cast.
	var/wall_type = /obj/structure/spider/stickyweb/sealed/tough

/datum/action/cooldown/spell/wall_spider/cast(atom/cast_on)
	. = ..()
	for(var/turf/cast_turf as anything in get_turfs())
		spawn_wall(cast_turf)

/// This proc returns all the turfs on which we will spawn the walls.
/datum/action/cooldown/spell/wall_spider/proc/get_turfs()
	return list(get_turf(owner), get_step(owner, turn(owner.dir, 90)), get_step(owner, turn(owner.dir, 270)))

/// This proc spawns a wall on the given turf.
/datum/action/cooldown/spell/wall_spider/proc/spawn_wall(turf/cast_turf)
	new wall_type(cast_turf, owner)
