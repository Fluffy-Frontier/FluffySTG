# TGMC_ALIENS

## Описание

Модуль, добавляющий новых ксеноморфов. В прошлом эти ксеносы были на нове, до новы на скайрате, а те в свою очередь были портом ксеноморфов с ТГМС.

## TG File Changes

- MOVED:
  code\modules\mob\living\carbon\human\human_defense.dm: `/mob/living/carbon/human/attack_alien`
  TO:
  tff_modular\modules\tgmc_xenos\code\defense\human_defense.dm
- OVERRIDE: code\game\objects\structures\aliens.dm: `/obj/structure/alien/weeds/should_atmos_process`
  IN:
  tff_modular\modules\tgmc_xenos\code\structures\alien_structures.dm

Additions:

- code\game\objects\structures\aliens.dm: `/obj/structure/alien/egg` && `/obj/structure/alien/egg/Initialize()`
- code\modules\mob\living\carbon\alien\special\alien_embryo.dm: `/obj/item/organ/body_egg/alien_embryo` && `/obj/item/organ/body_egg/alien_embryo/proc/on_poll_concluded()`
- code\modules\mob\living\carbon\alien\special\facehugger.dm: `/obj/item/clothing/mask/facehugger` && `/obj/item/clothing/mask/facehugger/proc/Impregnate()`
- code/modules/vehicles/mecha/\_mecha.dm: `/obj/vehicle/sealed/mecha/proc/melee_attack_effect()`

## Defines

IN: code/\_\_DEFINES/~ff_defines/\_globalvars/traits/declarations.dm

Traits:

- `TRAIT_XENO_INNATE`
- `TRAIT_XENO_ABILITY_GIVEN`
- `TRAIT_XENO_HEAL_AURA`
- `TRAIT_XENO_FORTIFY`

Global Vars:

- `xeno_rounymode`

## Helpers

IN: code/\_\_HELPERS/~ff_helpers/is_helpers.dm

- istgmcalien
- istgmcalienqueen
- istgmcalienpraetorian
- istgmcalienravager
- istgmcaliencrusher
- istgmcalienspitter
- istgmcalientier2

## Credits

TGMC & CM - Where the sprites, sound, and ideas for abilities came from

Original developer of these xenos (apparently it's @Paxilmaniac) - Porting the xenos from TGMC and adopting their code to work with tg-skyrat build
