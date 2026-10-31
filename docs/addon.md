## EI starter's add-on

The add-on, `addon.dll`, is the part of [EI starter](starter.md) that applies a mod to the running game. It is closed source, by the starter's developers.

### How it loads

- Starter's `Engine\dinput.dll` stands in for the game's DirectInput and loads the add-on when the game starts.
- Wine uses its own `dinput.dll` instead unless told otherwise, and the game then runs without the add-on: no mod, and a GOG install asks for the disc. Under Wine the installer sets a `dinput` override (native, then builtin) for `game.exe` in Wine's per-program settings.
- EItweaks carries add-on 0.12.4.2 in its folder, as its developer published it on the [Gipat forum](https://www.gipath.org/forum/attachment.php?aid=3007). Starter 1.046.1 loads it in place of its own 0.11.0.0 when EItweaks is selected; other mods keep starter's.

### What EItweaks uses

The add-on reads the selected mod's `config.reg` (see [the mod's folder](starter.md#the-mods-folder)), and for EItweaks:

- loads its archives and configs in place of the game's;
- loads its [plugin](starter.md#the-plugin), `eitweaks.dll`;
- points the game at starter's copy of the game's registry settings, so the installer writes the settings it changes into that copy too, once starter has made it.

The add-on's own game patches and options (draw distance, multiplayer ones) are starter's to set; EItweaks leaves them as they are.
