# Universal Mod runtime

`um.dll` 1.6.0 from [Universal Mod](https://github.com/Kyr4l/ei-universal-mod/tree/810a9019a57d1b3081e39d50444f3339ba0fa56f).
The included source archive contains its source, upstream build script and GPL-3.0 license from the same revision.

To rebuild, extract the archive, install a 32-bit MinGW C++ compiler and put it on `PATH`, then run:

    i686-w64-mingw32-g++ -shared -o um.dll resources/universal-mod/um-dll/*.cpp -I resources/universal-mod/um-dll -std=c++17 -O3 -flto -static -s -Wall -Wextra -Wno-unused-parameter -lgdi32 -lws2_32

EItweaks' starter version loads this runtime as a plugin, set in the mod's `config.ini`. `um.cfg` disables the check
for the older SpellAddon filename and the separate, unbundled `um-engine.dll`. `DDRAW_DLL=auto` selects the bundled
D7VK under Wine.
