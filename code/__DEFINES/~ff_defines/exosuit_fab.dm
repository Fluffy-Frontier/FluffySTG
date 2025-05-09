//Defines for FF mechs!

//ATTENTION! Since there is also an original exosuit_fab define, it is IMPORTANT to remember that
//All the (1<<#) thingies must have a # bigger than the max # in original defines.
//Otherwise they will override original mechs and allow cursed things like hydraulic claw on a Gygax.
//Such an atrocity. Manual rewrite is required after any upstream mech additions.

//Clammechs
/// Module is compatible with TideShark Exosuit models
#define EXOSUIT_MODULE_TIDESHARK (1<<13)
/// Module is compatible with ReefBreaker Exosuit models
#define EXOSUIT_MODULE_REEFBREAKER (1<<14)
/// Module is compatible with Kelp Wulp Exosuit models
#define EXOSUIT_MODULE_KELPWULP (1<<15)
/// Module is compatible with Seagull Exosuit models
#define EXOSUIT_MODULE_SEAGULL (1<<16)
/// Module is compatible with Striker Eel Exosuit models
#define EXOSUIT_MODULE_STRIKEREEL (1<<17)

//Maybe some other ones later

/// Module is compatible with "Clamtech" Exosuit models - TideShark, ReefBreaker, Kelp Wulp, Seagull and Striker Eel
#define EXOSUIT_MODULE_CLAM (EXOSUIT_MODULE_TIDESHARK | EXOSUIT_MODULE_REEFBREAKER | EXOSUIT_MODULE_KELPWULP | EXOSUIT_MODULE_SEAGULL | EXOSUIT_MODULE_STRIKEREEL | EXOSUIT_MODULE_CONCEALED_WEP_BAY)
