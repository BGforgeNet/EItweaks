## EI starter

The `starter` release is a mod for [EI starter](https://www.gipath.org/forum/thread-3828.html) 1.046.1.

### How starter runs the game

- Starter runs its own `Engine\game.exe`, the Russian 1.06 one, whatever the game's language, with the game directory as the working directory. The game's own `game.exe` is not used.
- Starter finds the game directory through the game's registry key, `Software\Nival Interactive\EvilIslands\Path Settings` under `HKEY_CURRENT_USER`, which it copies into its own key on its first start. The GOG versions write that key.
- Starter reads the game's settings from that copy. A game that has never been quit from its main menu has saved only a few of them, so starter's first start reports "Failed to get data for 'FILTERING'"; pressing OK carries on, and the game saves the rest the next time it is quit from its menu. The installer writes the ones starter reads, where absent, so that message does not come up: the game's defaults, with texture and landscape detail at their highest.

### The add-on

Starter's add-on, `addon.dll`, patches the running game and loads mods. EItweaks carries add-on 0.12.4.2 in its folder, which starter 1.046.1 loads in place of its own 0.11.0.0 when EItweaks is selected; other mods keep starter's.

### The plugin

`eitweaks.dll` is loaded by starter through the mod's `[DEV] Plugin` setting when EItweaks is selected.

Starter's add-on, which loads the plugin, comes in through the `dinput.dll` beside starter's `game.exe`. Wine uses its own `dinput.dll` instead unless told otherwise, so under Wine the installer sets a `dinput` override (native, then builtin) for `game.exe` in Wine's per-program settings.

Starter's `game.exe` checks that the current drive is the game disc, which a GOG install has not. GOG's own `game.exe` skips that check with a one-byte change; the plugin applies the same change in memory. It changes nothing unless the exact expected bytes are there, so any other `game.exe` is left alone.

The game shows two kinds of help screens: the camp and map ones, which `config/tutorial.ini` switches off one by one, and the tutorials the maps' scripts start during the introductory quest, which only the game's "Show tutorial" option (Options > Windows) switches off. The plugin turns that option off once, on the first start with EItweaks, and records that with a `tutorials-off` file in the mod's folder, so a player who turns it back on keeps it on.

The standalone release runs the game's own `game.exe` and does not need the plugin.

### Further reading

EI starter and its add-on (`addon.dll`) are closed source. These open projects describe the same machinery or the game itself:

- [EIStarter-UM](https://github.com/Kyr4l/ei-universal-mod/blob/master/docs/EIStarter-UM.md), part of Universal Mod: an open source launcher that reads EI starter's mod format and uses its loader and add-on. Its documentation describes the loading chain: the `dinput.dll` loader, the add-on, the mod's `config.reg`, plugins and the registry keys.
- [ei-rebuild](https://github.com/DoctorGester/ei-rebuild): readable C++ source for the Russian 1.06 `game.exe`, with notes on each part of the engine.
- [Cursed Lands](https://github.com/TheWWWorm/CursedLands): a separate engine that plays the original game's files; its documentation covers its compatibility with older mods and its tests against the original `game.exe`.
- [EIrepack](https://github.com/aspadm/EIrepack): a tool for decompiling the game.
- [ei-projects](https://github.com/ei-projects): libraries and tools for the game's file formats.
