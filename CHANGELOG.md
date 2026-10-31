### 2.0

#### Added
- Separate releases for the Russian, English and German versions of the game.
- A standalone version, copied over the game's files, for playing without EI starter.
- An installer for every game language and both versions: it detects the game's language, downloads and runs EI
  starter's own installer when starter is missing, and selects EItweaks in starter. The standalone version backs up
  the game files it replaces, and uninstalling puts them back. Under Wine, it sets the override starter needs to load
  its add-on.
- The starter version runs on the GOG versions without the game disc.
- The starter version brings starter's add-on 0.12.4.2 (starter 1.046.1 has 0.11.0.0), used when EItweaks is selected.
- German: the data of the official German patch 1.06 (maps, quests, multiplayer texts), so the GOG German version,
  which the patch refuses to install on, needs no patch.
- The fixes of the unofficial patch 1.07 (Gipat Group) that 1.0 lacked, for every language: campaign map scripts
  (trolls coming back to the witch's cave, Go-Go's dialogues, the goblin sentry phrase repeating, levers and
  mechanisms that could trap the player, quest rewards and experience given on every visit to a zone), the
  multiplayer database, `ai.reg` and, in Russian, the texts.
- English and German: 1.07's corrected marker position for the "Punishing goblins" quest on the world map.
- Hide armor for sale in the Gipath shop.
- Half effect rune for sale on Gipath.
- Running depletes stamina by points rather than percentage: longer runs above 35 maximum stamina, shorter below.
  The installer installs SpellAddon 20.6 into the game folder, configured for EItweaks only.

#### Changed
- Airy grants +2 to Sensory Magic instead of +10, and Trickster +2 to Use/Steal instead of +10.
- Dragons on Gipath no longer have more than 1000 hit points.
- Multiplayer: spears, maces, hammers and clubs give no attack skill bonus (1.07 added one).
- The release no longer includes a `game.exe`.
- The starter version also turns off the tutorials of the introductory quest, once; Options > Windows > Show
  tutorial turns them back on.

#### Fixed
- GOG versions: the camera tilts smoothly instead of jumping, the quest marker and hero lights have their original
  colors, and shadows are on: the installer sets the camera, light and shadow settings the CD installer wrote, where
  the player has not changed them. Texture and landscape detail default to their highest the same way.
- Toads and will-o-wisps show their real magic damage.
- Red harpies show their real damage type and range.
- Red dragons have extra protection from fire, like green and blue dragons from their elements.

### 1.0
Initial release.
