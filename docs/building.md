## Building

The game data is kept as source. `mod` is laid out as the mod's folder; `vendor` holds third-party files, unmodified.

- `mod/res/database/csv`, `mod/res/databaselmp/csv`: the single and multiplayer databases, one CSV per sheet. `mod/res/database/extra` holds the entries that have no CSV form.
- `lang/<language>`: what one language adds, laid out as `mod`: `res/<archive>` holds an archive as loose entries (texts; multiplayer texts), the rest is copied as is. The build writes the version it is given in place of `{EITWEAKS_VERSION}` in the `string version_name` text, the version line of the main menu. `lang/de/maps` holds the maps and quests of the German patch 1.06 that 1.07 left alone, for a German game without that patch; the maps equal the other languages' 1.06 ones, and the file names are spelled as in the GOG German version.
- `mod/res/textures`, `mod/maps`, `mod/config`: textures, maps and configs; `mod/config/ai.ini` is compiled to `ai.reg`.
- `mod/config.ini`: the starter mod config, compiled to `config.reg`.
- `vendor/universal-mod`: Universal Mod's runtime, its license and corresponding source archive. The starter build places these in the mod folder alongside `vendor/d7vk`'s DLL and license; `mod/config.ini` loads the runtime as a plugin. `mod/um.cfg` selects D7VK automatically under Wine, disables the check for the older SpellAddon file and disables the separate, unbundled engine runtime. Standalone builds leave these files out.
- `vendor/eix/eix-<version>.zip`: the [eix](eix.md) release package, unmodified. The starter build places its `addon.dll`, license and third-party notices in the mod folder, and its `dinput.dll` in the zip's `Engine` folder, which the installer puts into the launcher's.
- `vendor/eistarter-um/EIStarter-UM-0.2.9.zip`: the pinned launcher package, embedded in the installer for offline installation and upgrades.
- `mod/spelladdon.ini`: EItweaks' settings for eix's built-in SpellAddon (SpellAddon's default with the running drain set to absolute). Standalone builds leave it out.

The build compiles them with a patched [um-multitool](https://github.com/Kyr4l/ei-universal-mod) inside a container, and the installer with [Inno Setup](https://jrsoftware.org/isinfo.php) (`build/installer.iss`) in another. Install `podman` and put it on `PATH`, then, from the repository root:

    scripts/build.sh <version> dist

This writes the installer, `eitweaks-<version>.exe`, and `SHA256SUMS`. On the way it builds, in a temporary folder, a starter and a standalone zip for each language; the installer is made from the starter zips (`eibuild payload` stores the files every language shares once). The standalone zip leaves out the archive that holds only a few of the game's entries (textures), as copied over the game it would replace the whole archive, and names its folders as that language's GOG version does; the installer's standalone version installs the same files into the game's folders as it finds them. Two builds of the same tree give identical zips. `scripts/release.sh <version>` builds a release and publishes the installer.

CI runs the same build on every push to `dev` or `master` and on pull requests, and keeps the files as the run's artifact.

To edit a database in a spreadsheet, convert it to a workbook and back, in the same container with the repository mounted read-write:

    podman run --rm -v "$PWD:/repo" -w /repo eitweaks-build eibuild xlsx mod/res/database/csv database.xlsx
    podman run --rm -v "$PWD:/repo" -w /repo eitweaks-build eibuild csv database.xlsx mod/res/database/csv

### Further reading

These open projects describe the same machinery or the game itself:

- [eix](https://github.com/BGforgeNet/eix): the loader and add-on the starter version uses, documented feature by feature against EI starter's.
- [EIStarter-UM](https://github.com/Kyr4l/ei-universal-mod/blob/master/docs/EIStarter-UM.md), part of Universal Mod: the open source launcher the starter version uses, which reads EI starter's mod format. Its documentation describes the loading chain: the `dinput.dll` loader, the add-on, the mod's `config.reg`, plugins and the registry keys.
- [ei-rebuild](https://github.com/DoctorGester/ei-rebuild): readable C++ source for the Russian 1.06 `game.exe`, with notes on each part of the engine.
- [Cursed Lands](https://github.com/TheWWWorm/CursedLands): a separate engine that plays the original game's files; its documentation covers its compatibility with older mods and its tests against the original `game.exe`.
- [EIrepack](https://github.com/aspadm/EIrepack): a tool for decompiling the game.
- [ei-projects](https://github.com/ei-projects): libraries and tools for the game's file formats.
