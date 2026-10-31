## EItweaks

EItweaks is a mod for Evil Islands: Curse of the Lost Soul. It includes the fixes of the unofficial [patch 1.07](docs/patch-1.07.md) and works with the Russian, English and German versions of the game.

- [Overview](#overview)
- [Installation](#installation)
- [Building from source](docs/building.md)
- [How the starter version works](docs/starter.md)
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
- GOG versions: the camera tilts smoothly instead of jumping, and the quest marker and hero lights have their original colors. The GOG installers leave out the camera, light and shadow settings the CD installer wrote; the installer sets them, keeping any the player has changed.
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
- Help screens are disabled by default; Options > Windows > Show tutorial turns them back on. The standalone version disables the camp and map ones only: turn off Show tutorial for the rest.
- New game "My head hurts" cutscene is shortened (Russian).

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

The game must be at version 1.06. The GOG versions are ready as they are: the English and Russian ones are 1.06, and for the German one EItweaks includes the data of the German patch 1.06 (its `game.exe` is already 1.06). A German CD version needs the official German [patch 1.06](https://allods.gipat.ru/index.php?p=filesei) first. Patch 1.07 is not needed: EItweaks includes its fixes.

Download the installer, `eitweaks-<version>-setup.exe`, from the latest [release](https://github.com/BGforgeNet/EItweaks/releases/latest) and run it. It asks for:
1. The game folder, found by itself for an installed game.
1. The game's language (Russian, English or German), detected from the game folder.
1. The version:
   - With [EI starter](https://www.gipath.org/forum/thread-3828.html) (recommended): EItweaks becomes a mod selected in starter's dropdown, and the game's files stay untouched. It needs EI starter 1.046.1; when starter is missing, the installer downloads it from its site and runs its installer. Afterwards, launch starter: EItweaks is already selected.
   - Standalone: copied over the game's files, for playing without starter; launch the game as usual. Each file it replaces is backed up into `eitweaks-backup` and put back when EItweaks is uninstalled. It lacks a few changes the starter version has: 1.07's missing face texture fix and, in Russian, the shortened "My head hurts" cutscene.

EItweaks installs SpellAddon into the game folder. An older SpellAddon there, or in starter's `Engine` folder, would load together with it, so the installer moves it into an `eitweaks-old-SpellAddon` folder beside it; the standalone version keeps it in `eitweaks-backup` and puts it back when uninstalled.
### Support
* Report bugs and suggest features on [Github](https://github.com/BGforgeNet/EItweaks/issues).
* Discuss and ask questions on the [forum](https://forums.bgforge.net/viewtopic.php?f=22&t=183).

### Author
[Magus at BGforge](https://forums.bgforge.net/viewtopic.php?f=22&t=183)
