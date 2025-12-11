# Economics Module

This module contains economic balance changes for FluffySTG.

## Changes

### Starting Paychecks

Players start the round with accumulated paychecks from previous "shifts". The number of starting paychecks has been cut in half.

- **STARTING_PAYCHECKS**: 20 → 10 (halved - players start with 10 paychecks worth of credits instead of 20)

### Boulder Processing

- Boulder refinery resource yield reduced to 0.8 (80% of original)

### Cargo Prices

Nova cargo item prices are doubled if the original cost is less than 1000 credits. This includes:

- Emergency supplies (air tanks)
- Engineering tools
- Miscellaneous items (carpets, xenoarch intern kit)
- NIF software
- Medical supplies and equipment
- Security gear
- Critters and livestock
- Food and service items
- Import crates

Examples of changed items by category:

**Emergency Supplies:**

- Air supplies (nitrogen/oxygen/plasma tanks): 50 → 100 credits (1 → 2 crew paychecks)

**Miscellaneous:**

- Xenoarch intern kit: 750 → 1500 credits (15 → 30 crew paychecks)

**Medical:**

- First aid pouches: 300 → 600 credits (6 → 12 crew paychecks)
- First aid single packs: 200 → 400 credits (4 → 8 crew paychecks)

**NIF & Implants:**

- Money sense NIFSoft: 150 → 300 credits (3 → 6 crew paychecks)
- Shapeshifter NIFSoft: 150 → 300 credits (3 → 6 crew paychecks)
- Hivemind NIFSoft: 150 → 300 credits (3 → 6 crew paychecks)
- Summoner NIFSoft: 75 → 150 credits (1.5 → 3 crew paychecks)

**Security:**

- Armor crates: 150 → 300 credits (3 → 6 crew paychecks)
- Helmet crates: 150 → 300 credits (3 → 6 crew paychecks)

**Livestock:**

- Mouse: 300 → 600 credits (6 → 12 crew paychecks)
- Chinchilla: 350 → 700 credits (7 → 14 crew paychecks)
- Fennec: 350 → 700 credits (7 → 14 crew paychecks)

Note: Paycheck equivalents are calculated using PAYCHECK_CREW = 50 credits per paycheck. Items costing 1000+ credits were not doubled.

### Materials Market

- Galactic Materials Market now disables selling materials back to GMM due to "Great Crash of 2564" lore.
- Players can still purchase materials from the market.

### Bulk Material Supply Packs

Added large bulk material crates for assistant projects and construction:

- 50 Glass Sheets: 300 → 600 credits
- 50 Iron Sheets: 250 → 500 credits
- 20 Plasteel Sheets: 1500 → 3000 credits
- 50 Plasteel Sheets: 3300 → 6600 credits
- 50 Stone Bricks: 300 → 600 credits

## Additional Nova Economy Features Not Yet Implemented

- **CIV_JOB_RANDOM**: Expanded from 15 to 24 (adds more civilian bounty job options)
- **Company Imports System**: Nova Sector's company imports system is implemented but untouched in FluffySTG (no price adjustments)
