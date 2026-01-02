/datum/vote/map_vote
	count_method = VOTE_COUNT_METHOD_SINGLE
	winner_method = VOTE_WINNER_METHOD_SIMPLE
	display_statistics = TRUE

/datum/vote/map_vote/finalize_vote(winning_option)
	var/datum/map_config/winning_map = global.config.maplist[winning_option]
	if(!istype(winning_map))
		CRASH("[type] wasn't passed a valid winning map choice. (Got: [winning_option || "null"] - [winning_map || "null"])")

	SSmap_vote.set_next_map(winning_map)
	SSmap_vote.already_voted = TRUE

