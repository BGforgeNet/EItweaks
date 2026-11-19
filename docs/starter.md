## EIStarter-UM

[EIStarter-UM](https://github.com/Kyr4l/ei-universal-mod/blob/master/docs/EIStarter-UM.md), Universal Mod's open source launcher, runs the game with a mod chosen from its dropdown and leaves the game's own files alone. The installer includes it, so no internet connection is needed: it installs the launcher, or updates an older one and keeps its settings and mods, and selects EItweaks in it.

### Playing

- Launch EIStarter-UM and press Play.
- To play without EItweaks, select another entry in the dropdown. EItweaks uses the game's own saves, so a game can be continued with EItweaks turned off, and back on.
- The launcher's Options set the game's graphics and sound, and the add-on's options. More settings are in `eix.ini`, `eitweaks.ini` and `um.cfg` in `mods\eitweaks`.
- Graphics run through D7VK (Direct3D 7 on Vulkan). On a graphics card without Vulkan support, the game uses its own DirectDraw.
- On the GOG English or German version, the launcher runs that game's own `game.exe`, so the briefings have their voices.
- On a crash, the crash log is `um.log` in `mods\eitweaks`. F9 shows a diagnostic overlay, F10 its log panel.
- Uninstalling EItweaks leaves the launcher, which other mods may use.
