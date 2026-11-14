## EIStarter-UM

[EIStarter-UM](https://github.com/Kyr4l/ei-universal-mod/blob/master/docs/EIStarter-UM.md), Universal Mod's open source launcher, runs the game with a mod chosen from its dropdown, leaving the game's own files alone. It reads EI starter's mods; EItweaks runs with [eix](eix.md), which loads it. The starter version of EItweaks needs EIStarter-UM 0.2.9 or later: earlier versions undo the options changed in the game at every start. The installer includes 0.2.9 and installs it into the folder chosen for it when that folder has none, or an older one, which it updates keeping its settings and mods. Installation works offline.

The installer selects EItweaks in the launcher. On a new installation of the launcher it also skips the launcher's first-start questions (whether to download Universal Mod, whether to use the original CD camera, which EItweaks already sets) and makes the settings changes the launcher makes on its first start: a resolution the screen offers, 32-bit colour, and the frame-rate-independent cursor off.

The launcher's own `Engine\game.exe` is the Russian game's. On the GOG English or German version, whose briefing voices it cannot find, the installer copies that game's own `game.exe` into the launcher's `Engine` folder as `game-en.exe`, with the large address aware bit set as in the launcher's, and the launcher runs it for every mod. Any other game keeps the launcher's own exe; uninstalling EItweaks puts it back.

The installer replaces the launcher's loader, `Engine\dinput.dll`, with eix's, which also loads the launcher's own add-on for its other mods. eix has SpellAddon built in, and keeps the older SpellAddon the launcher ships from loading.

### Playing

The installer puts D7VK, which translates Direct3D 7 to Vulkan, into the launcher's `Engine` folder as `ddraw.dll`, so
every mod the launcher runs uses it. Under Wine it also sets the game's DLL override for `ddraw` to native, which Wine
needs to load it. The installer turns off the frame-rate-independent cursor, including in existing launcher settings,
to prevent flicker with D7VK. Uninstalling EItweaks removes D7VK.

- Launch EIStarter-UM: the installer has already selected EItweaks. Press Play.
- To play without EItweaks, select another entry in the dropdown. EItweaks uses the game's own saves, so a game can be continued with EItweaks turned off, and back on.
- The launcher's Options set the game's graphics and sound, as the game's own options do, and the add-on's options.
- Uninstalling EItweaks leaves the launcher and eix's loader, which other mods may use.
