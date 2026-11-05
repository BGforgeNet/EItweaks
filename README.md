# EItweaks

[**Download**](https://github.com/BGforgeNet/EItweaks/releases/latest)
| [**Report issues**](https://github.com/BGforgeNet/EItweaks/issues)
| [**Discuss**](https://forums.bgforge.net/viewtopic.php?f=22&t=183)

EItweaks is a mod for Evil Islands: Curse of the Lost Soul. It includes multiple fixes and various tweaks, QoL and a few balance changes. It runs through [EIStarter-UM](docs/starter.md), which the installer downloads, and bundles EI starter's [add-on](docs/addon.md) and [SpellAddon](docs/spelladdon.md).

- [Fixes](docs/fixes.md)
- [Tweaks](#tweaks)
- [Installation](#installation)

## Tweaks

The tweaks are mostly to make things more consistent within the game, add some flavour, improve QoL. Also close obvious exploits, but give PC a chance against previously impossible enemies, with [Hardcore](https://pihwiki.bgforge.net/Evil_Islands:_Curse_of_the_Lost_Soul) play style in mind.

- [Gameplay](#gameplay)
- [Speedup](#speedup)
- [Items](#items)
- [Regeneration](#regeneration)
- [Resistances](#resistances)


### Gameplay

- Human (PC and NPC) run speed slightly increased to match other characters.
- Human (PC and NPC) walk speed considerably increased (it was the same as sneaking originally).
- PC no longer has a level of backstab perk pre-selected. That allows for greater flexibility in character development.
- Airy grants +2 to Sensory Magic and Trickster +2 to Use/Steal, instead of +10. This is to prevent the XP exploit with these bonuses.
- Reduced over-the-top armor values for golems and other "unkillable" monsters. They are now killable (albeit extremely hard). Because unkillable enemies are not very fun.
- Dragons on Gipath no longer have over 1000 hit points. Same reason.
- Running depletes stamina by points rather than percentage, like game text suggests, so a character can run longer as stamina grows.
- Batteries are disabled.

### Speedup

- 1C/Nival intro movies are disabled.
- Help screens are disabled by default.

### Items

- Dragons drop hide in addition to bones. Because why wouldn't they?
- Stronger Green Dragon Horn. The original one was useless.
- Hide armor blueprints are sold in the Gipath shop, since it drops there.
- Half effect rune is sold on Gipath. A restoration from original game files, makes starting a mage a bit easier.
- Blue harpies drop their heads, like the other harpies. Another restoration: the heads were in the game files, unused.

### Regeneration

Regeneration is quite annoying in game. Often an enemy would regenerate faster than PC would damage it. In certain cases that seems justified (trolls, etc), but in others it isn't. So, regeneration is:

- Disabled for undead, golems, shadows and will-o-wisps.
- Halved for ogres.
- Green/blue trolls are unchanged, but black ones toned down to match green/blue.
- Ice elementals regenerate like other elementals.
- Reduced dramatically for all other monsters and characters (including PC).

### Resistances

A collection of changes to standardize protections and make them "make sense".

- Hard leather provides extra protection against piercing and bludgeoning, matching monster protection.
- Hide provides extra protection against piercing.
- Fur provides extra protection against bludgeoning.
- Ogres and lizardmen have the same protection against piercing and bludgeoning (Hadagan ogres keep their piercing protection).
- Skeletons have extra protection against piercing; trolls have no extra protection against acid.
- Monsters match the armor made from their hide: trolls have half their protection against piercing, dragons extra protection against piercing, tigers against bludgeoning.
- Cyclopes have no extra magic protection.
- Lava elementals get extra protection from fire instead of acid, Snow elementals get vulnerability to it.
- Lightning vulnerability for NPCs using metal armor and golems.

## Installation

The game must be at version 1.06. The GOG releases are ready as they are. If you have an older version, grab [1.06](https://allods.gipat.ru/index.php?p=filesei#patch-1-06) first.

Download the installer, `eitweaks-<version>.exe`, from the latest [release](https://github.com/BGforgeNet/EItweaks/releases/latest) and run it.

### More

- [Build from source](docs/building.md)
- [Changelog](CHANGELOG.md)
- [Standalone](docs/standalone.md) version differences.
- [German](docs/de.md) version notes.
