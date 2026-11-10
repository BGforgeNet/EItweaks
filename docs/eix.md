## eix

[eix](https://github.com/BGforgeNet/eix) (Evil Islands eXtender) runs inside the game and applies the selected mod. It reimplements EI starter's add-on and loader, with SpellAddon built in, and adds engine fixes of its own. The [starter version](starter.md) of EItweaks brings it: the installer puts eix's `addon.dll` into EItweaks' mod folder and eix's loader, `dinput.dll`, into the launcher's `Engine` folder.

eix's loader still loads the launcher's original add-on for other mods, so it stays after uninstalling EItweaks. To go back to the launcher's own loader, reinstall EIStarter-UM.

Besides loading EItweaks, it brings:

- **Widescreen**: wide resolutions show correctly. On by default.
- **Draw distance**: how far objects and landscape are drawn, `ObjectsDrawRadius` and `LandscapeDrawRadius` (100 by default).
- **Engine fixes**: spell effects no longer stack wrongly; a lock that needs no Use/Steal skill opens without it; chests no longer open for a character without the required abilities; several bugs of the game's script engine; more in eix's [fixes](https://github.com/BGforgeNet/eix/blob/main/docs/fixes.md).
- **No game disc**: the launcher's game runs without the disc.
- **Info windows**: spell damage to one decimal, cast time in seconds, and the attack rate as a percentage of the normal one (`ImproveInfoWindows`, on in EItweaks).
- **Spells on the unit panel**: the values page of a unit outside the party lists its spells, each with its icon and effect, in single player (`UnitPanelSpells`, set in `eix.ini` in `mods\eitweaks`).
- **Encumbrance**: the load a hero carries slows running, 80% of the speed at the maximum load, and running costs more in proportion; above the maximum load walking slows too. Speed never drops below half (`[Encumbrance]` in `eix.ini`, see eix's [eix.ini reference](https://github.com/BGforgeNet/eix/blob/main/docs/eix-ini.md#encumbrance)).
- **SpellAddon**: EItweaks uses some of its options: running stamina, no item action runes in wands, a fix for a crash when certain objects come into view (`ultrafixes`), gradual dawn and night vision in caves (`nightpowervisionpatch`, `nightvisionincaves`), and the Middle Mountains map choice (`removefrozenvar`). See [fixes](fixes.md).

SpellAddon has many more customization options. To use them, edit `spelladdon.ini` in `mods\eitweaks` in EIStarter-UM's folder. Every option is described in eix's [SpellAddon reference](https://github.com/BGforgeNet/eix/blob/main/docs/spelladdon.md); the add-on's options are in its [add-on reference](https://github.com/BGforgeNet/eix/blob/main/docs/addon.md).

eix writes `addon.log` in the launcher's folder. Attach it to a bug report.
