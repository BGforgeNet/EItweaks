## EI starter

The `starter` release is a mod for [EI starter](https://www.gipath.org/forum/thread-3828.html) 1.046.1.

### How starter runs the game

- Starter runs its own `Engine\game.exe`, the Russian 1.06 one, whatever the game's language, with the game directory as the working directory. The game's own `game.exe` is not used.
- Starter finds the game directory through the game's registry key, `Software\Nival Interactive\EvilIslands\Path Settings` under `HKEY_CURRENT_USER`, which it copies into its own key on its first start. The GOG versions write that key.
- Starter reads the game's settings from that copy. A game that has never been quit from its main menu has saved only a few of them, so starter's first start reports "Failed to get data for 'FILTERING'"; pressing OK carries on, and the game saves the rest the next time it is quit from its menu.

### The plugin

Starter's `game.exe` checks that the current drive is the game disc, which a GOG install has not. GOG's own `game.exe` skips that check with a one-byte change; `eitweaks.dll`, loaded by starter through the mod's `[DEV] Plugin` setting, applies the same change in memory when EItweaks is selected. It changes nothing unless the exact expected bytes are there, so any other `game.exe` is left alone.

The standalone release runs the game's own `game.exe` and does not need the plugin.
