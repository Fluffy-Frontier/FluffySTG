# TGMC_ALIENS

## Описание

Модуль, добавляющий новых ксеноморфов. В прошлом эти ксеносы были на нове, до новы на скайрате, а те в свою очередь были портом ксеноморфов с ТГМС.

## TG File Changes

- MOVED:
 code\modules\mob\living\carbon\human\human_defense.dm: `/mob/living/carbon/human/attack_alien`
 TO:
 tff_modular\modules\tgmc_xenos\code\defense\human_defense.dm
- Hi!!! Hello!!!

Additions:

- code/modules/mob/living/living_defense.dm: `/mob/living/attack_alien`
- code/modules/vehicles/mecha/_mecha.dm: `/obj/vehicle/sealed/mecha/proc/melee_attack_effect`

## Defines

IN: code/__DEFINES/~ff_defines/_globalvars/traits/declarations.dm

- TRAIT_XENO_INNATE
- TRAIT_XENO_ABILITY_GIVEN
- TRAIT_XENO_HEAL_AURA
- TRAIT_XENO_FORTIFY

## Helpers

IN: code/__HELPERS/~ff_helpers/is_helpers.dm

- istgmcalien
- istgmcalienqueen
- istgmcalienpraetorian
- istgmcalienravager
- istgmcaliencrusher
- istgmcalienspitter
- istgmcalientier2

## Credits

TGMC & CM - Where the sprites, sound, and ideas for caste abilities came from
Original developer of these xenos (apparently it's @Paxilmaniac) - Porting the xenos from TGMC and adopting their stuff to work with our code
