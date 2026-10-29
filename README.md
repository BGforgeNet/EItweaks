## EItweaks

EItweaks is a mod for Evil Islands: Curse of the Lost Soul. It includes the fixes of the unofficial patch 1.07 and works with the Russian, English and German versions of the game.

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
- The fixes of the unofficial patch 1.07 (Gipat Group), for every language: campaign map scripts (trolls coming back to the witch's cave, Go-Go's dialogues, the goblin sentry phrase repeating, levers and mechanisms that could trap the player, quest rewards and experience given on every visit to a zone), the single and multiplayer databases and, in Russian, the texts.
- English and German: 1.07's corrected marker position for the "Punishing goblins" quest on the world map.
- Multiplayer: spears, maces, hammers and clubs give no attack skill bonus (1.07 added one).

The changes below apply to the single player game; the multiplayer database is 1.07's with the change above.

#### Gameplay
- When a player character is running, stamina is depleted by points rather than percentage, so a character can run longer as stamina grows (see [Running](#running)).
- Human (PC and NPC) run speed slightly increased.
- Human (PC and NPC) walk speed considerably increased.
- Zak no longer has a level of backstab perk.
- Airy grants +2 to Sensory Magic and Trickster +2 to Use/Steal, instead of +10.
- Reduced over-the-top armor values for golems and other "unkillable" monsters from 150 to 44.
- Dragons on Gipath no longer have more than 1000 hit points.

#### Speedup
- 1C/Nival intro movies are disabled.
- New game starting movie is disabled.
- Help screens are disabled by default.
- New game "My head hurts" cutscene is shortened.

#### Items
- Dragons drop hide in addition to bones.
- Stronger Green Dragon Horn.
- Hide armor is sold in the Gipath shop.
- Half effect rune is sold on Gipath.

#### Regeneration
- Disabled for undead, golems, shadows and will-o-wisps.
- Halved for ogres.
- Green/blue trolls are untouched, but black ones toned down to match green/blue.
- Ice elementals regenerate like other elementals.
- Reduced dramatically for all other monsters and characters.

#### Resistances
- Hard leather provides extra protection against piercing and bludgeoning, matching monster protection.
- Hide provides extra protection against piercing.
- Fur provides extra protection against bludgeoning.
- Ogres and lizardmen have the same protection against piercing and bludgeoning (Hadagan ogres keep their piercing protection).
- Skeletons have extra protection against piercing; trolls have no extra protection against acid.
- Cyclopes have no extra magic protection.
- Lava elementals get extra protection from fire, Snow elementals get vulnerability to it.
- Lightning vulnerability for NPCs using metal armor and golems.

#### Bug fixes
- Gipath bats description correctly states fire damage.
- Stony harpies have extra protection from lightning instead of fire.
- Grey harpies have extra protection from acid instead of fire.
- Dragons and items from dragon hide have extra protection from the corresponding elements.
- Dragons description correctly states their damage type.
- Magic-using banshees, dragons, bats and evil eyes show correct damage values in the info window.
- Toads and will-o-wisps show their real magic damage.
- Red harpies show their real damage type and range.
- Goblins with slings do bludgeoning damage.

#### Running
To fix fatigue depletion when running (it's supposed to be spent in absolute units, rather than percents), install [SpellAddon](https://www.gipat.ru/forum/thread-3802.html). Simply extract it into main game directory.

### Installation

1. Download and install [EI starter](https://www.gipat.ru/forum/thread-3828.html).
1. Download updated [addon.dll](https://www.gipat.ru/forum/thread-3827.html) and drop it into starter's directory, replacing old `addon.dll`.
1. Make sure the game is at version 1.06. The GOG English and Russian versions are; for the GOG German version, install the official German [patch 1.06](https://allods.gipat.ru/index.php?p=filesei) first. Patch 1.07 is not needed: EItweaks includes its fixes.
1. Download the latest EItweaks [release](https://github.com/BGforgeNet/EItweaks/releases/latest) for your game's language (`ru`, `en` or `de`), unzip it.
1. Put `eitweaks` into the `Mods` subdirectory of starter's installation directory.
1. Launch starter, select EItweaks in the dropdown.

### Building

The game data is kept as source:

- `res/database/csv`, `res/databaselmp/csv`: the single and multiplayer databases, one CSV per sheet. `res/database/extra` holds the entries that have no CSV form.
- `res/texts/<language>`: the text archives as loose entries.
- `res/sfx`, `res/textures`, `maps`, `movies`, `config`: sounds, textures, maps, movies and configs; `config/ai.ini` is compiled to `ai.reg`.
- `config.ini`: the starter mod config.

The build compiles them with a patched [um-multitool](https://github.com/Kyr4l/ei-universal-mod) inside a container. Install `podman` and put it on `PATH`, then:

    podman build -t eitweaks-build -f build/Containerfile build
    mkdir -p dist
    podman run --rm --network none -v "$PWD:/repo:ro" -v "$PWD/dist:/out" eitweaks-build eibuild build /repo <version> /out

This writes `eitweaks-<version>-<language>.zip` for each language; two builds of the same tree give identical zips. `scripts/release.sh <version>` builds and publishes a release.

To edit a database in a spreadsheet, convert it to a workbook and back, in the same container with the repository mounted read-write:

    podman run --rm -v "$PWD:/repo" -w /repo eitweaks-build eibuild xlsx res/database/csv database.xlsx
    podman run --rm -v "$PWD:/repo" -w /repo eitweaks-build eibuild csv database.xlsx res/database/csv

### Support
* Report bugs and suggest features on [Github](https://github.com/BGforgeNet/EItweaks/issues).
* Discuss and ask questions on the [forum](https://forums.bgforge.net/viewtopic.php?f=22&t=183).

### Author
[Magus at BGforge](https://forums.bgforge.net/viewtopic.php?f=22&t=183)
