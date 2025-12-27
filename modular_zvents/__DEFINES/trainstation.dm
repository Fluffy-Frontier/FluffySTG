#define TRAIN_STATION_DMM_DIR(_filename) ("_maps/modular_events/trainstation/" + _filename)

#define ZTRAIT_TRAINSTATION "Trainstation"
#define NO_TURF_MOVEMENT (1<<32)

#define COMSIG_TRAIN_BEGIN_MOVING "train_begin_moving"
#define COMSIG_TRAIN_STOP_MOVING "train_stop_moving"
#define COMSIG_TRAIN_TRY_MOVE "train_try_move"
	#define COMPONENT_BLOCK_TRAIN_MOVEMENT (1 << 2)

#define TRAIT_NO_STATION_UNLOAD "!no_unload"
