## Fixes

- [1.08](#108)
- [1.07](#107)

### 1.08

#### Additional fixes on top of 1.07

- Magic using monsters now show the corresponding damage type in description window. That includes bats, dragons, banshees, evil eyes, toads, will-o-wisps, harpies.
- Goblins with slings do bludgeoning damage.
- Dark banshees' lightning had broken spell settings, as 1.07 fixed for multiplayer.
- Red harpies show their real damage range.
- Matching protections - the monsters generally get protection from the magic type that they are using:
  - Stony harpies have extra protection from lightning instead of fire.
  - Grey harpies have extra protection from acid instead of fire.
  - Dragons and items from dragon hide have extra protection from the corresponding elements.
- Running depletes stamina by points rather than percentage, as intended, so a character can run longer as stamina grows: longer than before above 75 maximum stamina, shorter below it. This uses the included [SpellAddon](spelladdon.md).

#### GOG release fixes

Additionally, EItweaks fixes multiple issues _introduced_ by GOG:

- The camera tilts smoothly instead of jumping.
- The quest marker and hero lights have their original colors.
- The German version is not patched to 1.06: EItweaks includes the German patch 1.06 data (see [German version](de.md)).

### 1.07

EItweaks includes the fixes of the [unofficial patch 1.07](https://allods.gipat.ru/index.php?p=filesei#patch-1-07) by Gipat Group. The original patch is for the Russian version only; EItweaks carries its fixes to every language.

- Campaign map scripts
  - Trolls coming back to the witch's cave
  - Go-Go's dialogues
  - The goblin sentry phrase repeating
  - Levers and mechanisms that could trap the player
  - Quest rewards and experience given on every visit to a zone.
- Single player database
  - Hadagan top armor (helm, plate, leggings) is sold in a shop.
  - Positions and switch times of levers and mechanisms.
  - A Kania gang member no longer wears two helmets.
  - Boar head height; toad footstep sounds.
- Multiplayer database
  - Spells light up their surroundings, as in single player.
  - Banshee mages' lightning and a strength potion had broken spell settings.
  - An octopus drops loot.
- Russian: the texts.
- Corrected marker position for the "Punishing goblins" quest on the world map.
- Multiplayer: spears, maces, hammers and clubs give no attack skill bonus (1.07 added one).
