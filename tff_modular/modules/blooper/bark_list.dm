/datum/bark/mutedc2
	name = "Muted String (Low)"
	id = "mutedc2"
	soundpath = 'sound/runtime/instruments/synthesis_samples/guitar/crisis_muted/C2.ogg'
	allow_random = TRUE

/datum/bark/mutedc3
	name = "Muted String (Medium)"
	id = "mutedc3"
	soundpath = 'sound/runtime/instruments/synthesis_samples/guitar/crisis_muted/C3.ogg'
	allow_random = TRUE

/datum/bark/mutedc4
	name = "Muted String (High)"
	id = "mutedc4"
	soundpath = 'sound/runtime/instruments/synthesis_samples/guitar/crisis_muted/C4.ogg'
	allow_random = TRUE

/datum/bark/banjoc3
	name = "Banjo (Medium)"
	id = "banjoc3"
	soundpath = 'sound/runtime/instruments/banjo/Cn3.ogg'
	allow_random = TRUE

/datum/bark/banjoc4
	name = "Banjo (High)"
	id = "banjoc4"
	soundpath = 'sound/runtime/instruments/banjo/Cn4.ogg'
	allow_random = TRUE

/datum/bark/squeaky
	name = "Squeaky"
	id = "squeak"
	soundpath = 'sound/items/toysqueak1.ogg'
	maxspeed = 4

/datum/bark/beep
	name = "Beepy"
	id = "beep"
	soundpath = 'sound/machines/terminal_select.ogg'
	maxpitch = 1 //Bringing the pitch higher just hurts your ears :<
	maxspeed = 4 //This soundbyte's too short for larger speeds to not sound awkward

/datum/bark/chitter
	name = "Chittery"
	id = "chitter"
	minspeed = 4 //Even with the sound being replaced with a unique, shorter sound, this is still a little too long for higher speeds
	soundpath = 'tff_modular/modules/blooper/voice/barks/chitter.ogg'

/datum/bark/synthetic_grunt
	name = "Synthetic (Grunt)"
	id = "synthgrunt"
	soundpath = 'sound/misc/bloop.ogg'

/datum/bark/synthetic
	name = "Synthetic (Normal)"
	id = "synth"
	soundpath = 'sound/machines/uplinkerror.ogg'

/datum/bark/bullet
	name = "Windy"
	id = "bullet"
	maxpitch = 1.6
	soundpath = 'sound/weapons/bulletflyby.ogg'

/datum/bark/coggers
	name = "Brassy"
	id = "coggers"
	soundpath = 'sound/machines/clockcult/integration_cog_install.ogg'

/datum/bark/moff/short
	name = "Moff squeak"
	id = "moffsqueak"
	soundpath = 'tff_modular/modules/blooper/voice/barks/mothsqueak.ogg'
	allow_random = TRUE
	ignore = FALSE

/datum/bark/meow //Meow bark?
	name = "Meow"
	id = "meow"
	allow_random = TRUE
	soundpath = 'tff_modular/modules/blooper/voice/barks/meow1.ogg'
	minspeed = 5
	maxspeed = 11

/datum/bark/chirp
	name = "Chirp"
	id = "chirp"
	allow_random = TRUE
	soundpath = 'tff_modular/modules/blooper/voice/barks/chirp.ogg'

/datum/bark/caw
	name = "Caw"
	id = "caw"
	allow_random = TRUE
	soundpath = 'tff_modular/modules/blooper/voice/barks/caw.ogg'

//Undertale
/datum/bark/alphys
	name = "Alphys"
	id = "alphys"
	soundpath = 'tff_modular/modules/blooper/voice/barks/undertale/voice_alphys.ogg'
	minvariance = 0

/datum/bark/asgore
	name = "Asgore"
	id = "asgore"
	soundpath = 'tff_modular/modules/blooper/voice/barks/undertale/voice_asgore.ogg'
	minvariance = 0

/datum/bark/flowey
	name = "Flowey (normal)"
	id = "flowey1"
	soundpath = 'tff_modular/modules/blooper/voice/barks/undertale/voice_flowey_1.ogg'
	minvariance = 0

/datum/bark/flowey/evil
	name = "Flowey (evil)"
	id = "flowey2"
	soundpath = 'tff_modular/modules/blooper/voice/barks/undertale/voice_flowey_2.ogg'
	minvariance = 0

/datum/bark/papyrus
	name = "Papyrus"
	id = "papyrus"
	soundpath = 'tff_modular/modules/blooper/voice/barks/undertale/voice_papyrus.ogg'
	minvariance = 0

/datum/bark/ralsei
	name = "Ralsei"
	id = "ralsei"
	soundpath = 'tff_modular/modules/blooper/voice/barks/undertale/voice_ralsei.ogg'
	minvariance = 0

/datum/bark/sans //real
	name = "Sans"
	id = "sans"
	soundpath = 'tff_modular/modules/blooper/voice/barks/undertale/voice_sans.ogg'
	minvariance = 0

/datum/bark/toriel
	name = "Toriel"
	id = "toriel"
	soundpath = 'tff_modular/modules/blooper/voice/barks/undertale/voice_toriel.ogg'
	minvariance = 0
	maxpitch = BARK_DEFAULT_MAXPITCH*2

/datum/bark/undyne
	name = "Undyne"
	id = "undyne"
	soundpath = 'tff_modular/modules/blooper/voice/barks/undertale/voice_undyne.ogg'
	minvariance = 0

/datum/bark/temmie
	name = "Temmie"
	id = "temmie"
	soundpath = 'tff_modular/modules/blooper/voice/barks/undertale/voice_temmie.ogg'
	minvariance = 0

/datum/bark/susie
	name = "Susie"
	id = "susie"
	soundpath = 'tff_modular/modules/blooper/voice/barks/undertale/voice_susie.ogg'
	minvariance = 0

/datum/bark/gaster
	name = "Gaster"
	id = "gaster"
	soundpath = 'tff_modular/modules/blooper/voice/barks/undertale/voice_gaster_1.ogg'
	minvariance = 0

/datum/bark/mettaton
	name = "Mettaton"
	id = "mettaton"
	soundpath = 'tff_modular/modules/blooper/voice/barks/undertale/voice_metta_1.ogg'
	minvariance = 0

/datum/bark/gen_monster
	name = "Generic Monster 1"
	id = "gen_monster_1"
	soundpath = 'tff_modular/modules/blooper/voice/barks/undertale/voice_monster1.ogg'
	minvariance = 0

/datum/bark/gen_monster/alt
	name = "Generic Monster 2"
	id = "gen_monster_2"
	soundpath = 'tff_modular/modules/blooper/voice/barks/undertale/voice_monster2.ogg'
	minvariance = 0

/datum/bark/wilson
	name = "Wilson"
	id = "wilson"
	soundpath = 'tff_modular/modules/blooper/voice/barks/dont_starve/wilson_bark.ogg'

/datum/bark/wolfgang
	name = "Wolfgang"
	id = "wolfgang"
	soundpath = 'tff_modular/modules/blooper/voice/barks/dont_starve/wolfgang_bark.ogg'
	minspeed = 4
	maxspeed = 10

/datum/bark/woodie
	name = "Woodie"
	id = "woodie"
	soundpath = 'tff_modular/modules/blooper/voice/barks/dont_starve/woodie_bark.ogg'
	minspeed = 4
	maxspeed = 10

/datum/bark/wurt
	name = "Wurt"
	id = "wurt"
	soundpath = 'tff_modular/modules/blooper/voice/barks/dont_starve/wurt_bark.ogg'

/datum/bark/wx78
	name = "wx78"
	id = "wx78"
	soundpath = 'tff_modular/modules/blooper/voice/barks/dont_starve/wx78_bark.ogg'
	minspeed = 3
	maxspeed = 9

/datum/bark/blub
	name = "Blub"
	id = "blub"
	soundpath = 'tff_modular/modules/blooper/voice/barks/goon/blub.ogg'

/datum/bark/bottalk
	name = "Bottalk 1"
	id = "bottalk1"
	soundpath = 'tff_modular/modules/blooper/voice/barks/goon/bottalk_1.ogg'
	minspeed = 3
	maxspeed = 9

/datum/bark/bottalk/alt1
	name = "Bottalk 2"
	id = "bottalk2"
	soundpath = 'tff_modular/modules/blooper/voice/barks/goon/bottalk_2.ogg'

/datum/bark/bottalk/alt2
	name = "Bottalk 3"
	id = "bottalk3"
	soundpath = 'tff_modular/modules/blooper/voice/barks/goon/bottalk_3.ogg'

/datum/bark/bottalk/alt3
	name = "Bottalk 4"
	id = "bottalk4"
	soundpath = 'tff_modular/modules/blooper/voice/barks/goon/bottalk_4.ogg'

/datum/bark/buwoo
	name = "Buwoo"
	id = "buwoo"
	soundpath = 'tff_modular/modules/blooper/voice/barks/goon/buwoo.ogg'

/datum/bark/cow
	name = "Cow"
	id = "cow"
	soundpath = 'tff_modular/modules/blooper/voice/barks/goon/cow.ogg'

/datum/bark/lizard
	name = "Lizard"
	id = "lizard"
	soundpath = 'tff_modular/modules/blooper/voice/barks/goon/lizard.ogg'

/datum/bark/pug
	name = "Pug"
	id = "pug"
	soundpath = 'tff_modular/modules/blooper/voice/barks/goon/pug.ogg'

/datum/bark/pugg
	name = "Pugg"
	id = "pugg"
	soundpath = 'tff_modular/modules/blooper/voice/barks/goon/pugg.ogg'

/datum/bark/radio
	name = "Radio 1"
	id = "radio1"
	soundpath = 'tff_modular/modules/blooper/voice/barks/goon/radio.ogg'

/datum/bark/radio/short
	name = "Radio 2"
	id = "radio2"
	soundpath = 'tff_modular/modules/blooper/voice/barks/goon/radio2.ogg'

/datum/bark/radio/ai
	name = "Radio (AI)"
	id = "radio_ai"
	soundpath = 'tff_modular/modules/blooper/voice/barks/goon/radio_ai.ogg'

/datum/bark/roach //Turkish characters be like
	name = "Roach"
	id = "roach"
	soundpath = 'tff_modular/modules/blooper/voice/barks/goon/roach.ogg'

/datum/bark/skelly
	name = "Skelly"
	id = "skelly"
	soundpath = 'tff_modular/modules/blooper/voice/barks/goon/skelly.ogg'

/datum/bark/speak
	name = "Speak 1"
	id = "speak1"
	soundpath = 'tff_modular/modules/blooper/voice/barks/goon/speak_1.ogg'

/datum/bark/speak/alt1
	name = "Speak 2"
	id = "speak2"
	soundpath = 'tff_modular/modules/blooper/voice/barks/goon/speak_2.ogg'

/datum/bark/speak/alt2
	name = "Speak 3"
	id = "speak3"
	soundpath = 'tff_modular/modules/blooper/voice/barks/goon/speak_3.ogg'

/datum/bark/speak/alt3
	name = "Speak 4"
	id = "speak4"
	soundpath = 'tff_modular/modules/blooper/voice/barks/goon/speak_4.ogg'

/datum/bark/chitter/alt
	name = "Chittery Alt"
	id = "chitter2"
	soundpath = 'tff_modular/modules/blooper/voice/barks/moth/mothchitter2.ogg'

// The Mayhem Special
/datum/bark/whistle
	name = "Whistle 1"
	id = "whistle1"
	soundpath = 'tff_modular/modules/blooper/voice/barks/kazooie/birdwhistle.ogg'

/datum/bark/whistle/alt1
	name = "Whistle 2"
	id = "whistle2"
	soundpath = 'tff_modular/modules/blooper/voice/barks/kazooie/birdwhistle2.ogg'

/datum/bark/caw/alt1
	name = "Caw 2"
	id = "caw2"
	soundpath = 'tff_modular/modules/blooper/voice/barks/kazooie/caw.ogg'
	minspeed = 4
	maxspeed = 9

/datum/bark/caw/alt2
	name = "Caw 3"
	id = "caw3"
	soundpath = 'tff_modular/modules/blooper/voice/barks/kazooie/caw2.ogg'
	minspeed = 3
	maxspeed = 9

/datum/bark/caw/alt3
	name = "Caw 4"
	id = "caw4"
	soundpath = 'tff_modular/modules/blooper/voice/barks/kazooie/caw3.ogg'
	minspeed = 3
	maxspeed = 9

/datum/bark/ehh
	name = "Ehh 1"
	id = "ehh1"
	soundpath = 'tff_modular/modules/blooper/voice/barks/kazooie/ehh.ogg'
	minspeed = 3
	maxspeed = 9

/datum/bark/ehh/alt1
	name = "Ehh 2"
	id = "ehh2"
	soundpath = 'tff_modular/modules/blooper/voice/barks/kazooie/ehh2.ogg'

/datum/bark/ehh/alt2
	name = "Ehh 3"
	id = "ehh3"
	soundpath = 'tff_modular/modules/blooper/voice/barks/kazooie/ehh3.ogg'

/datum/bark/ehh/alt3
	name = "Ehh 4"
	id = "ehh4"
	soundpath = 'tff_modular/modules/blooper/voice/barks/kazooie/ehh4.ogg'
	minspeed = 3
	maxspeed = 9

/datum/bark/ehh/alt5
	name = "Ehh 5"
	id = "ehh5"
	soundpath = 'tff_modular/modules/blooper/voice/barks/kazooie/ehh5.ogg'

/datum/bark/faucet
	name = "Faucet 1"
	id = "faucet1"
	soundpath = 'tff_modular/modules/blooper/voice/barks/kazooie/faucet.ogg'

/datum/bark/faucet/alt1
	name = "Faucet 2"
	id = "faucet2"
	soundpath = 'tff_modular/modules/blooper/voice/barks/kazooie/faucet2.ogg'

/datum/bark/ribbit
	name = "Ribbit"
	id = "ribbit"
	soundpath = 'tff_modular/modules/blooper/voice/barks/kazooie/ribbit.ogg'

/datum/bark/hoot
	name = "Hoot"
	id = "hoot"
	soundpath = 'tff_modular/modules/blooper/voice/barks/kazooie/hoot.ogg'
	minspeed = 4
	maxspeed = 9

/datum/bark/tweet
	name = "Tweet"
	id = "tweet"
	soundpath = 'tff_modular/modules/blooper/voice/barks/kazooie/tweet.ogg'

/datum/bark/dwoop
	name = "Dwoop"
	id = "dwoop"
	soundpath = 'tff_modular/modules/blooper/voice/barks/kazooie/dwoop.ogg'
	minspeed = 3
	maxspeed = 9

/datum/bark/uhm
	name = "Uhm"
	id = "uhm"
	soundpath = 'tff_modular/modules/blooper/voice/barks/kazooie/uhm.ogg'

/datum/bark/wurtesh
	name = "Wurtesh"
	id = "wurtesh"
	soundpath = 'tff_modular/modules/blooper/voice/barks/kazooie/wurble1.ogg'

/datum/bark/chitter2
	name = "Chitter2"
	id = "chitter2"
	soundpath = 'tff_modular/modules/blooper/voice/barks/kazooie/chitter1.ogg'

