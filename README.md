## EItweaks

EItweaks is a mod for Evil Islands: Curse of the Lost Soul. It includes the fixes of the unofficial [patch 1.07](docs/patch-1.07.md) and works with the Russian, English and German versions of the game.

- [Overview](#overview)
- [Installation](#installation)
- [Building from source](docs/building.md)
- [Support](#support)
- [Author](#author)
- [Changelog](CHANGELOG.md)
- [Todo](TODO.md)

### Overview

- [Fixes](#fixes)
- [Tweaks](#tweaks)
  - [Gameplay](#gameplay)
  - [Speedup](#speedup)
  - [Items](#items)
  - [Regeneration](#regeneration)
  - [Resistances](#resistances)

EItweaks' own fixes and tweaks apply to the single player game; the multiplayer database is 1.07's, with the change listed among the [patch 1.07 fixes](docs/patch-1.07.md).

#### Fixes
- The fixes of the unofficial [patch 1.07](docs/patch-1.07.md), for every language.
- Gipath bats description correctly states fire damage.
- Stony harpies have extra protection from lightning instead of fire.
- Grey harpies have extra protection from acid instead of fire.
- Dragons and items from dragon hide have extra protection from the corresponding elements.
- Dragons description correctly states their damage type.
- Magic-using banshees, dragons, bats and evil eyes show correct damage values in the info window.
- Toads and will-o-wisps show their real magic damage.
- Red harpies show their real damage type and range.
- Goblins with slings do bludgeoning damage.
- Running depletes stamina by points rather than percentage, as intended, so a character can run longer as stamina grows: longer than before above 35 maximum stamina, shorter below it. This uses the included [SpellAddon](https://evilislandsaddon.forumotion.com/) (see [Installation](#installation)).

#### Tweaks

##### Gameplay
- Human (PC and NPC) run speed slightly increased.
- Human (PC and NPC) walk speed considerably increased.
- Zak no longer has a level of backstab perk.
- Airy grants +2 to Sensory Magic and Trickster +2 to Use/Steal, instead of +10.
- Reduced over-the-top armor values for golems and other "unkillable" monsters from 150 to 44.
- Dragons on Gipath no longer have more than 1000 hit points.

##### Speedup
- 1C/Nival intro movies are disabled.
- New game starting movie is disabled.
- Help screens are disabled by default.
- New game "My head hurts" cutscene is shortened.

##### Items
- Dragons drop hide in addition to bones.
- Stronger Green Dragon Horn.
- Hide armor is sold in the Gipath shop.
- Half effect rune is sold on Gipath.

##### Regeneration
- Disabled for undead, golems, shadows and will-o-wisps.
- Halved for ogres.
- Green/blue trolls are untouched, but black ones toned down to match green/blue.
- Ice elementals regenerate like other elementals.
- Reduced dramatically for all other monsters and characters.

##### Resistances
- Hard leather provides extra protection against piercing and bludgeoning, matching monster protection.
- Hide provides extra protection against piercing.
- Fur provides extra protection against bludgeoning.
- Ogres and lizardmen have the same protection against piercing and bludgeoning (Hadagan ogres keep their piercing protection).
- Skeletons have extra protection against piercing; trolls have no extra protection against acid.
- Cyclopes have no extra magic protection.
- Lava elementals get extra protection from fire, Snow elementals get vulnerability to it.
- Lightning vulnerability for NPCs using metal armor and golems.

### Installation

1. Make sure the game is at version 1.06. The GOG English and Russian versions are; for the GOG German version, install the official German [patch 1.06](https://allods.gipat.ru/index.php?p=filesei) first. Patch 1.07 is not needed: EItweaks includes its fixes.
1. Download the latest EItweaks [release](https://github.com/BGforgeNet/EItweaks/releases/latest) for your game's language (`ru`, `en` or `de`), unzip it.
1. Install [EI starter](https://www.gipath.org/forum/thread-3828.html) 1.046.1 with the installer in the `EI starter` folder, unless you already have it.
1. Put `eitweaks` into the `Mods` subdirectory of starter's installation directory.
1. From the `SpellAddon` folder, copy `SpellAddonXa.asi`, `SpellAddonInfo.txt` and `SPELLADDON.INI` into the game directory (with the newest starter, into its `Engine` directory as well). This `SPELLADDON.INI` changes nothing in the game; EItweaks brings its own settings, used only when EItweaks is selected.
1. Launch starter, select EItweaks in the dropdown.

### Support
* Report bugs and suggest features on [Github](https://github.com/BGforgeNet/EItweaks/issues).
* Discuss and ask questions on the [forum](https://forums.bgforge.net/viewtopic.php?f=22&t=183).

### Author
[Magus at BGforge](https://forums.bgforge.net/viewtopic.php?f=22&t=183)
