## EI starter

The `starter` release is a mod for [EI starter](https://www.gipath.org/forum/thread-3828.html) 1.046.1.

### How starter runs the game

- Starter runs its own `Engine\game.exe`, the Russian 1.06 one, whatever the game's language, with the game directory as the working directory. The game's own `game.exe` is not used.
- Starter finds the game directory through the game's registry key, `Software\Nival Interactive\EvilIslands\Path Settings` under `HKEY_CURRENT_USER`, which it copies into its own key on its first start. The GOG versions write that key.
- Starter reads the game's settings from that copy. A game that has never been quit from its main menu has saved only a few of them, so starter's first start reports "Failed to get data for 'FILTERING'"; pressing OK carries on, and the game saves the rest the next time it is quit from its menu. The installer writes the game's defaults for the ones starter reads, where absent, so that message does not come up.

### The plugin

`eitweaks.dll` is loaded by starter through the mod's `[DEV] Plugin` setting when EItweaks is selected.

Starter's add-on, which loads the plugin, comes in through the `dinput.dll` beside starter's `game.exe`. Wine uses its own `dinput.dll` instead unless told otherwise, so under Wine the installer sets a `dinput` override (native, then builtin) for `game.exe` in Wine's per-program settings.

Starter's `game.exe` checks that the current drive is the game disc, which a GOG install has not. GOG's own `game.exe` skips that check with a one-byte change; the plugin applies the same change in memory. It changes nothing unless the exact expected bytes are there, so any other `game.exe` is left alone.

The game shows two kinds of help screens: the camp and map ones, which `config/tutorial.ini` switches off one by one, and the tutorials the maps' scripts start during the introductory quest, which only the game's "Show tutorial" option (Options > Windows) switches off. The plugin turns that option off once, on the first start with EItweaks, and records that with a `tutorials-off` file in the mod's folder, so a player who turns it back on keeps it on.

The standalone release runs the game's own `game.exe` and does not need the plugin.
