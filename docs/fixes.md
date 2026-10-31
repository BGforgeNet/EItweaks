## Fixes

- [1.08](#108)
- [1.07](#107)

### 1.08

#### Additional fixes on top of 1.07

- Magic-using monsters show the corresponding damage type in the description window. That includes bats, dragons, banshees, evil eyes, toads, will-o-wisps and harpies.
- Goblins with slings do bludgeoning damage.
- Dark banshees' lightning had broken spell settings, as 1.07 fixed for multiplayer.
- Red harpies show their real damage range.
- Mountain lizards, grey harpies, foxbats and black foxbats wear their own textures from the game files, instead of those of lake lizards, red harpies and bats.
- The wings of foxbats and black foxbats have their names the right way round.
- Black banshees in Death canyon at night wear the black banshee texture, not the white one.
- Black Clan woodsfolk in the City environs wear their own clan's texture, not the White Clan's. Black Clan magicians wear the magician texture from the game files, and two Green Clan magicians wear theirs, like the other magicians.
- Matching protections: monsters generally get protection from the magic type they use.
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

- Campaign map scripts:
  - Trolls killed on the road to the witch no longer show up again in her cave.
  - GoGo in the village:
    - The goblin sacred object no longer reappears in its old place on The river and the islands after "Interrogate GoGo together with the Elder", only after "Giving the Goblin his sacred object back".
    - GoGo runs away after getting the sacred object back, instead of vanishing.
    - After "Prevent a goblin raid", the village no longer plays the dialogue asking where GoGo is while GoGo runs past Zak.
  - Zak no longer says his goblin sentry line on every visit to the Foothills.
  - Levers and mechanisms no longer trap the player.
  - Quest rewards and experience are no longer given on every visit to a zone.
- Single player database:
  - Hadagan top armor (helm, plate, leggings) is sold in a shop.
  - Positions and switch times of levers and mechanisms.
  - A Kania gang member no longer wears two helmets.
  - Boar head height; toad footstep sounds.
- Multiplayer database:
  - Spells light up their surroundings, as in single player.
  - Banshee mages' lightning and a strength potion had broken spell settings.
  - An octopus drops loot.
- Russian: text corrections, among them the Actions skill and the "select" runes for humans, goblins, orcs and lizards.
- The marker of the "Punishing goblins" quest is in the right place on the world map.

Not carried over: 1.07's attack skill bonus for spears, maces, hammers and clubs in multiplayer.
