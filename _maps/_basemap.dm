//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\Birdshot\birdshot.dmm"
		#include "map_files\debug\multiz.dmm"
		#include "map_files\debug\runtimestation.dmm"
		#include "map_files\Deltastation\DeltaStation2.dmm"
		#include "map_files\IceBoxStation\IceBoxStation.dmm"
		#include "map_files\MetaStation\MetaStation.dmm"
		#include "map_files\Mining\Lavaland.dmm"
		#include "map_files\tramstation\tramstation.dmm"
		#include "map_files\NebulaStation\NebulaStation.dmm"
		#include "map_files\wawastation\wawastation.dmm"
		// NOVA EDIT ADDITON START - Compiling our modular maps too!
		#include "map_files\VoidRaptor\VoidRaptor.dmm"
		#include "map_files\NSVBlueshift\Blueshift.dmm"
		#include "map_files\Ouroboros\Ouroboros.dmm"
		#include "map_files\SerenityStation\SerenityStation.dmm"
		// NOVA EDIT END
		// FLUFFY FRONTIER ADDITION START
		#include "map_files\NSSJourney\NSSJourney.dmm"
		#include "map_files\KiloStation2\KiloStation2.dmm"
		// FLUFFY FRONTIER ADDITION END

		#ifdef CIBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif
