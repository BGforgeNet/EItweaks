## EIStarter-UM

[EIStarter-UM](https://github.com/Kyr4l/ei-universal-mod/blob/master/docs/EIStarter-UM.md), Universal Mod's open source launcher, runs the game with a mod chosen from its dropdown, leaving the game's own files alone. It reads EI starter's mods and uses its [add-on](addon.md), which loads EItweaks. The starter version of EItweaks needs EIStarter-UM 0.2.9 or later: earlier versions undo the options changed in the game at every start. The installer downloads 0.2.9 from GitHub into the folder chosen for it when that folder has none, or an older one, which it updates keeping its settings and mods.

The installer selects EItweaks in the launcher. On a new installation of the launcher it also skips the launcher's first-start questions (whether to download Universal Mod, whether to use the original CD camera, which EItweaks already sets) and makes the settings changes the launcher makes on its first start: a resolution the screen offers, 32-bit colour, and the frame-rate-independent cursor off.

EIStarter-UM ships an older SpellAddon. The game it runs loads SpellAddon from the launcher's `Engine` folder only, so the installer puts EItweaks' [SpellAddon](spelladdon.md) there and moves the launcher's own into `eitweaks-old-SpellAddon`.

### Playing

- Launch EIStarter-UM: the installer has already selected EItweaks. Press Play.
- To play without EItweaks, select another entry in the dropdown. EItweaks uses the game's own saves, so a game can be continued with EItweaks turned off, and back on.
- The launcher's Options set the game's graphics and sound, as the game's own options do, and the add-on's options.
- Uninstalling EItweaks leaves the launcher and SpellAddon, which other mods may use.
