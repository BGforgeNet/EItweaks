## Building

The game data is kept as source:

- `res/database/csv`, `res/databaselmp/csv`: the single and multiplayer databases, one CSV per sheet. `res/database/extra` holds the entries that have no CSV form.
- `lang/<language>`: what one language adds, laid out as in the mod: `res/<archive>` holds an archive as loose entries (texts; multiplayer texts; Russian sounds), the rest is copied as is. `lang/de/maps` holds the maps and quests of the German patch 1.06 that 1.07 left alone, for a German game without that patch; the maps equal the other languages' 1.06 ones.
- `res/textures`, `maps`, `movies`, `config`: textures, maps, movies and configs; `config/ai.ini` is compiled to `ai.reg`.
- `config.ini`: the starter mod config.
- `plugin/eitweaks.c`: the starter plugin, built per language with a 32-bit Windows C compiler; the standalone release does not need it.
- `SPELLADDON.INI`: EItweaks' SpellAddon settings (SpellAddon's default with the running drain set to absolute); `spelladdon`: [SpellAddon](https://evilislandsaddon.forumotion.com/) 20.6 as published, shipped beside the mod.

The build compiles them with a patched [um-multitool](https://github.com/Kyr4l/ei-universal-mod) inside a container. Install `podman` and put it on `PATH`, then, from the repository root:

    podman build -t eitweaks-build -f build/Containerfile build
    mkdir -p dist
    podman run --rm --network none -v "$PWD:/repo:ro" -v "$PWD/dist:/out" eitweaks-build eibuild build /repo <version> /out

This writes `eitweaks-<version>-<language>-starter.zip` and `eitweaks-<version>-<language>-standalone.zip` for each language; the standalone one leaves out the archives that hold only a few of the game's entries (textures, the Russian sounds), as copied over the game they would replace the whole archive, and names its folders as that language's GOG version does. Two builds of the same tree give identical zips. `scripts/release.sh <version>` builds and publishes a release.

To edit a database in a spreadsheet, convert it to a workbook and back, in the same container with the repository mounted read-write:

    podman run --rm -v "$PWD:/repo" -w /repo eitweaks-build eibuild xlsx res/database/csv database.xlsx
    podman run --rm -v "$PWD:/repo" -w /repo eitweaks-build eibuild csv database.xlsx res/database/csv
