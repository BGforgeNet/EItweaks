## EI starter

[EI starter](https://www.gipath.org/forum/thread-3828.html) is a launcher that runs the game with a mod chosen from its dropdown, leaving the game's own files alone. The starter version of EItweaks needs EI starter 1.046.1; the installer installs it when it is missing.

Starter loads its [add-on](addon.md), which loads EItweaks.

The installer sets the large-address-aware flag of starter's `Engine\game.exe` (the game's own files are not touched), so the 32-bit game can use 4 GB of address space on 64-bit Windows and Wine instead of 2 GB. It changes that one bit and keeps the unchanged file as `Engine\game.exe.eitweaks-nolaa`; to undo it, copy that file back over `game.exe`. Uninstalling EItweaks leaves the flag set, as it leaves SpellAddon.

### Playing

- Launch starter: the installer has already selected EItweaks. Press Play.
- To play without EItweaks, select another entry in the dropdown. EItweaks uses the game's own saves, so a game can be continued with EItweaks turned off, and back on.
- Starter's Options set the game's graphics and sound, as the game's own options do. More options are under Options > Addition.
