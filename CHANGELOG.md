- [2.0](#20)
- [1.0](#10)

### 2.0

#### Added
- The starter version runs the game's DirectDraw through D7VK, which translates it to Vulkan. The installer disables
  the frame-rate-independent cursor to prevent flicker with D7VK.
- Separate releases for the Russian, English and German versions of the game.
- A standalone version, copied over the game's files, for playing without a launcher.
- An installer for every game language and both versions: it detects the game's language, installs the bundled
  EIStarter-UM 0.2.9 when its folder has none or an older one, and selects EItweaks in it. Installation works offline.
  On a new launcher it skips the first-start questions and makes its first-start settings changes. The standalone
  version backs up the game files it replaces, and uninstalling puts them back.
- The starter version runs on the GOG versions without the game disc.
- The starter version runs with eix 0.1.0, which reimplements EI starter's add-on and loader with SpellAddon built in,
  and adds engine fixes of its own.
- Starter version on the GOG English or German version: the launcher runs that game's own `game.exe`, so the
  briefing voices play.
- Starter version: info windows show spell damage to one decimal, cast time in seconds, and the attack rate as a
  percentage of the normal one.
- Starter version: the unit panel lists the spells of a unit outside the party, with their effects.
- Starter version: the load a hero carries slows running and makes it more tiring; above the maximum load it slows
  walking too.
- Starter version: mercenaries travel with the hero between allods and join the finale party; `Travel` in
  `eitweaks.ini` turns it off.
- Starter version: single player pauses when a party member falls below 25% health; installer options also pause
  on enemies coming into view, attacking or dying, and keep the mouse inside the game window.
- Starter version: music tracks play from FLAC files put into the `Stream` folder.
- German: the data of the official German patch 1.06 (maps, quests, multiplayer texts), so the GOG German version,
  which the patch refuses to install on, needs no patch.
- The fixes of the unofficial patch 1.07 (Gipat Group) that 1.0 lacked, for every language: campaign map scripts
  (trolls coming back to the witch's cave, GoGo's sacred object quest in the village, the goblin sentry phrase
  repeating, levers and mechanisms that could trap the player, quest rewards and experience given on every visit to a
  zone), the multiplayer database, `ai.reg` and, in Russian, the texts.
- English and German: 1.07's corrected marker position for the "Punishing goblins" quest on the world map.
- Hide armor blueprints (shirt, pants, boots, gloves) for sale in the Gipath shop.
- Half effect rune for sale on Gipath.
- Blue harpies drop their heads, like the other harpies. The game had the heads but gave them to no monster.

#### Changed
- The starter version runs through EIStarter-UM, Universal Mod's open source launcher, instead of EI starter.
- Airy grants +2 to Sensory Magic instead of +10, and Trickster +2 to Use/Steal instead of +10.
- Dragons on Gipath no longer have more than 1000 hit points.
- Starter version: spells with a permanent or triggered action item rune can't be put into wands.
- Multiplayer: spears, maces, hammers and clubs give no attack skill bonus (1.07 added one).
- Russian: Zak's "My head hurts" speech at the start of a new game is no longer shortened.
- The movie at the start of a new game plays again.
- The main menu shows "Version 1.08" and the EItweaks version.
- In the starter version, Options > Windows > Show tutorial defaults to off, which also turns off the tutorials of
  the introductory quest; the player's choice is kept.

#### Fixed
- GOG versions: the camera tilts smoothly instead of jumping, the quest marker and hero lights have their original
  colors, and shadows are on: the installer sets the camera, light and shadow settings the CD installer wrote, where
  the player has not changed them. Texture and landscape detail default to their highest the same way.
- Monsters that only cast spells show their spells' damage in the description window, from the weakest spell's
  to the strongest's: toads, will-o-wisps, harpies, banshees, bats, evil eyes, shadows, octopuses and unicorns. Red
  harpies also show their damage type.
- Russian: the name of the Khadaganian boots of green dragon hide is spelled right.
- Red dragons have extra protection from fire, like green and blue dragons from their elements.
- The medium strength potion lasts longer than the small one, as its price says: a broken spell setting dropped both
  its duration modifiers, so it wore off sooner than even the very small one.
- Mountain lizards, grey harpies, foxbats and black foxbats wear their own textures from the game files, instead of
  those of lake lizards, red harpies and bats.
- The wings of foxbats and black foxbats have their names the right way round.
- Black banshees in Death canyon at night wear the black banshee texture, not the white one.
- Black Clan woodsfolk in the City environs wear their own clan's texture, not the White Clan's. Black Clan magicians
  wear the magician texture from the game files, and two Green Clan magicians wear theirs, like the other magicians.
- White horses in Karansul's domain and Suslanger wear the white horse texture, not the red one.
- Through eix's SpellAddon, configured for EItweaks only (so not in the standalone version):
  - Running depletes stamina by points rather than percentage: longer runs above 75 maximum stamina, shorter below.
  - No crash when an object without its server-side half comes into view (`ultrafixes`).
  - Vision grows evenly from 4:00 to 8:00 instead of jumping to day at 8:00, and stays at its night value in caves
    (`nightpowervisionpatch`, `nightvisionincaves`).
  - The Middle Mountains load the map their zone data names, not one chosen by a quest variable (`removefrozenvar`).

### 1.0
Initial release.
