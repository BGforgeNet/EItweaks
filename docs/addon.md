## EI starter's add-on

The add-on, `addon.dll`, is the part of [EI starter](starter.md) that runs inside the game and applies the selected mod. EItweaks comes with add-on 0.12.4.2, newer than the 0.11 that starter 1.046.1 ships; it is used only when EItweaks is selected.

Besides loading EItweaks, it brings:

- **Widescreen**: wide resolutions show correctly. On by default.
- **Draw distance**: how far objects and landscape are drawn, `ObjectsDrawRadius` and `LandscapeDrawRadius` (100 by default).
- **Engine fixes**: spell effects no longer stack wrongly; a lock that needs no Use/Steal skill opens without it; chests no longer open for a character without the required abilities; several bugs of the game's script engine.
- **Console**: Ctrl+A, Ctrl+C, Ctrl+V and Ctrl+X work; `nogui 1` hides the interface (for screenshots), `nogui 2` the cursor too, `nogui 0` brings them back.

The settings are in starter's options where it shows them, else under `HKEY_CURRENT_USER\Software\Gipat.Ru\EI_Starter\Settings` (for example `WideScreen`, 1 on, 0 off). EItweaks keeps the add-on's defaults.
