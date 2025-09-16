/obj/item/clothing/suit/armor/ego_gear/realization // 240 without ability. You have to be an EX level agent to get these.
	name = "unknown realized ego"
	desc = "Notify coders immediately!"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/clothing/ego_gear/realization.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/mob/ego_gear/realized.dmi'

	/// Type of realized ability, if any
	var/datum/action/spell_action///realized_ability = null

/obj/item/clothing/suit/armor/ego_gear/realization/Initialize()
	. = ..()
	//if(isnull(//realized_ability))*.
	//	return
	////var/datum/action/spell_action/AS = new //realized_ability
	////var/datum/action/spell_action/A = AS.action
	////A.SetItem(src)

/*Armor totals:
Ability 	230
No Ability	250
*/
/* ZAYIN Realizations */

/obj/item/clothing/suit/armor/ego_gear/realization/confessional
	name = "confessional"
	desc = "Come my child. Tell me your sins."
	icon_state = "confessional"
	new_armor = list(BURN = 50, BRAIN = 100, BRUTE = 40, TOX = 40)	//Ranged
	//realized_ability = /datum/action/spell_action/aimed/cross_spawn

/obj/item/clothing/suit/armor/ego_gear/realization/prophet
	name = "prophet"
	desc = "And they have conquered him by the blood of the Lamb and by the word of their testimony, for they loved not their lives even unto death."
	icon_state = "prophet"
	new_armor = list(BURN = 40, BRAIN = 80, BRUTE = 70, TOX = 60)	//No ability.
	flags_inv = HIDEJUMPSUIT|HIDEGLOVES|HIDESHOES
	hat = /obj/item/clothing/head/ego_hat/prophet_hat

/obj/item/clothing/head/ego_hat/prophet_hat
	name = "prophet"
	desc = "For this reason, rejoice, you heavens and you who dwell in them. Woe to the earth and the sea, because the devil has come down to you with great wrath, knowing that he has only a short time."
	icon_state = "prophet"

/obj/item/clothing/suit/armor/ego_gear/realization/maiden
	name = "blood maiden"
	desc = "Soaked in blood, and yet pure in heart."
	icon_state = "maiden"
	new_armor = list(BURN = 60, BRAIN = 60, BRUTE = 80, TOX = 50)	//No ability. 250

/obj/item/clothing/suit/armor/ego_gear/realization/wellcheers
	name = "wellcheers"
	desc = " I’ve found true happiness in cracking open a cold one after a hard day’s work, covered in sea water and sweat. \
	I’m at the port now but we gotta take off soon to catch some more shrimp. Never know what your future holds, bros."
	icon_state = "wellcheers"
	new_armor = list(BURN = 80, BRAIN = 50, BRUTE = 50, TOX = 50)	//Support
	//realized_ability = /datum/action/spell_action/wellcheers
	hat = /obj/item/clothing/head/ego_hat/wellcheers_hat

/obj/item/clothing/head/ego_hat/wellcheers_hat
	name = "wellcheers"
	desc = "You’re really missing out on life if you’ve never tried shrimp."
	icon_state = "wellcheers"

/obj/item/clothing/suit/armor/ego_gear/realization/comatose
	name = "comatose"
	desc = "...ZZZ..."
	icon_state = "comatose"
	new_armor = list(BURN = 50, BRAIN = 80, BRUTE = 50, TOX = 50)	//Defensive
	//realized_ability = /datum/action/spell_action/comatose

/obj/item/clothing/suit/armor/ego_gear/realization/brokencrown
	name = "broken crown"
	desc = "Shall we get to work? All we need to do is what we’ve always done."
	icon_state = "brokencrown"
	new_armor = list(BURN = 70, BRAIN = 60, BRUTE = 50, TOX = 50)	//Broken Crown
	//realized_ability = /datum/action/spell_action/brokencrown
	hat = /obj/item/clothing/head/ego_hat/brokencrown

/obj/item/clothing/suit/armor/ego_gear/realization/brokencrown/dropped(mob/user) //Reload the item automatically if dropped
	//for(var/datum/action/spell_action/theability in actions)
	//	if(istype(theability.target, /datum/action/spell_action/brokencrown))
	//		var/datum/action/spell_action/brokencrown/power = theability.target
	//		power.Reabsorb()
	. = ..()

/obj/item/clothing/suit/armor/ego_gear/realization/brokencrown/attackby(obj/item/I, mob/living/user, params) //Reload the item
	//for(var/datum/action/spell_action/theability in actions)
	//	if(istype(theability.target, /datum/action/spell_action/brokencrown))
	//		var/datum/action/spell_action/brokencrown/power = theability.target
	//		if(power.Absorb(I,user))
	//			return
	return ..()

/obj/item/clothing/head/ego_hat/brokencrown
	name = "broken crown"
	desc = "One fell down and the rest came tumbling after."
	icon_state = "brokencrown"

/* TETH Realizations */

/obj/item/clothing/suit/armor/ego_gear/realization/mouth
	name = "mouth of god"
	desc = "And the mouth of god spoke: You will be punished."
	icon_state = "mouth"
	new_armor = list(BURN = 70, BRAIN = 60, BRUTE = 40, TOX = 60)		//Defensive
	//realized_ability = /datum/action/spell_action/punishment

/obj/item/clothing/suit/armor/ego_gear/realization/universe
	name = "one with the universe"
	desc = "One with all, it all comes back to yourself."
	icon_state = "universe"
	new_armor = list(BURN = 40, BRAIN = 50, BRUTE = 80, TOX = 60)		//Support
	//realized_ability = /datum/action/spell_action/universe_song
	hat = /obj/item/clothing/head/ego_hat/universe_hat

/obj/item/clothing/head/ego_hat/universe_hat
	name = "one with the universe"
	desc = "See. All. Together. Know. Us."
	icon_state = "universe"
	flags_inv = HIDEMASK | HIDEHAIR

/obj/item/clothing/suit/armor/ego_gear/realization/death
	name = "death stare"
	desc = "Last words are for fools who haven’t said enough."
	icon_state = "death"
	new_armor = list(BURN = 80, BRAIN = 40, BRUTE = 60, TOX = 50)		//Melee with slow
	//realized_ability = /datum/action/spell_action/aimed/gleaming_eyes

/obj/item/clothing/suit/armor/ego_gear/realization/fear
	name = "passion of the fearless one"
	desc = "Man fears the darkness, and so he scrapes away at the edges of it with fire.\
	Grants various buffs to life of a daredevil when equipped."
	icon_state = "fear"
	new_armor = list(BURN = 80, BRAIN = 70, BRUTE = 70, TOX = 10)		//Melee, makes weapon better
	flags_inv = null

/obj/item/clothing/suit/armor/ego_gear/realization/exsanguination
	name = "exsaungination"
	desc = "It keeps your suit relatively clean."
	icon_state = "exsanguination"
	new_armor = list(BURN = 60, BRAIN = 80, BRUTE = 60, TOX = 50)			//No ability

/obj/item/clothing/suit/armor/ego_gear/realization/ember_matchlight
	name = "ember matchlight"
	desc = "If I must perish, then I'll make you meet the same fate."
	icon_state = "ember_matchlight"
	new_armor = list(BURN = 80, BRAIN = 40, BRUTE = 50, TOX = 60)		//Melee
	//realized_ability = /datum/action/spell_action/fire_explosion

/obj/item/clothing/suit/armor/ego_gear/realization/sakura_bloom
	name = "sakura bloom"
	desc = "The forest will never return to its original state once it dies. Cherish the rain."
	icon_state = "sakura_bloom"
	new_armor = list(BURN = 60, BRAIN = 80, BRUTE = 40, TOX = 50)		//Healing
	//realized_ability = /datum/action/spell_action/petal_blizzard
	hat = /obj/item/clothing/head/ego_hat/sakura_hat

/obj/item/clothing/head/ego_hat/sakura_hat
	name = "sakura bloom"
	desc = "Spring is coming."
	//worn_icon = 'icons/mob/clothing/big_hat.dmi'
	//icon_state = "sakura"

/obj/item/clothing/suit/armor/ego_gear/realization/stupor
	name = "stupor"
	desc = "Drink! Drink yourselves into a stupor! Foul tasting louts like you won't satisfy me until you're all as pickled as me, hah!" //Descriptions made by Anonmare
	icon_state = "stupor" //Art by TemperanceTempy
	new_armor = list(BURN = 80, BRAIN = 30, BRUTE = 50, TOX = 70)		//Defensive
	hat = /obj/item/clothing/head/ego_hat/stupor

/obj/item/clothing/head/ego_hat/stupor
	name = "stupor"
	desc = "Many people look for oblivion at the bottom of the glass, I can't be blamed if I give it to 'em now, can I?"
	icon_state = "stupor"

/* HE Realizations */

/obj/item/clothing/suit/armor/ego_gear/realization/grinder
	name = "grinder MK52"
	desc = "The blades are not just decorative."
	icon_state = "grinder"
	new_armor = list(BURN = 70, BRAIN = 40, BRUTE = 60, TOX = 60)		//Melee
	//realized_ability = /datum/action/spell_action/aimed/helper_dash

/obj/item/clothing/suit/armor/ego_gear/realization/bigiron
	name = "big iron"
	desc = "A hefty silk coat with a blue smock."
	icon_state = "big_iron"
	new_armor = list(BURN = 60, BRAIN = 50, BRUTE = 60, TOX = 60)		//Ranged

/obj/item/clothing/suit/armor/ego_gear/realization/eulogy
	name = "solemn eulogy"
	desc = "Death is not extinguishing the light, it is putting out the lamp as dawn has come."
	icon_state = "eulogy"
	new_armor = list(BURN = 30, BRAIN = 80, BRUTE = 80, TOX = 40)

/obj/item/clothing/suit/armor/ego_gear/realization/ourgalaxy
	name = "our galaxy"
	desc = "Walk this night sky with me. The galaxy dotted with numerous hopes. We'll count the stars and never be alone."
	icon_state = "ourgalaxy"
	new_armor = list(BURN = 40, BRAIN = 60, BRUTE = 70, TOX = 60)		//Healing
	//realized_ability = /datum/action/spell_action/galaxy_gift

/obj/item/clothing/suit/armor/ego_gear/realization/forever
	name = "together forever"
	desc = "I would move Heaven and Earth to be together forever with you."
	icon_state = "forever"
	new_armor = list(BURN = 60, BRAIN = 80, BRUTE = 60, TOX = 50)		//No ability
	hat = /obj/item/clothing/head/ego_hat/forever_hat

/obj/item/clothing/head/ego_hat/forever_hat
	name = "together forever"
	desc = "I've gotten used to bowing and scraping to you, so I cut off my own limbs."
	icon_state = "forever"

/obj/item/clothing/suit/armor/ego_gear/realization/wisdom
	name = "endless wisdom"
	desc = "Poor stuffing of straw. I'll give you the wisdom to ponder over anything."
	icon_state = "wisdom"
	new_armor = list(BURN = 60, BRAIN = 80, BRUTE = 60, TOX = 50)		//No ability
	flags_inv = HIDESHOES
	hat = /obj/item/clothing/head/ego_hat/wisdom_hat

/obj/item/clothing/head/ego_hat/wisdom_hat
	name = "endless wisdom"
	desc = "I was left with nothing, nothing but empty brains and rotting bodies."
	icon_state = "wisdom"

/obj/item/clothing/suit/armor/ego_gear/realization/empathy
	name = "boundless empathy"
	desc = "Tin-cold woodsman. I'll give you the heart to forgive and love anyone."
	icon_state = "empathy"
	new_armor = list(BURN = 80, BRAIN = 60, BRUTE = 60, TOX = 50)		//No ABility
	flags_inv = HIDEGLOVES|HIDESHOES

/obj/item/clothing/suit/armor/ego_gear/realization/valor
	name = "unbroken valor"
	desc = "Cowardly kitten, I'll give you the courage to stand up to anything and everything."
	icon_state = "valor"
	new_armor = list(BURN = 70, BRAIN = 50, BRUTE = 50, TOX = 80)		//No ability

/obj/item/clothing/suit/armor/ego_gear/realization/home //This name would SO much easier if we didnt aleady USE HOMING INSTINCT AHHHHHHHHHHHHHHHHHHH
	name = "forever home"
	desc = "Last of all, road that is lost. I will send you home."
	icon_state = "home"
	new_armor = list(BURN = 40, BRAIN = 60, BRUTE = 80, TOX = 50)		//Support
	flags_inv = HIDEGLOVES|HIDESHOES
	//realized_ability = /datum/action/spell_action/aimed/house_spawn

/obj/item/clothing/suit/armor/ego_gear/realization/dimension_ripper
	name = "dimension ripper"
	desc = "Lost and abandoned, tossed out like trash, having no place left in the City."
	icon_state = "dimension_ripper"
	new_armor = list(BURN = 70, BRAIN = 50, BRUTE = 60, TOX = 50)		//Melee
	//realized_ability = /datum/action/spell_action/rip_space

/* WAW Realizations */

/obj/item/clothing/suit/armor/ego_gear/realization/goldexperience
	name = "gold experience"
	desc = "A jacket made of gold is hardly light. But it shines like the sun."
	icon_state = "gold_experience"
	new_armor = list(BURN = 80, BRAIN = 60, BRUTE = 50, TOX = 40)			//Melee
	//realized_ability = /datum/action/spell_action/road_of_gold

/obj/item/clothing/suit/armor/ego_gear/realization/quenchedblood
	name = "quenched with blood"
	desc = "A suit of armor, forged with tears and quenched in blood. Justice will prevail."
	icon_state = "quenchedblood"
	new_armor = list(BURN = 50, BRAIN = 60, BRUTE = 40, TOX = 80)		//Ranged
	flags_inv = HIDEJUMPSUIT|HIDESHOES|HIDEGLOVES
	//realized_ability = /datum/action/spell_action/aimed/despair_swords

/obj/item/clothing/suit/armor/ego_gear/realization/lovejustice
	name = "love and justice"
	desc = "If my duty is to defeat and reform evil, can I reform my evil self as well?"
	icon_state = "lovejustice"
	new_armor = list(BURN = 60, BRAIN = 50, BRUTE = 70, TOX = 50)		//Healing
	flags_inv = HIDEGLOVES
	//realized_ability = /datum/action/spell_action/aimed/arcana_slave

/obj/item/clothing/suit/armor/ego_gear/realization/woundedcourage
	name = "wounded courage"
	desc = "'Tis better to have loved and lost than never to have loved at all.\
	Grants you the ability to use a Blind Rage in both hands and attack with both at the same time."
	icon_state = "woundedcourage"
	new_armor = list(BURN = 70, BRAIN = 40, BRUTE = 70, TOX = 50)		//Melee
	flags_inv = HIDEJUMPSUIT | HIDEGLOVES | HIDESHOES
	//realized_ability = /datum/action/spell_action/justice_and_balance
	hat = /obj/item/clothing/head/ego_hat/woundedcourage_hat

/obj/item/clothing/head/ego_hat/woundedcourage_hat
	name = "wounded courage"
	desc = "An excuse to overlook your own misdeeds."
	icon_state = "woundedcourage"
	flags_inv = HIDEMASK | HIDEEYES

/obj/item/clothing/suit/armor/ego_gear/realization/crimson
	name = "crimson lust"
	desc = "They are always watching you."
	icon_state = "crimson"
	new_armor = list(BURN = 80, BRAIN = 50, BRUTE = 60, TOX = 60)		//No Ability

/obj/item/clothing/suit/armor/ego_gear/realization/eyes
	name = "eyes of god"
	desc = "And the eyes of god spoke: You will be saved."
	icon_state = "eyes"
	new_armor = list(BURN = 50, BRAIN = 60, BRUTE = 80, TOX = 40)		//Support
	//realized_ability = /datum/action/spell_action/lamp

/obj/item/clothing/suit/armor/ego_gear/realization/eyes/examine(mob/user)
	. = ..()
	. += "<span class='notice'>The wearer can sense it whenever an abnormality breaches.</span>"

/obj/item/clothing/suit/armor/ego_gear/realization/eyes/equipped(mob/user, slot, initial = FALSE)
	. = ..()
	if(item_action_slot_check(slot, user))
		RegisterSignal(SSdcs, COMSIG_GLOB_ABNORMALITY_BREACH, PROC_REF(OnAbnoBreach))

/obj/item/clothing/suit/armor/ego_gear/realization/eyes/dropped(mob/user)
	UnregisterSignal(SSdcs, COMSIG_GLOB_ABNORMALITY_BREACH)
	return ..()

/obj/item/clothing/suit/armor/ego_gear/realization/eyes/proc/OnAbnoBreach(datum/source, mob/living/simple_animal/hostile/abnormality/abno)
	SIGNAL_HANDLER
	if(!ishuman(loc))
		return
	if(loc.z != abno.z)
		return
	addtimer(CALLBACK(src, PROC_REF(NotifyEscape), loc, abno), rand(1 SECONDS, 3 SECONDS))

/obj/item/clothing/suit/armor/ego_gear/realization/eyes/proc/NotifyEscape(mob/living/carbon/human/user, mob/living/simple_animal/hostile/abnormality/abno)
	if(QDELETED(abno) || abno.stat == DEAD || loc != user)
		return
	to_chat(user, "<span class='warning'>You can sense the escape of [abno]...</span>")
	playsound(get_turf(user), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/bigbird/hypnosis.ogg', 25, 1, -4)
	var/turf/start_turf = get_turf(user)
	var/turf/last_turf = get_ranged_target_turf_direct(start_turf, abno, 5)
	var/list/navline = get_line(start_turf, last_turf)
	for(var/turf/T in navline)
		new /obj/effect/temp_visual/cult/turf/floor(T)

/obj/item/clothing/suit/armor/ego_gear/realization/cruelty
	name = "wit of cruelty"
	desc = "In the face of pain there are no heroes."
	icon_state = "cruelty"
	new_armor = list(BURN = 80, BRAIN = 50, BRUTE = 70, TOX = 50)		//No Ability
	flags_inv = HIDEJUMPSUIT|HIDEGLOVES|HIDESHOES

/obj/item/clothing/suit/armor/ego_gear/realization/bell_tolls
	name = "for whom the bell tolls"
	desc = "I suppose if a man has something once, always something of it remains."
	icon_state = "thirteen"
	new_armor = list(BURN = 50, BRAIN = 50, BRUTE = 80, TOX = 70)		//No Ability

/obj/item/clothing/suit/armor/ego_gear/realization/capitalism
	name = "capitalism"
	desc = "While the miser is merely a capitalist gone mad, the capitalist is a rational miser."
	icon_state = "capitalism"
	new_armor = list(BURN = 70, BRAIN = 70, BRUTE = 60, TOX = 30)		//Support
	//realized_ability = /datum/action/spell_action/shrimp

/obj/item/clothing/suit/armor/ego_gear/realization/duality_yang
	name = "duality of harmony"
	desc = "When good and evil meet discord and assonance will be quelled."
	icon_state = "duality_yang"
	new_armor = list(BURN = 40, BRAIN = 80, BRUTE = 40, TOX = 70)		//Healing
	//realized_ability = /datum/action/spell_action/tranquility

/obj/item/clothing/suit/armor/ego_gear/realization/duality_yin
	name = "harmony of duality"
	desc = "All that isn't shall become all that is."
	icon_state = "duality_yin"
	new_armor = list(BURN = 70, BRAIN = 40, BRUTE = 80, TOX = 40)		//Support
	//realized_ability = /datum/action/spell_action/aimed/yin_laser

/obj/item/clothing/suit/armor/ego_gear/realization/repentance
	name = "repentance"
	desc = "If you pray hard enough, perhaps god will answer it?"
	icon_state = "repentance"
	new_armor = list(BURN = 80, BRAIN = 40, BRUTE = 40, TOX = 70)		//Healing
	//realized_ability = /datum/action/spell_action/prayer

/obj/item/clothing/suit/armor/ego_gear/realization/nest
	name = "living nest"
	desc = "Grow eternally, let our nest reach the horizon!"
	icon_state = "nest"
	new_armor = list(BURN = 80, BRAIN = 60, BRUTE = 50, TOX = 40)		//Support
	//realized_ability = /datum/action/spell_action/nest
	var/CanSpawn = FALSE

/obj/item/clothing/suit/armor/ego_gear/realization/nest/equipped(mob/user, slot, initial = FALSE)
	. = ..()
	if(slot == ITEM_SLOT_OCLOTHING)
		CanSpawn = TRUE
		addtimer(CALLBACK(src, PROC_REF(Spawn),user), 10 SECONDS)

/obj/item/clothing/suit/armor/ego_gear/realization/nest/dropped(mob/user)
	CanSpawn = FALSE
	return ..()

/obj/item/clothing/suit/armor/ego_gear/realization/nest/proc/Reset(mob/user)
	if(!CanSpawn)
		return
	Spawn(user)

/obj/item/clothing/suit/armor/ego_gear/realization/nest/proc/Spawn(mob/user)
	if(!CanSpawn)
		return
	addtimer(CALLBACK(src, PROC_REF(Reset),user), 10 SECONDS)
	playsound(get_turf(user), 'sound/misc/moist_impact.ogg', 30, 1)
	var/mob/living/simple_animal/hostile/naked_nest_serpent_friend/W = new(get_turf(user))
	W.origin_nest = user

/* ALEPH Realizations */

/obj/item/clothing/suit/armor/ego_gear/realization/alcoda
	name = "al coda"
	desc = "Harmonizes well."
	icon_state = "coda"
	new_armor = list(BURN = 70, BRAIN = 100, BRUTE = 60, TOX = 20)		//No Ability

/obj/item/clothing/suit/armor/ego_gear/realization/head
	name = "head of god"
	desc = "And the head of god spoke: You will be judged."
	icon_state = "head"
	new_armor = list(BURN = 50, BRAIN = 50, BRUTE = 50, TOX = 80)		//Support
	//realized_ability = /datum/action/spell_action/judgement

/obj/item/clothing/suit/armor/ego_gear/realization/shell
	name = "shell"
	desc = "Armor of humans, for humans, by humans. Is it as 'human' as you?"
	icon_state = "shell"
	//realized_ability = /datum/action/spell_action/goodbye
	new_armor = list(BURN = 80, BRAIN = 60, BRUTE = 30, TOX = 60)			//Melee

/obj/item/clothing/suit/armor/ego_gear/realization/laughter
	name = "laughter"
	desc = "I do not recognize them, I must not, lest I end up like them. \
			Through the silence, I hear them, I see them. The faces of all my friends are with me laughing too."
	icon_state = "laughter"
	new_armor = list(BURN = 50, BRAIN = 50, BRUTE = 80, TOX = 50)		//Support
	flags_inv = HIDEJUMPSUIT|HIDESHOES|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR
	//realized_ability = /datum/action/spell_action/screach

/obj/item/clothing/suit/armor/ego_gear/realization/fallencolors
	name = "fallen color"
	desc = "Where does one go after falling into a black hole?"
	icon_state = "fallencolors"
	//realized_ability = /datum/action/spell_action/aimed/blackhole
	new_armor = list(BURN = 40, BRAIN = 80, BRUTE = 80, TOX = 30)		//Defensive
	var/canSUCC = TRUE

/obj/item/clothing/suit/armor/ego_gear/realization/fallencolors/equipped(mob/user, slot, initial = FALSE)
	. = ..()
	if(slot == ITEM_SLOT_OCLOTHING)
		RegisterSignal(user, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(OnDamaged))

/obj/item/clothing/suit/armor/ego_gear/realization/fallencolors/dropped(mob/user)
	UnregisterSignal(user, COMSIG_MOB_APPLY_DAMAGE)
	return ..()

/obj/item/clothing/suit/armor/ego_gear/realization/fallencolors/proc/Reset()
	canSUCC = TRUE

/obj/item/clothing/suit/armor/ego_gear/realization/fallencolors/proc/OnDamaged(mob/living/carbon/human/user)
	//goonchem_vortex(get_turf(src), 1, 3)
	if(!canSUCC)
		return
	canSUCC = FALSE
	addtimer(CALLBACK(src, PROC_REF(Reset)), 2 SECONDS)
	for(var/turf/T in view(3, user))
		new /obj/effect/temp_visual/revenant(T)
		for(var/mob/living/L in T)
			if(user.faction_check_atom(L, FALSE))
				continue
			if(L.stat == DEAD)
				continue
			var/atom/throw_target = get_edge_target_turf(L, get_dir(L, get_step_away(L, get_turf(src))))
			L.throw_at(throw_target, 1, 1)
			L.apply_damage(5, BRUTE, null, L.run_armor_check(null, BRUTE), spread_damage = TRUE)


/* Effloresced (Personal) E.G.O */
/obj/item/clothing/suit/armor/ego_gear/realization/farmwatch
	name = "farmwatch"
	desc = "Haha. You're right, the calf doesn't recognize me."
	icon_state = "farmwatch"
	new_armor = list(BURN = 70, BRAIN = 70, BRUTE = 40, TOX = 60)
	hat = /obj/item/clothing/head/ego_hat/farmwatch_hat
	//realized_ability = /datum/action/spell_action/ego_assimilation/farmwatch

/obj/item/clothing/head/ego_hat/farmwatch_hat
	name = "farmwatch"
	desc = "I'll gather a team again... hire another secretary... There'll be a lot to do."
	icon_state = "farmwatch"

/obj/item/clothing/suit/armor/ego_gear/realization/spicebush
	name = "spicebush"
	desc = "I've always wished to be a bud. Soon to bloom, bearing a scent within."
	icon_state = "spicebush"
	new_armor = list(BURN = 40, BRAIN = 70, BRUTE = 70, TOX = 60)
	//realized_ability = /datum/action/spell_action/ego_assimilation/spicebush

/obj/item/clothing/suit/armor/ego_gear/realization/desperation
	name = "Scorching Desperation"
	desc = "Those feelings only become more dull over time."
	icon_state = "desperation"
	new_armor = list(BURN = 70, BRAIN = 40, BRUTE = 60, TOX = 60)
	//realized_ability = /datum/action/spell_action/overheat

/obj/item/clothing/suit/armor/ego_gear/realization/gasharpoon
	name = "gasharpoon"
	desc = "We must find the Pallid Whale! Look alive, men! Spring! Roar!"
	icon_state = "gasharpoon"
	new_armor = list(BURN = 60, BRAIN = 70, BRUTE = 20, TOX = 80)//230, required for the corresponding weapon abilities
	//realized_ability = /datum/action/spell_action/ego_assimilation/gasharpoon
