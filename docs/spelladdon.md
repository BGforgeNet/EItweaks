## SpellAddon

[SpellAddon](https://evilislandsaddon.forumotion.com/) (by VeryGoodGirl) patches the running game; `SPELLADDON.INI` switches each of its changes. EItweaks includes version 20.6 for one of them: [running stamina](fixes.md#eitweaks).

### What EItweaks uses

The game drains 1/150 of a character's maximum stamina per tick of running, so more stamina does not let a character run longer. EItweaks' `SPELLADDON.INI` is SpellAddon's default with the drain made absolute, in `[rebalanceengine]`:

- `rewriterunabilitytime=1`, `newrunsystem=1`: drain a fixed amount per tick;
- `runconst=0.23333333`: 35/150 per tick, the game's drain at 35 maximum stamina.

Every other SpellAddon change stays off.

### Where it goes

- The game loads SpellAddon's `SpellAddonXa.asi` from the game folder, also when run through [EI starter](starter.md); a copy in starter's `Engine` folder is not loaded.
- Starter version: the installer puts `SpellAddonXa.asi`, `SpellAddonInfo.txt` and SpellAddon's default `SPELLADDON.INI`, which changes nothing, into the game folder, keeping an `SPELLADDON.INI` already there. EItweaks' `SPELLADDON.INI` is in the mod's folder, which SpellAddon reads while EItweaks is selected, so other mods are not affected. Uninstalling EItweaks leaves SpellAddon in place, as other mods may use it.
- Standalone version: `SpellAddonXa.asi`, `SpellAddonInfo.txt` and EItweaks' `SPELLADDON.INI` go into the game folder, backed up into `eitweaks-backup` and put back on uninstall.
- An older SpellAddon would load together with this one, so the installer moves it aside, as SpellAddon's instructions ask: see [Installation](../README.md#installation).

SpellAddon's licence allows passing it on only as its whole folder: the repository keeps it unmodified in `spelladdon`, and the installer carries it whole.
