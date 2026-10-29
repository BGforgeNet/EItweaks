## EItweaks

EItweaks is a mod for Evil Islands: Curse of the Lost Soul.

- [Overview](#overview)
- [Installation](#installation)
- [Building](#building)
- [Support](#support)
- [Author](#author)
- [Changelog](CHANGELOG.md)
- [Todo](TODO.md)

### Overview

- [Patch 1.07](#patch-107)
- [Gameplay](#gameplay)
- [Speedup](#speedup)
- [Items](#items)
- [Regeneration](#regeneration)
- [Resistances](#resistances)
- [Bug fixes](#bug-fixes)
- [Running](#running)

#### Patch 1.07
- Includes the fixes of the unofficial patch 1.07 (Gipat Group) for every game language: map scripts (trolls returning to the witch's cave, Go-Go's dialogues, the goblin sentry phrase, levers and bridges that could trap the player, repeated quest rewards), the databases and the Russian texts.
- English and German texts get 1.07's world map fix (the "Punishing goblins" quest marker).
- Spears, maces, hammers and clubs get no attack skill bonus in multiplayer (1.07 had added one).

#### Gameplay
- When a player character is running, stamina is depleted by points rather than percentage, which allows to run longer as stamina grows.
- Human (PC and NPC) run speed slightly increased.
- Human (PC and NPC) walk speed considerably increased.
- Zak no longer has a level of backstab perk.
- Reduced over-the-top armor values for golems and other "unkillable" monsters from 150 to 44.

#### Speedup
- 1C/Nival intro movies are disabled.
- New game starting movie is disabled.
- Help screens are disabled by default.
- New game "My head hurts" cutscene is shortened.

#### Items
- Dragons drop hide in addition to bones.
- Stronger Green Dragon Horn.

#### Regeneration
- Disabled for undead and golems.
- Halved for dragons and ogres.
- Green/blue trolls are untouched, but black ones toned down to match green/blue.
- Reduced dramatically for all other monsters and characters.

#### Resistances
- Hard leather provide extra protection against piercing and bludgeoning, matching monster protection.
- Hide provides extra protection against piercing.
- Fur provides extra protection against bludgeoning.
- Lava elementals get extra protection from fire, Snow elementals get vulnerability to it.
- Lightning vulnerability for NPCs using metal armor and golems.

#### Bug fixes
- Gipath bats description correctly states fire damage.
- Stony harpies have extra protection from lightning instead of fire.
- Grey harpies have extra protection from acid instead of fire.
- Dragons and items from dragon hide have extra protection from the corresponding elements.
- Dragons description correctly states their damage type.

#### Running
To fix fatique depletion when running (it's supposed to be spent in absolute units, rather than percents), install [SpellAddon](https://www.gipat.ru/forum/thread-3802.html). Simply extract it into main game directory.

### Installation

1. Download and install [EI starter](https://www.gipat.ru/forum/thread-3828.html).
1. Download updated [addon.dll](https://www.gipat.ru/forum/thread-3827.html) and drop it into starter's directory, replacing old `addon.dll`.
1. Make sure the game is at version 1.06. The GOG English and Russian versions are; for the GOG German version, install the official German [patch 1.06](https://allods.gipat.ru/index.php?p=filesei) first.
1. Download the latest EItweaks [release](https://github.com/BGforgeNet/EItweaks/releases/latest) for your game's language (`ru`, `en` or `de`), unzip it.
1. Put `eitweaks` in into `Mods` subdir of starter's installation directory.
1. Launch starter, select EItweaks in dropdown.

### Building
The game data is kept as source: databases as CSV sheets (`res/database*/csv`), texts as loose entries (`res/texts/<language>`), `config/ai.ini`, and the files with no text form as they are. The build compiles them with a patched [um-multitool](https://github.com/Kyr4l/ei-universal-mod) inside a container; install `podman` and put it on `PATH`.

    podman build -t eitweaks-build -f build/Containerfile build
    podman run --rm --network none -v "$PWD:/repo:ro" -v "$PWD/dist:/out" eitweaks-build eibuild build /repo <version> /out

This writes `eitweaks-<version>-<language>.zip` for each language; `scripts/release.sh <version>` builds and publishes a release. To edit a database in a spreadsheet, convert it to a workbook and back, in the same container with the repository mounted read-write:

    podman run --rm -v "$PWD:/repo" -w /repo eitweaks-build eibuild xlsx res/database/csv database.xlsx
    podman run --rm -v "$PWD:/repo" -w /repo eitweaks-build eibuild csv database.xlsx res/database/csv

### Support
* Report bugs and suggest features on [Github](https://github.com/BGforgeNet/EItweaks/issues).
* Discuss and ask questions on the [forum](https://forums.bgforge.net/viewtopic.php?f=22&t=183).

### Author
[Magus at BGforge](https://forums.bgforge.net/viewtopic.php?f=22&t=183)
