// Nubbers
#define isnabber(A) (is_species(A, /datum/species/nabber))

// TGMC Xenomorph
#define istgmcalien(A) (istype(A, /mob/living/carbon/alien/adult/tgmc))
#define istgmcalienqueen(A) (istype(A, /mob/living/carbon/alien/adult/tgmc/queen))
#define istgmcalienpraetorian(A) (istype(A, /mob/living/carbon/alien/adult/tgmc/praetorian))
#define istgmcalienravager(A) (istype(A, /mob/living/carbon/alien/adult/tgmc/ravager))
#define istgmcaliencrusher(A) (istype(A, /mob/living/carbon/alien/adult/tgmc/crusher))
#define istgmcalienspitter(A) (istype(A, /mob/living/carbon/alien/adult/tgmc/spitter))

#define istgmcalientier2(A) (istgmcalienpraetorian(A) || istgmcalienravager(A) || istgmcaliencrusher(A) || istgmcalienspitter(A))
