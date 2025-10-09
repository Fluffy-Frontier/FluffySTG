#define HAT "Hat Slot"
#define HELMET "Helmet Slot"
#define EYE "Eye Slot"
#define FACE "Face Slot"
#define MOUTH_1 "Mouth Slot 1"
#define MOUTH_2 "Mouth Slot 2"
#define CHEEK "Cheek Slot"
#define BROOCH "Brooch Slot"
#define NECKWEAR "Neckwear Slot"
#define LEFTBACK "Left Back Slot"
#define RIGHTBACK "Right Back Slot"
#define HAND_1 "Hand Slot 1"
#define HAND_2 "Hand Slot 2"
#define SPECIAL "Special/Other Slot"

/datum/ego_gifts // Currently Covers most EGO Gift Functions, most others can be done via armors
	var/name = ""
	var/desc = null
	var/icon = 'tff_modular/modules/evento_needo/icons/Teguicons/mob/ego_gear/ego_gifts.dmi'
	var/icon_state = ""
	var/layer = -ABOVE_MOB_LAYER
	var/slot = SPECIAL
	var/locked = FALSE
	var/visible = TRUE
	var/mob/living/carbon/human/owner
	var/datum/abnormality/datum_reference = null
	var/mutable_appearance/gift_overlay

/datum/ego_gifts/proc/Initialize(mob/living/carbon/human/user)
	gift_overlay = FormatOverlay(user)
	user.ego_gift_list[src.slot] = src
	user.add_overlay(gift_overlay)
	owner = user

/datum/ego_gifts/proc/Remove(mob/living/carbon/human/user)
	user.cut_overlay(gift_overlay)
	QDEL_NULL(src)

/datum/ego_gifts/Topic(href, list/href_list)
	switch(href_list["choice"])
		if("lock")
			locked = locked ? FALSE : TRUE
			//owner.ShowGifts()
		if("hide")
			Refresh_Gift_Sprite(visible) //for uniquely colored gifts
		if("dissolve")
			if(tgui_alert(owner, "Are you sure you want to dissolve the [src]?", "Dissolve Gift", list("Yes", "No"), 0) == "Yes") // We only go if they hit "Yes" specifically.
				if(locked)
					to_chat(owner, span_warning("[src] is locked and cannot be dissolved! Phew!"))
					return
				if(istype(src, /datum/ego_gifts/waltz)) // Blessing Rejection
					if(tgui_alert(owner, "Are you sure you want to do this? A champion should not abandon their post.", "Remove Blessing", list("Yes", "No"), 0) == "Yes")
						if(QDELETED(src) || !istype(src, /datum/ego_gifts/waltz))
							return
						to_chat(owner, span_warning("Removal of the crown leaves your mind scarred!"))
						owner.adjustSanityLoss(75)
					else
						return
				var/datum/ego_gifts/empty/dissolving = new
				dissolving.slot = src.slot
				if(!datum_reference)
					to_chat(owner, span_notice("The [src] has dissolved into... light?"))
					owner.Apply_Gift(dissolving)
					return
				var/PE_received = 0
				PE_received += (datum_reference.current.fear_level * datum_reference.current.fear_level)
				if(istype(src, /datum/ego_gifts/blossoming) || istype(src, /datum/ego_gifts/paradise)) // Why though
					PE_received *= 2
				if(ispath(datum_reference.abno_path, /mob/living/simple_animal/hostile/abnormality/crumbling_armor))
					var/answer = tgui_alert(owner, "To think one would commit such a shameful act... what have ye, weaker body or mind?", "Cowardice", list("Body", "Mind"), 0)
					if(QDELETED(src) || !ispath(src.datum_reference.abno_path, /mob/living/simple_animal/hostile/abnormality/crumbling_armor))
						return
					switch(answer)
						if("Body")
							to_chat(owner, span_notice("Least ye have not hid from this."))
						if("Mind")
							to_chat(owner, span_notice("Least ye have not hid from this."))
						else
							to_chat(owner, span_userdanger("Even now you try and run? Clearly you are lacking in both!"))
					to_chat(owner, span_warning("The once cool flames now burn your flesh!"))
					owner.adjustBruteLoss(100)
				to_chat(owner, span_notice("The [src] has dissolved into [PE_received] PE for [datum_reference.name]!"))
				owner.Apply_Gift(dissolving)
		else
			CRASH("Gift Topic Error in [src]. [owner] clicked a non-existant button!?")

/mob/living/carbon/human/proc/Apply_Gift(datum/ego_gifts/given) // Gives the gift and removes the effects of the old one if necessary
	if(!istype(given))
		return
	if(!isnull(ego_gift_list[given.slot]))
		var/datum/ego_gifts/removed_gift = ego_gift_list[given.slot]
		if(removed_gift.locked)
			return
		removed_gift.Remove(src)
	given.Initialize(src)
	if(istype(ego_gift_list[LEFTBACK], /datum/ego_gifts/paradise) && istype(ego_gift_list[RIGHTBACK], /datum/ego_gifts/twilight)) // If you have both, makes them not overlap
		var/datum/ego_gifts/twilight/right_wing = ego_gift_list[RIGHTBACK] // Have to do this messier because the gift_list isnt' a defined type... pain
		var/datum/ego_gifts/paradise/left_wing = ego_gift_list[LEFTBACK]
		src.cut_overlay(mutable_appearance(left_wing.icon, left_wing.icon_state, left_wing.layer))
		src.cut_overlay(mutable_appearance(right_wing.icon, right_wing.icon_state, right_wing.layer))
		left_wing.icon_state = "paradiselost_x"
		right_wing.icon_state = "twilight_x"
		src.add_overlay(mutable_appearance(left_wing.icon, left_wing.icon_state, left_wing.layer))
		src.add_overlay(mutable_appearance(right_wing.icon, right_wing.icon_state, right_wing.layer))
	else
		if(istype(ego_gift_list[LEFTBACK], /datum/ego_gifts/paradise)) // If one gets overwritten it fixes them
			var/datum/ego_gifts/paradise/left_wing = ego_gift_list[LEFTBACK]
			src.cut_overlay(mutable_appearance(left_wing.icon, left_wing.icon_state, left_wing.layer))
			left_wing.icon_state = "paradiselost"
			src.add_overlay(mutable_appearance(left_wing.icon, left_wing.icon_state, left_wing.layer))
		if(istype(ego_gift_list[RIGHTBACK], /datum/ego_gifts/twilight))
			var/datum/ego_gifts/twilight/right_wing = ego_gift_list[RIGHTBACK]
			src.cut_overlay(mutable_appearance(right_wing.icon, right_wing.icon_state, right_wing.layer))
			right_wing.icon_state = "twilight"
			src.add_overlay(mutable_appearance(right_wing.icon, right_wing.icon_state, right_wing.layer))

/datum/ego_gifts/proc/Refresh_Gift_Sprite(option)
	switch(option)
		if(FALSE)
			gift_overlay = FormatOverlay(owner)
			owner.add_overlay(gift_overlay)
			visible = TRUE
		if(TRUE)
			owner.cut_overlay(gift_overlay)
			qdel(gift_overlay)
			visible = FALSE

//Overridable overlay proc for coloring gifts based on attribute, skin tone, or other aspects.
/datum/ego_gifts/proc/FormatOverlay(mob/living/carbon/human/user)
	return mutable_appearance(src.icon, src.icon_state, src.layer)

/// Empty EGO GIFT Slot
/datum/ego_gifts/empty
	name = "Empty"
	desc = "An empty slot for gifts."
	icon_state = null

/**
 * Zayin EGO Gifts
 */

/datum/ego_gifts/alice
	name = "Little Alice"
	icon_state = "alice"
	slot = NECKWEAR

/datum/ego_gifts/change
	name = "Change"
	icon_state = "change"
	slot = BROOCH

/datum/ego_gifts/doze
	name = "Dozing"
	icon_state = "doze"
	slot = EYE

/datum/ego_gifts/eclipse
	name = "Eclipse of Scarlet Moths"
	icon_state = "eclipse"
	slot = BROOCH

/datum/ego_gifts/evening
	name = "Evening Twilight"
	icon_state = "evening"
	slot = FACE

/datum/ego_gifts/mail
	name = "Empty Envelope"
	icon_state = "mail"
	slot = CHEEK

/datum/ego_gifts/melty_eyeball
	name = "Melty Eyeball"
	icon_state = "melty_eyeball"
	slot = EYE

/datum/ego_gifts/nightshade
	name = "Nightshade"
	icon_state = "nightshade"
	slot = HAND_1

/datum/ego_gifts/nostalgia
	name = "Nostalgia"
	icon_state = "nostalgia"
	slot = MOUTH_2

/datum/ego_gifts/oceanic
	name = "Taste of the Sea"
	icon_state = "oceanic"
	slot = HAND_2

/datum/ego_gifts/penitence
	name = "Penitence"
	desc = "Provides a 10% bonus to works with corresponding abnormality."
	icon_state = "penitence"
	slot = HAT

/datum/ego_gifts/soda
	name = "Soda"
	icon_state = "soda"
	slot = MOUTH_2

/datum/ego_gifts/tough
	name = "Tough"
	icon_state = "tough"
	slot = EYE

/datum/ego_gifts/wingbeat
	name = "Wingbeat"
	icon_state = "wingbeat"
	slot = HAND_2

/datum/ego_gifts/cord
	name = "cord"
	icon_state = "cord"
	slot = NECKWEAR

/**
 * TETH EGO Gifts
 */

/datum/ego_gifts/beak
	name = "Beak"
	icon_state = "beak"
	slot = NECKWEAR

/datum/ego_gifts/bean
	name = "Magic Bean"
	icon_state = "bean"
	slot = HAT

/datum/ego_gifts/blossom
	name = "Cherry Blossom"
	icon_state = "cherry"
	slot = HAT

/datum/ego_gifts/bunny
	name = "Bunny Rabbit"
	icon_state = "bunny"
	slot = HAT

/datum/ego_gifts/curfew
	name = "Curfew"
	icon_state = "curfew"
	slot = HAND_1

/datum/ego_gifts/cute
	name = "SO CUTE!!!"
	icon_state = "cute"
	slot = HAT

/datum/ego_gifts/dream
	name = "Engulfing Dream"
	icon_state = "engulfing"
	slot = HAT

/datum/ego_gifts/fourleaf_clover
	name = "Four-Leaf Clover"
	icon_state = "fourleaf_clover"
	slot = HELMET

/datum/ego_gifts/fragments
	name = "Fragments From Somewhere"
	icon_state = "fragments"
	slot = BROOCH

/datum/ego_gifts/hearth
	name = "Hearth"
	icon_state = "hearth"
	slot = NECKWEAR

/datum/ego_gifts/horn
	name = "Horn"
	icon_state = "horn"
	slot = HAT

/datum/ego_gifts/lantern
	name = "Lantern"
	icon_state = "lantern"
	slot = MOUTH_2

/datum/ego_gifts/lutemis
	name = "Dear Lutemis"
	icon_state = "lutemis"
	slot = NECKWEAR

/datum/ego_gifts/match
	name = "Fourth Match Flame"
	icon_state = "match"
	slot = MOUTH_2

/datum/ego_gifts/noise
	name = "Noise"
	icon_state = "noise"
	slot = BROOCH

/datum/ego_gifts/page
	name = "Page"
	icon_state = "page"
	slot = HAND_1

/datum/ego_gifts/patriot
	name = "Patriot"
	icon_state = "patriot"
	slot = HAT

/datum/ego_gifts/red_sheet
	name = "Talisman Bundle"
	icon_state = "red_sheet"
	slot = HELMET

/datum/ego_gifts/redeyes
	name = "Red Eyes"
	icon_state = "redeyes"
	slot = EYE

/datum/ego_gifts/regret
	name = "Regret"
	icon_state = "regret"
	slot = MOUTH_1

/datum/ego_gifts/revelation
	name = "Revelation"
	icon_state = "revelation"
	slot = EYE

/datum/ego_gifts/sanitizer
	name = "Sanitizer"
	icon_state = "sanitizer"
	slot = HAND_2

/datum/ego_gifts/shy
	name = "Today's Expression"
	icon_state = "shy"
	slot = EYE

/datum/ego_gifts/sloshing
	name = "Green Spirit"
	icon_state = "sloshing"
	slot = CHEEK

/datum/ego_gifts/snapshot
	name = "Snapshot"
	icon_state = "snapshot"
	slot = NECKWEAR

/datum/ego_gifts/solitude
	name = "Solitude"
	icon_state = "solitude"
	slot = EYE

/datum/ego_gifts/sorority
	name = "Sorority"
	icon_state = "sorority"
	slot = CHEEK

/datum/ego_gifts/sorrow
	name = "Sorrow"
	icon_state = "sorrow"
	slot = HELMET

/datum/ego_gifts/standard
	name = "Standard Training E.G.O."
	icon_state = "standard"
	slot = HAT

/datum/ego_gifts/trick
	name = "Hat Trick"
	icon_state = "trick"
	slot = MOUTH_1

/datum/ego_gifts/visions
	name = "Fiery Down"
	icon_state = "visions"
	slot = NECKWEAR

/datum/ego_gifts/wedge
	name = "Screaming Wedge"
	icon_state = "wedge"
	slot = BROOCH

/datum/ego_gifts/wrist
	name = "Wrist Cutter"
	icon_state = "wrist"
	slot = HAND_2

/datum/ego_gifts/zauberhorn
	name = "Zauberhorn"
	icon_state = "zauberhorn"
	slot = HAND_1

/datum/ego_gifts/denial
	name = "Denial"
	icon_state = "denial"
	slot = HELMET

/datum/ego_gifts/desert
	name = "Desert Wind"
	icon_state = "desert"
	slot = EYE

/datum/ego_gifts/white_gossypium //intentionally made to suck. Ties later into the abno's mechanics + it's a riff on how hated the Limbus gift is
	name = "White Gossypium"
	icon_state = "white_gossypium"
/**
 * HE EGO Gifts
 */

/datum/ego_gifts/alleyway
	name = "Alleyway"
	icon_state = "alleyway"
	slot = HAND_2

/datum/ego_gifts/bearpaw
	name = "Bear Paws"
	icon_state = "bearpaws"
	slot = HAT

/datum/ego_gifts/christmas
	name = "Christmas"
	icon_state = "christmas"
	slot = HAT

/datum/ego_gifts/coiling
	name = "Coiling"
	icon_state = "coiling"
	slot = MOUTH_2

/datum/ego_gifts/courage_cat //crumbling armor also has an ego gift called courage so the name has to be slightly different
	name = "Courage"
	icon_state = "courage_cat"
	slot = EYE

/datum/ego_gifts/desire
	name = "Sanguine Desire"
	icon_state = "desire"
	slot = MOUTH_2

/datum/ego_gifts/faelantern
	name = "Midwinter Nightmare"
	icon_state = "faelantern"
	slot = LEFTBACK

/datum/ego_gifts/fluid_sac
	name = "Fluid Sac"
	icon_state = "fluid_sac"
	slot = MOUTH_2

/datum/ego_gifts/frostsplinter
	name = "Those who know the Cruelty of Winter and the Aroma of Roses"
	icon_state = "frostsplinter"
	slot = CHEEK

/datum/ego_gifts/frostcrown
	name = "The Winters Kiss"
	icon_state = "frostcrown"
	slot = HAT

/datum/ego_gifts/fury
	name = "Blind Fury"
	icon_state = "fury"
	slot = EYE

/datum/ego_gifts/galaxy
	name = "Galaxy"
	icon_state = "galaxy"
	slot = NECKWEAR

/datum/ego_gifts/gaze
	name = "Gaze"
	icon_state = "gaze"
	slot = HAND_2

/datum/ego_gifts/get_strong
	name = "Screwloose"
	icon_state = "get_strong"
	slot = HELMET

/datum/ego_gifts/grasp
	name = "Grasp"
	icon_state = "grasp"
	slot = NECKWEAR

/datum/ego_gifts/grinder
	name = "Grinder Mk4"
	icon_state = "grinder"
	slot = EYE

/datum/ego_gifts/reddit
	name = "Reddit"
	desc = "Thanks for the gold, kind stranger!"
	slot = HEAD

/datum/ego_gifts/aedd
	name = "AEDD"
	icon_state = "grinder"
	slot = CHEEK

/datum/ego_gifts/morii
	name = "Morii"
	icon_state = "morii"
	slot = EYE

/datum/ego_gifts/harmony
	name = "Harmony"
	icon_state = "harmony"
	slot = CHEEK

/datum/ego_gifts/harvest
	name = "Harvest"
	icon_state = "harvest"
	slot = NECKWEAR

/datum/ego_gifts/homing_instinct
	name = "Homing Instinct"
	icon_state = "homing_instinct"
	slot = HAND_2

/datum/ego_gifts/impending_day
	name = "Impending Day"
	icon_state = "doomsday"
	slot = HELMET

/datum/ego_gifts/inheritance
	name = "Inheritance"
	icon_state = "inheritance"
	slot = RIGHTBACK

/datum/ego_gifts/legerdemain
	name = "Legerdemain"
	icon_state = "legerdemain"
	slot = HAND_1

/datum/ego_gifts/lifestew
	name = "Lifetime Stew"
	icon_state = "lifestew"
	slot = HELMET

/datum/ego_gifts/loggging
	name = "Logging"
	icon_state = "loggging"
	slot = BROOCH

/datum/ego_gifts/magicbullet
	name = "Magic Bullet"
	icon_state = "magicbullet"
	slot = MOUTH_2

/datum/ego_gifts/maneater
	name = "Man Eater"
	icon_state = "maneater"
	slot = NECKWEAR

/datum/ego_gifts/marionette
	name = "Marionette"
	icon_state = "marionette"
	slot = FACE

/datum/ego_gifts/metal
	name = "Bare Metal"
	icon_state = "metal"
	slot = HAND_1

/datum/ego_gifts/nixie
	name = "Nixie Divergence"
	icon_state = "nixie"
	slot = HAND_1
/datum/ego_gifts/oppression
	name = "Oppression"
	icon_state = "oppression"
	slot = MOUTH_1

/datum/ego_gifts/pleasure
	name = "Pleasure"
	icon_state = "pleasure"
	slot = NECKWEAR

/datum/ego_gifts/prank
	name = "Funny Prank"
	icon_state = "prank"
	slot = HELMET

/datum/ego_gifts/remorse // All it takes is a single crack in one's psyche...
	name = "Remorse"
	icon_state = "remorse"
	slot = BROOCH

/datum/ego_gifts/replica//KQE regular gift
	name = "Pinpoint Logic Circuit"
	icon_state = "replica"
	slot = BROOCH

/datum/ego_gifts/ups//KQE event gift
	name = "UPS System"
	icon_state = "ups"
	slot = FACE

/datum/ego_gifts/roseate_desire
	name = "Roseate Desire"
	icon_state = "roseate_desire"
	slot = EYE

/datum/ego_gifts/solemnlament
	name = "Solemn Lament"
	icon_state = "solemnlament"
	slot = RIGHTBACK

/datum/ego_gifts/song
	name = "Song of the Past"
	icon_state = "song"
	slot = CHEEK

/datum/ego_gifts/split
	name = "Split"
	icon_state = "split"
	slot = MOUTH_1

/datum/ego_gifts/syrinx // Your reward for dealing with one of the worst abnormalities ever
	name = "Syrinx"
	icon_state = "syrinx"
	desc = "Provides the user with 5% resistance to white damage."
	slot = HELMET

/datum/ego_gifts/totalitarianism
	name = "Totalitarianism"
	icon_state = "totalitarianism"
	slot = CHEEK

/datum/ego_gifts/transmission
	name = "Transmission"
	icon_state = "transmission"
	slot = HAT

/datum/ego_gifts/unrequited_love
	name = "Unrequited Love"
	icon_state = "unrequited_love"
	slot = CHEEK

/datum/ego_gifts/uturn
	name = "Milepost of Survival"
	icon_state = "uturn"
	slot = FACE

/datum/ego_gifts/voodoo
	name = "Voodoo Doll"
	icon_state = "voodo"
	slot = MOUTH_1

/datum/ego_gifts/waltz // Locked to Champions only, wearing it carries a risk but it's powerful
	name = "Flower Waltz"
	icon_state = "waltz"
	slot = HELMET

/datum/ego_gifts/warp
	name = "Blue Zippo Lighter"
	icon_state = "warp"
	slot = HAND_2

/datum/ego_gifts/sunshower
	name = "Sunshower"
	icon_state = "sunshower"
	slot = LEFTBACK

/**
 * WAW EGO Gifts
 */

/datum/ego_gifts/amrita
	name = "Amrita"
	icon_state = "amrita"
	slot = HAND_1

// Converts 10% of WHITE damage taken(before armor calculations!) as health
// tl;dr - If you were to get hit by an attack of 200 WHITE damage - you restore 20 health, regardless of how much
// damage you actually took
/datum/ego_gifts/aroma
	name = "Faint Aroma"
	desc = "Restores 10% of WHITE damage taken as health. This effect ignores armor."
	icon_state = "aroma"
	slot = HAT

/datum/ego_gifts/aroma/Initialize(mob/living/carbon/human/user)
	. = ..()
	RegisterSignal(user, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(AttemptHeal))

/datum/ego_gifts/aroma/Remove(mob/living/carbon/human/user)
	UnregisterSignal(user, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(AttemptHeal))
	return ..()

/datum/ego_gifts/aroma/proc/AttemptHeal(datum/source, damage, damagetype, def_zone)
	if(!owner && damagetype != BRUTE)
		return
	if(!damage)
		return
	owner.adjustBruteLoss(-damage*0.1)

/datum/ego_gifts/assonance
	name = "Assonance"
	icon_state = "assonance"
	slot = HAT

/datum/ego_gifts/blahaj
	name = "Blahaj"
	icon_state = "blahaj"
	slot = RIGHTBACK

/datum/ego_gifts/blind_obsession
	name = "Blind Obsession"
	icon_state = "slitcurrent"
	slot = HAT

/datum/ego_gifts/blind_rage
	name = "Blind Rage"
	icon_state = "blind_rage"
	slot = HAT

/datum/ego_gifts/bride
	name = "Bride"
	icon_state = "bride"
	slot = HAT

/datum/ego_gifts/cobalt
	name = "Cobalt Scar"
	icon_state = "cobalt"
	slot = FACE

/datum/ego_gifts/correctional
	name = "Correctional"
	icon_state = "correctional"
	slot = FACE

/datum/ego_gifts/crimson
	name = "Crimson Scar"
	icon_state = "crimson"
	slot = MOUTH_1

/datum/ego_gifts/darkcarnival
	name = "Dark Carnival"
	icon_state = "dark_carnival"
	slot = FACE

/datum/ego_gifts/diffraction
	name = "Diffraction"
	icon_state = "diffraction"
	slot = HELMET

/datum/ego_gifts/dipsia
	name = "Dipsia"
	icon_state = "dipsia"
	slot = FACE

/datum/ego_gifts/discord
	name = "Discord"
	icon_state = "discord"
	slot = HELMET

/datum/ego_gifts/ebony_stem
	name = "Ebony Stem"
	icon_state = "ebony_stem"
	slot = NECKWEAR

/datum/ego_gifts/ecstasy
	name = "Ecstasy"
	icon_state = "ecstasy"
	slot = MOUTH_2

/datum/ego_gifts/executive
	name = "Executive"
	icon_state = "executive"
	slot = HAND_2

/datum/ego_gifts/exuviae
	name = "Exuviae"
	icon_state = "exuviae"
	slot = HAND_2

/datum/ego_gifts/feather
	name = "Feather of Honor"
	icon_state = "feather"
	slot = HAT

/datum/ego_gifts/goldrush
	name = "Gold Rush"
	icon_state = "goldrush"
	slot = HAND_1

/datum/ego_gifts/heart
	name = "Heart"
	icon_state = "heart"
	slot = HAND_1

/datum/ego_gifts/hornet
	name = "Hornet"
	icon_state = "hornet"
	slot = HELMET

/datum/ego_gifts/hypocrisy
	name = "Hypocrisy"
	icon_state = "hypocrisy"
	layer = BODY_BEHIND_LAYER
	slot = HELMET

// This code is so that the elf ears are colored the same as the users skin tone
/datum/ego_gifts/hypocrisy/FormatOverlay(mob/living/carbon/human/user)
	. = ..()
	/*
	* . is the the return of the root proc.
	* This proc edits the color and returns
	* the altered overlay based on the users
	* skin color.
	*/
	var/mutable_appearance/ear_overlay = .
	if(user.skin_tone)
		var/user_skin_color = skintone2hex(user.skin_tone)
		ear_overlay.color = "#[user_skin_color]"
	return ear_overlay

/datum/ego_gifts/infinity
	name = "Infinity"
	icon_state = "infinity"
	slot = EYE

/datum/ego_gifts/innocence
	name = "Innocence"
	icon_state = "innocence"
	slot = MOUTH_2

/datum/ego_gifts/justitia
	name = "Justitia"
	icon_state = "justitia"
	slot = EYE

/datum/ego_gifts/lamp
	name = "Lamp"
	icon_state = "lamp"
	slot = HELMET

/datum/ego_gifts/love_and_hate
	name = "In the Name of Love and Hate"
	icon_state = "lovehate"
	slot = HAT

/datum/ego_gifts/loyalty
	name = "Loyalty"
	icon_state = "loyalty"
	slot = BROOCH

/datum/ego_gifts/moonlight
	name = "Moonlight"
	icon_state = "moonlight"
	slot = BROOCH

/datum/ego_gifts/pharaoh
	name = "Pharaoh"
	icon_state = "pharaoh"
	slot = MOUTH_1

/datum/ego_gifts/psychic
	name = "Psychic Dagger"
	icon_state = "psychic"
	slot = CHEEK

/datum/ego_gifts/rimeshank
	name = "Rimeshank"
	icon_state = "rimeshank"
	slot = NECKWEAR

/datum/ego_gifts/rosa
	name = "Crown of Roses"
	icon_state = "penitence"//TODO: make an actual sprite
	slot = HAT

/datum/ego_gifts/scene
	name = "As Written in the Scenario"
	icon_state = "scene"
	slot = FACE

/datum/ego_gifts/spore
	name = "Spore"
	icon_state = "spore"
	slot = HAND_2

/datum/ego_gifts/stem
	name = "Green Stem"
	icon_state = "green_stem"
	slot = BROOCH

//reduces sanity and fortitude for a 10% buff to work success. Unfortunately this translates to 200 temp
//so right now its 10 temp
/datum/ego_gifts/swan
	name = "Black Swan"
	icon_state = "swan"
	slot = HAT

/datum/ego_gifts/tears
	name = "Sword Sharpened With Tears"
	icon_state = "tears"
	slot = CHEEK

/datum/ego_gifts/thirteen
	name = "Thirteen"
	icon_state = "thirteen"
	slot = HELMET

/datum/ego_gifts/warring
	name = "Feather of Valor"
	icon_state = "warring"
	slot = HAT

/datum/ego_gifts/animalism
	name = "Animalism"
	icon_state = "animalism"
	slot = EYE

/datum/ego_gifts/sunyata
	name = "Bloody Gadget"
	icon_state = "sunyata"
	slot = HAND_1

/datum/ego_gifts/good_intentions
	name = "Good Intentions" //no stat bonuses but a minor boost to all works
	icon_state = "good_intentions"
	slot = HAT

/**
 * ALEPH EGO Gifts
 */

/datum/ego_gifts/adoration
	name = "Adoration"
	icon_state = "adoration"
	slot = HELMET

/datum/ego_gifts/amogus
	name = "Imposter"
	icon_state = "amogus"
	slot = EYE

/datum/ego_gifts/blossoming
	name = "100 Paper Flowers"
	desc = "Provides the user with 10% resistance to all damage sources."
	icon_state = "blooming"
	slot = SPECIAL

/datum/ego_gifts/censored
	name = "CENSORED"
	icon_state = "censored"
	slot = EYE

/datum/ego_gifts/dacapo
	name = "Da Capo"
	icon_state = "dacapo"
	slot = EYE

/datum/ego_gifts/distortion
	name = "Distortion"
	icon_state = "distortion"
	slot = BROOCH

/datum/ego_gifts/inconsolable
	name = "Inconsolable Grief"
	icon_state = "inconsolable"
	slot = EYE

/datum/ego_gifts/mimicry
	name = "Mimicry"
	icon_state = "mimicry"
	slot = CHEEK

/datum/ego_gifts/mockery
	name = "Mockery"
	icon_state = "mockery"
	slot = HAND_1

/datum/ego_gifts/nihil //May be subject to change when the event is added proper
	name = "Nihil"
	icon_state = "nihil"
	slot = HAT

/datum/ego_gifts/paradise
	name = "Paradise Lost"
	icon_state = "paradiselost"
	slot = LEFTBACK

/datum/ego_gifts/pink
	name = "Pink"
	icon_state = "pink"
	slot = HELMET

/datum/ego_gifts/seasons
	name = "Season's Greetings"
	icon_state = "seasons"
	slot = HAND_2

/datum/ego_gifts/smile
	name = "Smile"
	icon_state = "smile"
	slot = EYE

/datum/ego_gifts/soulmate
	name = "Soulmate"
	icon_state = "soulmate"
	slot = HELMET

/datum/ego_gifts/space
	name = "Space"
	icon_state = "space"
	slot = FACE

/datum/ego_gifts/star
	name = "Sound of a Star"
	icon_state = "star"
	slot = EYE

/datum/ego_gifts/christmas/buff
	name = "Ultimate Christmas"
/datum/ego_gifts/willing
	name = "The Flesh Is Willing"
	icon_state = "willing"
	slot = NECKWEAR

/**
 * Event EGO Gifts
 */

/datum/ego_gifts/sheep
	name = "Sheeps Clothing"
	icon_state = "sheep"
	slot = HAT

/datum/ego_gifts/blessing
	name = "Blessing"
	desc = "Provides the user with 20% resistance to PALE damage."
	icon_state = "blessing"
	slot = SPECIAL

/datum/ego_gifts/fervor
	name = "Fervor"
	desc = "Provides the user with 5% resistance to all damage types."
	icon_state = "fervor"
	slot = SPECIAL

/datum/ego_gifts/oberon
	name = "Oberon"
	icon_state = "oberon"
	desc = "Provides the user with 10% resistance to RED and BLACK damage."
	slot = LEFTBACK

/datum/ego_gifts/twilight
	name = "Twilight"
	icon_state = "twilight"
	slot = RIGHTBACK

/datum/ego_gifts/sukuna
	name = "Sukuna's Mask Thingy"
	desc = "I have no idea what it is, but it heals you from pale."
	icon_state = "sukunamask"
	slot = FACE


/datum/ego_gifts/sukuna/Initialize(mob/living/carbon/human/user)
	. = ..()
	RegisterSignal(user, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(AttemptHeal))

/datum/ego_gifts/sukuna/Remove(mob/living/carbon/human/user)
	UnregisterSignal(user, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(AttemptHeal))
	return ..()

/datum/ego_gifts/sukuna/proc/AttemptHeal(datum/source, damage, damagetype, def_zone)
	if(!owner && damagetype != BRUTE)
		return
	if(!damage)
		return
	owner.adjustBruteLoss(-damage*0.75)

/datum/ego_gifts/luckdraw
	name = "Luck of the Draw"
	icon_state = "luckdraw"
	slot = HAT
