## SpellAddon

[SpellAddon](https://evilislandsaddon.forumotion.com/) (by VeryGoodGirl) is a set of changes to the game, each switched on or off in its `SPELLADDON.INI`. EItweaks includes version 20.6 and uses one of them: running stamina.

### Running stamina

The game drains 1/150 of a character's maximum stamina per tick of running, so more stamina does not let a character run longer. EItweaks drains a fixed amount instead, the game's drain at 35 maximum stamina: a character with more stamina runs longer than before, one with less runs shorter.

The amount is `runconst` in EItweaks' `SPELLADDON.INI`, in the mod's folder (starter version) or the game folder (standalone version): 35/150 per tick, `0.23333333`. Every other SpellAddon change stays off.

### Other mods

With EI starter, EItweaks' settings apply only while EItweaks is selected; other mods and the game without mods are not changed. SpellAddon stays in the game folder when EItweaks is uninstalled, as other mods may use it. An older SpellAddon is moved aside by the installer: see [Installation](../README.md#installation).
