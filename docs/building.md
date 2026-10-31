## Building

The game data is kept as source:

- `res/database/csv`, `res/databaselmp/csv`: the single and multiplayer databases, one CSV per sheet. `res/database/extra` holds the entries that have no CSV form.
- `lang/<language>`: what one language adds, laid out as in the mod: `res/<archive>` holds an archive as loose entries (texts; multiplayer texts; Russian sounds), the rest is copied as is. `lang/de/maps` holds the maps and quests of the German patch 1.06 that 1.07 left alone, for a German game without that patch; the maps equal the other languages' 1.06 ones, and the file names are spelled as in the GOG German version.
- `res/textures`, `maps`, `movies`, `config`: textures, maps, movies and configs; `config/ai.ini` is compiled to `ai.reg`.
- `config.ini`: the starter mod config.
- `plugin/eitweaks.c`: the [starter version's](starter.md) plugin, which skips the disc check and turns the tutorials off once, built with a 32-bit Windows C compiler.
- `addon/addon.dll`: starter's [add-on](addon.md) 0.12.4.2, as its developer published it on the [Gipat forum](https://www.gipath.org/forum/attachment.php?aid=3007).
- `SPELLADDON.INI`: EItweaks' SpellAddon settings (SpellAddon's default with the running drain set to absolute); `spelladdon`: [SpellAddon](spelladdon.md) 20.6 as published, carried whole in the installer, which installs the files SpellAddon's instructions name into the game folder.

The build compiles them with a patched [um-multitool](https://github.com/Kyr4l/ei-universal-mod) inside a container, and the installer with [Inno Setup](https://jrsoftware.org/isinfo.php) (`build/installer.iss`) in another. Install `podman` and put it on `PATH`, then, from the repository root:

    scripts/build.sh <version> dist

This writes the installer, `eitweaks-<version>-setup.exe`, and `SHA256SUMS`. On the way it builds, in a temporary folder, a starter and a standalone zip for each language; the installer is made from the starter zips (`eibuild payload` stores the files every language shares once). The standalone zip leaves out the archives that hold only a few of the game's entries (textures, the Russian sounds), as copied over the game they would replace the whole archive, and names its folders as that language's GOG version does; the installer's standalone version installs the same files into the game's folders as it finds them. Two builds of the same tree give identical zips. `scripts/release.sh <version>` builds a release and publishes the installer.

CI runs the same build on every push to `dev` or `master` and on pull requests, and keeps the files as the run's artifact.

To edit a database in a spreadsheet, convert it to a workbook and back, in the same container with the repository mounted read-write:

    podman run --rm -v "$PWD:/repo" -w /repo eitweaks-build eibuild xlsx res/database/csv database.xlsx
    podman run --rm -v "$PWD:/repo" -w /repo eitweaks-build eibuild csv database.xlsx res/database/csv

### Further reading

EI starter and its add-on are closed source. These open projects describe the same machinery or the game itself:

- [EIStarter-UM](https://github.com/Kyr4l/ei-universal-mod/blob/master/docs/EIStarter-UM.md), part of Universal Mod: an open source launcher that reads EI starter's mod format and uses its loader and add-on. Its documentation describes the loading chain: the `dinput.dll` loader, the add-on, the mod's `config.reg`, plugins and the registry keys.
- [ei-rebuild](https://github.com/DoctorGester/ei-rebuild): readable C++ source for the Russian 1.06 `game.exe`, with notes on each part of the engine.
- [Cursed Lands](https://github.com/TheWWWorm/CursedLands): a separate engine that plays the original game's files; its documentation covers its compatibility with older mods and its tests against the original `game.exe`.
- [EIrepack](https://github.com/aspadm/EIrepack): a tool for decompiling the game.
- [ei-projects](https://github.com/ei-projects): libraries and tools for the game's file formats.
