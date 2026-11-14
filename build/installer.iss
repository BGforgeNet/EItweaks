; EItweaks installer, one for every game language and both versions:
;   iscc installer.iss /DVersion=<version>
; Expects payload\ beside this file, as `eibuild payload` writes it; writes to out\.
;
; The player picks the game folder, the game's language (detected, can be changed) and the version:
; with EIStarter-UM (recommended): the bundled launcher is installed when missing, the mod goes into its mods
; folder, eix's loader into its Engine folder, and the launcher's config selects EItweaks;
; standalone: the mod is copied over the game, each replaced file backed up and restored on uninstall.
; Silent installs take /EIGAMEDIR=<folder>, /EILANG=<ru|en|de> and /EIVARIANT=<starter|standalone>; the starter's
; options /EICOMPANIONS=<1|0> and /EIRUNSYSTEM=<1|0> (default 1) set its mercenary travel and running system,
; /EIPAUSEHEALTH=<1|0> (default 1) its pause at 25% health, /EIPAUSESIGHTED, /EIPAUSEAGGRO and /EIPAUSEDEAD=<1|0>
; (default 0) its pauses on enemies, and /EICLIPCURSOR=<1|0> (default 0) keeping the mouse in the game window.

#if !Defined(Version)
  #error Define Version
#endif

#include "payload\files.iss"

; The pinned launcher package is embedded so installation works offline.
#define StarterZipName "EIStarter-UM-0.2.9.zip"

[Setup]
AppId=EItweaks
AppName=EItweaks
AppVersion={#Version}
AppVerName=EItweaks {#Version}
AppPublisher=BGforge
AppPublisherURL=https://github.com/BGforgeNet/EItweaks
OutputDir=out
OutputBaseFilename=eitweaks-{#Version}
Compression=lzma2/ultra64
SolidCompression=yes
; Game folders are usually writable by the user. For one that is not, the installer restarts itself with /ALLUSERS,
; which asks for administrator rights.
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=commandline
DisableProgramGroupPage=yes
; Every choice has its own page already.
DisableReadyPage=yes
; Unpacks the embedded EIStarter-UM zip.
ArchiveExtraction=full
DirExistsWarning=no
AppendDefaultDirName=no
; {app} is the launcher's folder or the game's, depending on the version chosen.
UsePreviousAppDir=no
WizardStyle=modern
DefaultDirName={code:DefaultAppDir}
; The setup's own language follows Windows'; it asks only when that is none of its languages.
ShowLanguageDialog=auto

[Languages]
Name: "en"; MessagesFile: "compiler:Default.isl"
Name: "ru"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "de"; MessagesFile: "compiler:Languages\German.isl"

[CustomMessages]
en.GameDirCaption=Game folder
en.GameDirDesc=Where is Evil Islands installed?
en.GameDirSub=Select the folder of the game EItweaks is for.
en.NoGame=There is no game.exe in this folder. Select the Evil Islands folder.
en.LangCaption=Game language
en.LangDesc=Which language is the game in?
en.LangSub=Detected from the game folder. Change it if it is wrong.
en.VariantCaption=Version
en.VariantDesc=How do you want to play EItweaks?
en.VariantStarter=With EIStarter-UM (recommended): selected in the launcher, the game's files stay untouched.
en.VariantStandalone=Standalone: installed directly into the game folder. Can be used with Cursed Lands.
en.StarterFound=EIStarter-UM is installed in %1.
en.StarterMissing=EIStarter-UM is not installed: the bundled version is installed into the folder chosen next.
en.StarterOld=EIStarter-UM in %1 is older than 0.2.9: it is updated from the bundled version, keeping its settings and mods.
en.OpenStarterPage=EIStarter-UM's page
en.StarterFailed=EIStarter-UM could not be unpacked: %1%n%nClick Next to try again, or go back and choose the standalone version.
en.StarterDirLabel=Select the folder of EIStarter-UM. When it is not there, the bundled version is installed into this folder.
en.LaunchStarter=Launch EIStarter-UM
en.LaunchGame=Launch the game
en.OptionsCaption=Options
en.OptionsDesc=Which EItweaks features do you want?
en.OptionsSub=All can be changed later in the mod folder: the mercenaries in eitweaks.ini, running and walking in eix.ini and spelladdon.ini, the pauses (single player) and the mouse in eix.ini.
en.OptCompanions=Mercenaries travel with the hero between allods
en.OptRunSystem=Rebalanced running and walking: running costs a fixed amount of stamina, and the load carried slows running, and above the maximum load walking too
en.OptPauseHealth=Pause when a party member's health falls below 25%
en.OptPauseSighted=Pause when an enemy comes into view
en.OptPauseAggro=Pause when an enemy attacks the party
en.OptPauseDead=Pause when an enemy in view dies
en.OptClipCursor=Keep the mouse inside the game window in windowed mode
ru.GameDirCaption=Папка игры
ru.GameDirDesc=Куда установлены Проклятые Земли?
ru.GameDirSub=Выберите папку игры, для которой устанавливается EItweaks.
ru.NoGame=В этой папке нет game.exe. Выберите папку Проклятых Земель.
ru.LangCaption=Язык игры
ru.LangDesc=На каком языке игра?
ru.LangSub=Определён по папке игры. Измените, если неверно.
ru.VariantCaption=Вариант
ru.VariantDesc=Как вы хотите играть в EItweaks?
ru.VariantStarter=С EIStarter-UM (рекомендуется): выбирается в лаунчере, файлы игры не меняются.
ru.VariantStandalone=Отдельно: устанавливается прямо в папку игры. Подходит для Cursed Lands.
ru.StarterFound=EIStarter-UM установлен в %1.
ru.StarterMissing=EIStarter-UM не установлен: встроенная версия будет установлена в папку, выбранную далее.
ru.StarterOld=EIStarter-UM в %1 старше версии 0.2.9: он будет обновлён из установщика, его настройки и моды сохранятся.
ru.OpenStarterPage=Страница EIStarter-UM
ru.StarterFailed=Не удалось распаковать EIStarter-UM: %1%n%nНажмите Далее, чтобы попробовать снова, или вернитесь и выберите отдельный вариант.
ru.StarterDirLabel=Выберите папку EIStarter-UM. Если его там нет, встроенная версия будет установлена в эту папку.
ru.LaunchStarter=Запустить EIStarter-UM
ru.LaunchGame=Запустить игру
ru.OptionsCaption=Настройки
ru.OptionsDesc=Какие возможности EItweaks включить?
ru.OptionsSub=Всё можно изменить позже в папке мода: наёмников в eitweaks.ini, бег и ходьбу в eix.ini и spelladdon.ini, паузы (в одиночной игре) и мышь в eix.ini.
ru.OptCompanions=Наёмники путешествуют с героем между аллодами
ru.OptRunSystem=Новая система бега и ходьбы: бег тратит постоянное количество выносливости, а переносимый груз замедляет бег, а сверх максимального груза и ходьбу
ru.OptPauseHealth=Пауза, когда здоровье члена отряда падает ниже 25%
ru.OptPauseSighted=Пауза, когда в поле зрения появляется враг
ru.OptPauseAggro=Пауза, когда враг нападает на отряд
ru.OptPauseDead=Пауза, когда погибает враг в поле зрения
ru.OptClipCursor=Не выпускать курсор мыши из окна игры в оконном режиме
de.GameDirCaption=Spielordner
de.GameDirDesc=Wo ist Evil Islands installiert?
de.GameDirSub=Wählen Sie den Ordner des Spiels, für das EItweaks bestimmt ist.
de.NoGame=In diesem Ordner gibt es keine game.exe. Wählen Sie den Ordner von Evil Islands.
de.LangCaption=Sprache des Spiels
de.LangDesc=In welcher Sprache ist das Spiel?
de.LangSub=Aus dem Spielordner erkannt. Ändern Sie sie, falls sie nicht stimmt.
de.VariantCaption=Variante
de.VariantDesc=Wie möchten Sie EItweaks spielen?
de.VariantStarter=Mit EIStarter-UM (empfohlen): im Launcher ausgewählt, die Spieldateien bleiben unverändert.
de.VariantStandalone=Eigenständig: direkt in den Spielordner installiert. Auch mit Cursed Lands nutzbar.
de.StarterFound=EIStarter-UM ist in %1 installiert.
de.StarterMissing=EIStarter-UM ist nicht installiert: Die enthaltene Version wird im folgenden Ordner installiert.
de.StarterOld=EIStarter-UM in %1 ist aelter als 0.2.9: Er wird aus dem Installationspaket aktualisiert, seine Einstellungen und Mods bleiben erhalten.
de.OpenStarterPage=Seite von EIStarter-UM
de.StarterFailed=EIStarter-UM konnte nicht entpackt werden: %1%n%nKlicken Sie auf "Weiter", um es erneut zu versuchen, oder waehlen Sie die eigenstaendige Variante.
de.StarterDirLabel=Waehlen Sie den Ordner von EIStarter-UM. Ist er dort nicht vorhanden, wird die enthaltene Version dort installiert.
de.LaunchStarter=EIStarter-UM starten
de.LaunchGame=Spiel starten
de.OptionsCaption=Optionen
de.OptionsDesc=Welche Funktionen von EItweaks moechten Sie?
de.OptionsSub=Alles laesst sich spaeter im Mod-Ordner aendern: die Soeldner in eitweaks.ini, Rennen und Gehen in eix.ini und spelladdon.ini, die Pausen (Einzelspieler) und die Maus in eix.ini.
de.OptCompanions=Soeldner reisen mit dem Helden zwischen den Allods
de.OptRunSystem=Neues Renn- und Gehsystem: Rennen kostet eine feste Menge Ausdauer, und die getragene Last verlangsamt das Rennen, ueber der Hoechstlast auch das Gehen
de.OptPauseHealth=Pause, wenn die Gesundheit eines Gruppenmitglieds unter 25% faellt
de.OptPauseSighted=Pause, wenn ein Feind in Sicht kommt
de.OptPauseAggro=Pause, wenn ein Feind die Gruppe angreift
de.OptPauseDead=Pause, wenn ein Feind in Sicht stirbt
de.OptClipCursor=Den Mauszeiger im Fenstermodus im Spielfenster halten

[InstallDelete]
; EItweaks 1.0 and the 2.0 test builds replaced the new game's movie with an empty file; one left in the mod folder by
; an earlier install would keep hiding it.
Type: files; Name: "{app}\mods\eitweaks\movies\intro.bik"; Check: IsStarter
Type: dirifempty; Name: "{app}\mods\eitweaks\movies"; Check: IsStarter

[Files]
; EIStarter-UM, when its folder had none or an older one: the embedded package, unpacked into {tmp}. It may serve
; other mods, so it stays after uninstalling, as the launcher a player installs by hand would.
Source: "{#StarterZipName}"; Flags: dontcopy
Source: "{tmp}\eistarter-um\EIStarter-UM\*"; DestDir: "{app}"; Flags: external recursesubdirs createallsubdirs ignoreversion uninsneveruninstall; Check: StarterPrepared
; eix's add-on, in the mod folder, stops the game when the launcher's loader starts it, so eix's loader replaces that
; one, after the launcher package above. It still loads the original add-on of the launcher and its other mods, so it
; stays after uninstalling, as the launcher does. eix's built-in SpellAddon keeps any SpellAddon*.asi from loading.
Source: "payload\Engine\dinput.dll"; DestDir: "{app}\Engine"; Flags: ignoreversion uninsneveruninstall; Check: IsStarter
; D7VK, as the game's DirectDraw: the game loads ddraw.dll from its own folder before the system's.
Source: "payload\Engine\ddraw.dll"; DestDir: "{app}\Engine"; Flags: ignoreversion; Check: IsStarter

[Registry]
; At every Play EIStarter-UM itself writes the selected mod (AddonPath), the game settings a fresh installation has
; where missing, and, under Wine, the dinput override its loader needs.
; Wine uses its own DirectDraw even with a ddraw.dll beside the game, unless the game's overrides prefer the native one.
Root: HKCU; Subkey: "Software\Wine\AppDefaults\game.exe\DllOverrides"; ValueType: string; ValueName: "ddraw"; ValueData: "native,builtin"; Flags: uninsdeletevalue; Check: IsStarter and IsWine
; The GOG versions' installers write no camera or light settings, so the game saves its built-in defaults, which
; differ from what the CD installer wrote: the camera tilts in jumps, and quest and hero lights glare. A value still at
; the built-in default (the same in every language's GOG exe), or missing, gets the CD installer's; one the player
; changed is kept. Both versions; the launcher's copy too, once it has made one. The texture and landscape detail
; settings follow the same rule, to their highest, as EI starter's options wrote them: textures High (full size),
; trilinear filtering, landscape detail High (90 and 130, as the CD installer had), and mipmapping on.
#define CdFloat(Root, Key, Name, Builtin, CD, Cond) \
  "Root: HKCU; Subkey: """ + Root + "\" + Key + """; ValueType: binary; ValueName: """ + Name + """; ValueData: """ + CD + \
  """; Check: FloatAtBuiltin('" + Root + "\" + Key + "', '" + Name + "', '" + Builtin + "')" + Cond + NewLine
#define CdDWord(Root, Key, Name, Builtin, CD, Cond) \
  "Root: HKCU; Subkey: """ + Root + "\" + Key + """; ValueType: dword; ValueName: """ + Name + """; ValueData: " + CD + \
  "; Check: DWordAtBuiltin('" + Root + "\" + Key + "', '" + Name + "', " + Builtin + ")" + Cond + NewLine
#define CdSettings(Root, Cond) \
  CdDWord(Root, "Camera Settings", "CameraBorderScrollArea", "5", "1", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraBriefingMaxDistanceToCarrier", "00 00 c8 42", "00 00 d8 41", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraBriefingMaxLimitDistanceToCarrier", "00 00 a0 42", "00 00 f0 41", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraBriefingMinDistanceToCarrier", "00 00 80 40", "00 00 c0 40", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraBriefingMinPitch", "00 00 f0 41", "00 00 20 42", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraDefaultHeight", "00 00 f0 41", "00 00 00 40", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraDefaultMaxPitch", "00 00 a0 42", "00 00 70 42", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraDefaultMinPitch", "00 00 a0 41", "00 00 f0 41", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraDefaultPitchPowerKeyboard", "00 00 00 3f", "1f 85 eb 3e", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraDefaultPitchSpeed", "00 00 80 3f", "a6 9b c4 3a", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraDefaultRotatePowerKeyboard", "00 00 00 3f", "1f 85 eb 3e", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraDefaultRotateSpeed", "00 00 80 3f", "9a 99 19 3e", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraDefaultScrollPowerKeyboard", "00 00 00 3f", "1f 85 eb 3e", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraDefaultScrollSpeed", "00 00 80 3f", "00 00 c0 3f", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraDefaultXDeploy", "00 00 00 00", "00 00 f0 41", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraDefaultYDeploy", "00 00 00 00", "00 00 f0 41", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraDefaultZoomPowerKeyboard", "00 00 00 3f", "1f 85 eb 3e", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraDefaultZoomSpeed", "00 00 80 3f", "00 00 00 40", Cond) + \
  CdDWord(Root, "Camera Settings", "CameraFrameSelectionSensetiveArea", "20", "30", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraMaxDistanceToCarrier", "00 00 c8 42", "00 00 48 42", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraMaxHeight", "00 00 c8 42", "00 00 8c 42", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraMaxLimitDistanceToCarrier", "00 00 a0 42", "00 00 8c 42", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraMinDistanceToCarrier", "00 00 80 40", "00 00 20 41", Cond) + \
  CdFloat(Root, "Camera Settings", "CameraMinHeight", "00 00 80 40", "00 00 40 40", Cond) + \
  CdDWord(Root, "Game Specific Settings", "Hero Light R", "255", "216", Cond) + \
  CdDWord(Root, "Game Specific Settings", "Hero Light G", "236", "216", Cond) + \
  CdDWord(Root, "Game Specific Settings", "Hero Light B", "170", "116", Cond) + \
  CdDWord(Root, "Game Specific Settings", "Hero Light Radius", "10", "5", Cond) + \
  CdDWord(Root, "Game Specific Settings", "Quest Light R", "200", "120", Cond) + \
  CdDWord(Root, "Game Specific Settings", "Quest Light G", "255", "72", Cond) + \
  CdDWord(Root, "Game Specific Settings", "Quest Light B", "255", "120", Cond) + \
  CdDWord(Root, "Game Specific Settings", "Quest Light Radius", "10", "5", Cond) + \
  CdFloat(Root, "Game Specific Settings", "ObjectsLightingCoeff", "00 00 80 3f", "00 00 00 40", Cond) + \
  CdDWord(Root, "Game Specific Settings", "UseSWCursors", "1", "0", Cond) + \
  CdDWord(Root, "Shadow Settings", "ShadowQuality", "0", "2", Cond) + \
  CdFloat(Root, "Terrain Settings", "BorderFogDistance", "00 00 00 42", "00 00 80 41", Cond) + \
  CdDWord(Root, "Terrain Settings", "ShadowingFreq", "6000", "60000", Cond) + \
  CdDWord(Root, "General Settings", "TextureQuality", "1", "0", Cond) + \
  CdDWord(Root, "General Settings", "Mipmapping", "0", "1", Cond) + \
  CdDWord(Root, "General Settings", "Filtering", "1", "2", Cond) + \
  CdFloat(Root, "Terrain Settings", "LOD1", "00 00 20 42", "00 00 b4 42", Cond) + \
  CdFloat(Root, "Terrain Settings", "LOD2", "00 00 96 42", "00 00 02 43", Cond)
#emit CdSettings("Software\Nival Interactive\EvilIslands", "")
#emit CdSettings("Software\Gipat.ru\EI_Starter\EvilIslands", " and StarterCopiedSettings")

[Run]
Filename: "{app}\EIStarter-UM.exe"; WorkingDir: "{app}"; Description: "{cm:LaunchStarter}"; Flags: postinstall nowait skipifsilent runasoriginaluser; Check: IsStarter
Filename: "{app}\game.exe"; WorkingDir: "{app}"; Description: "{cm:LaunchGame}"; Flags: postinstall nowait skipifsilent runasoriginaluser; Check: IsStandalone

[Code]
const
  StarterURL = 'https://github.com/Kyr4l/ei-universal-mod/blob/master/docs/EIStarter-UM.md';
  { EIStarter-UM 0.2.9, the first version that keeps the options changed in the game (earlier ones rewrote them at
    every Play), published with Universal Mod's 0.8.7 pre-release; the embedded archive is checked against this. }
  StarterZipSHA256 = '5f190de3f59e1cb3604de9c127f1100d577b40cb0564b1cbae173c3a5638d2a9';
  StarterZipName = '{#StarterZipName}';
  StarterExe = 'EIStarter-UM.exe';
  { texts.res of the GOG Russian version, the same as the official Russian patch 1.06's. }
  RussianTextsSHA256 = '96d8e49a3472f93d92ec8b4ad4286fa7662d78fc4577fe2335832542014b3a5a';
  { game.exe of the GOG English and German versions (one file), and the same with the large address aware bit set. }
  GogExeSHA256 = 'd0fc0bb2acf45f0e59fae89e55c16a59848ffa89fb68feee9f298a680b660ad8';
  GogExeLargeSHA256 = 'e09e15be36c3568ecc689e85b56788dfe4c400700b72d291a3ec3461d66cdb19';
  { The launcher's copy of that exe, in its Engine folder. }
  GameExeCopy = 'game-en.exe';
  NivalKey = 'Software\Nival Interactive\EvilIslands';
  StarterCopyKey = 'Software\Gipat.ru\EI_Starter\EvilIslands';
  AddonKey = 'Software\Gipat.ru\EI_Starter\settings';
  ENUM_CURRENT_SETTINGS = $FFFFFFFF;
  { A line starting with #13#10 would be read as a preprocessor directive. }
  CRLF = #13#10;

type
  { DEVMODEW, 220 bytes, as dwords: dmSize is the low word of dword 17, dmBitsPerPel dword 42, dmPelsWidth 43 and
    dmPelsHeight 44. }
  TDevMode = record
    D: array[0..54] of Cardinal;
  end;

var
  GamePage: TInputDirWizardPage;
  LangPage, VariantPage, OptionsPage: TInputOptionWizardPage;
  StarterPageButton: TNewButton;
  DetectedFor: String;
  Relaunched: Boolean;
  { The launcher folder the embedded package was unpacked for; '' before that. }
  PreparedFor: String;

function EnumDisplaySettings(DeviceName: Cardinal; ModeNum: Cardinal; var DevMode: TDevMode): BOOL;
  external 'EnumDisplaySettingsW@user32.dll stdcall';

function WineVersion: Integer;
  external 'wine_get_version@ntdll.dll cdecl delayload';

function IsWine: Boolean;
begin
  try
    Result := WineVersion <> 0;
  except
    Result := False;
  end;
end;

{ Language option index <-> code; the options are added in this order. }
function LangCode(Index: Integer): String;
begin
  case Index of
    0: Result := 'ru';
    1: Result := 'en';
  else
    Result := 'de';
  end;
end;

function LangIndex(Code: String): Integer;
begin
  if Code = 'ru' then
    Result := 0
  else if Code = 'en' then
    Result := 1
  else if Code = 'de' then
    Result := 2
  else
    Result := -1;
end;

function IsGameLang(Code: String): Boolean;
begin
  Result := LangCode(LangPage.SelectedValueIndex) = Code;
end;

function IsStarter: Boolean;
begin
  Result := VariantPage.SelectedValueIndex = 0;
end;

function IsStandalone: Boolean;
begin
  Result := not IsStarter;
end;

function GameDirValue(Param: String): String;
begin
  Result := RemoveBackslashUnlessRoot(GamePage.Values[0]);
end;

function FindGameDir(Param: String): String;
begin
  { The game's own key first; starter keeps a copy of it under its own. }
  if not RegQueryStringValue(HKCU, 'Software\Nival Interactive\EvilIslands\Path Settings', 'WORK PATH', Result)
    or (Result = '') then
    if not RegQueryStringValue(HKCU, 'Software\Gipat.ru\EI_Starter\EvilIslands\Path Settings', 'WORK PATH', Result)
      or (Result = '') then
      Result := ExpandConstant('{sd}\GOG Games\Evil Islands');
  Result := RemoveBackslashUnlessRoot(Result);
end;

{ The launcher's folder: the one EIStarter-UM wrote at its last Play (EI starter writes the same value, so it counts
  only with EIStarter-UM in it), else Games\EIStarter-UM on the system drive, which a player can write to without
  administrator rights, unlike Program Files. }
function StarterDir(Param: String): String;
begin
  if not RegQueryStringValue(HKCU, 'Software\Gipat.ru\EI_Starter', 'path', Result) or (Result = '') or
    not FileExists(AddBackslash(Result) + StarterExe) then
    Result := ExpandConstant('{sd}\Games\EIStarter-UM');
  Result := RemoveBackslashUnlessRoot(Result);
end;

{ Whether Dir holds EIStarter-UM 0.2.9 or later, which names the backup of the game's settings it introduced. An
  older one is updated from the embedded package like a missing one; its config and mods stay. }
function HasStarter(const Dir: String): Boolean;
var
  Exe: AnsiString;
begin
  Result := LoadStringFromFile(AddBackslash(Dir) + StarterExe, Exe) and (Pos('EIStarter-UM-reg.cfg', Exe) > 0);
end;

function StarterInstalled: Boolean;
begin
  Result := HasStarter(StarterDir(''));
end;

function StarterPrepared: Boolean;
begin
  Result := (PreparedFor <> '') and (CompareText(PreparedFor, WizardDirValue) = 0);
end;

{ Whether the launcher has its copy of the game's key; until its first Play it reads the game's key alone. }
function StarterCopiedSettings: Boolean;
begin
  Result := RegKeyExists(HKCU, StarterCopyKey + '\Path Settings');
end;

{ For the CD installer's camera and light settings in [Registry]: whether a value is missing or still at the game's
  built-in default. Builtin is the float's bytes in hex, as in [Registry]; the bytes are compared by value, as a
  string of them would pass through a code page. }
function FloatAtBuiltin(const Key, Name, Builtin: String): Boolean;
var
  Cur: AnsiString;
  Hex: String;
  I: Integer;
begin
  Result := not RegQueryBinaryValue(HKCU, Key, Name, Cur);
  if not Result then
  begin
    Hex := '';
    for I := 1 to Length(Cur) do
    begin
      if I > 1 then
        Hex := Hex + ' ';
      Hex := Hex + Lowercase(Format('%.2x', [Ord(Cur[I])]));
    end;
    Result := Hex = Builtin;
  end;
end;

function DWordAtBuiltin(const Key, Name: String; Builtin: Integer): Boolean;
var
  Cur: Cardinal;
begin
  Result := not RegQueryDWordValue(HKCU, Key, Name, Cur) or (Cur = Cardinal(Builtin));
end;

{ Whether this run can write into Dir: a folder under Program Files needs administrator rights. A folder still to be
  made (the launcher's new one) is judged by the nearest one that exists. }
function CanWrite(Dir: String): Boolean;
var
  Probe: String;
begin
  while not DirExists(Dir) and (ExtractFileDir(Dir) <> Dir) do
    Dir := ExtractFileDir(Dir);
  Probe := AddBackslash(Dir) + 'eitweaks-write-test.tmp';
  Result := SaveStringToFile(Probe, '', False);
  if Result then
    DeleteFile(Probe);
end;

function BoolFlag(Value: Boolean): String;
begin
  if Value then
    Result := '1'
  else
    Result := '0';
end;

{ Starts this setup again with administrator rights and the choices made so far, and closes this one. }
procedure RelaunchAsAdmin;
var
  Params: String;
  ErrorCode: Integer;
begin
  Params := '/ALLUSERS /EIGAMEDIR="' + GamePage.Values[0] + '" /EILANG=' + LangCode(LangPage.SelectedValueIndex) +
    ' /DIR="' + WizardDirValue + '"';
  if IsStarter then
    Params := Params + ' /EIVARIANT=starter'
  else
    Params := Params + ' /EIVARIANT=standalone';
  Params := Params + ' /EICOMPANIONS=' + BoolFlag(OptionsPage.Values[0]) + ' /EIRUNSYSTEM=' +
    BoolFlag(OptionsPage.Values[1]) + ' /EIPAUSEHEALTH=' + BoolFlag(OptionsPage.Values[2]) + ' /EIPAUSESIGHTED=' +
    BoolFlag(OptionsPage.Values[3]) + ' /EIPAUSEAGGRO=' + BoolFlag(OptionsPage.Values[4]) + ' /EIPAUSEDEAD=' +
    BoolFlag(OptionsPage.Values[5]) + ' /EICLIPCURSOR=' + BoolFlag(OptionsPage.Values[6]);
  if ShellExec('', ExpandConstant('{srcexe}'), Params, '', SW_SHOWNORMAL, ewNoWait, ErrorCode) then
  begin
    Relaunched := True;
    WizardForm.Close;
  end
  else
    Log('Starting again as administrator failed: ' + SysErrorMessage(ErrorCode));
end;

procedure CancelButtonClick(CurPageID: Integer; var Cancel, Confirm: Boolean);
begin
  if Relaunched then
    Confirm := False;
end;

{ Unpacks the embedded launcher into the temporary folder, from where [Files] installs it.
  The error message, or '' once unpacked. }
function PrepareStarter: String;
var
  Zip: String;
begin
  Result := '';
  if StarterPrepared then
    Exit;
  try
    ExtractTemporaryFile(StarterZipName);
    Zip := ExpandConstant('{tmp}\') + StarterZipName;
    if Lowercase(GetSHA256OfFile(Zip)) <> StarterZipSHA256 then
      RaiseException('EIStarter-UM archive checksum mismatch');
    Log('EIStarter-UM from the embedded package');
    DelTree(ExpandConstant('{tmp}\eistarter-um'), True, True, True);
    ExtractArchive(Zip, ExpandConstant('{tmp}\eistarter-um'), '', True, nil);
    PreparedFor := WizardDirValue;
  except
    Result := GetExceptionMessage;
    Log('EIStarter-UM extraction failed: ' + Result);
  end;
end;

{ What keeps the launcher from being installed into the chosen folder: '' when it is there or has been unpacked. }
function StarterProblem: String;
begin
  Result := '';
  if IsStarter and not HasStarter(WizardDirValue) then
  begin
    Result := PrepareStarter;
    if Result <> '' then
      Result := FmtMessage(CustomMessage('StarterFailed'), [Result]);
  end;
end;

function DefaultAppDir(Param: String): String;
begin
  if ExpandConstant('{param:EIVARIANT|starter}') = 'standalone' then
  begin
    Result := ExpandConstant('{param:EIGAMEDIR|}');
    if Result = '' then
      Result := FindGameDir('');
  end
  else
    Result := StarterDir('');
end;

{ The game folder's language: known fingerprints of texts.res first, then words of its English or German texts,
  then the setup's own language. }
function DetectLang(Dir: String): Integer;
var
  Path, Sum: String;
  Texts: AnsiString;
begin
  Result := -1;
  Path := AddBackslash(Dir) + 'res\texts.res';
  if FileExists(Path) then
  begin
    try
      Sum := Lowercase(GetSHA256OfFile(Path));
    except
      Sum := '';
    end;
    if (Sum = RussianTextsSHA256) or (Sum = '{#TextsSHA256_ru}') then
      Result := 0
    else if (Sum = '{#TextsSHA256_en}') then
      Result := 1
    else if (Sum = '{#TextsSHA256_de}') then
      Result := 2
    else if LoadStringFromFile(Path, Texts) then
    begin
      if Pos('Show tutorial', Texts) > 0 then
        Result := 1
      else if Pos('anzeigen', Texts) > 0 then
        Result := 2;
    end;
  end;
  if Result < 0 then
  begin
    Result := LangIndex(ActiveLanguage);
    if Result < 0 then
      Result := 1;
  end;
end;

{ The game's folder named Param, as spelled on disk, so a case-sensitive file system gets no second folder. }
function GameSubdir(Param: String): String;
var
  Found: TFindRec;
begin
  Result := Param;
  if FindFirst(ExpandConstant('{app}\') + Param, Found) then
    try
      if Found.Attributes and FILE_ATTRIBUTE_DIRECTORY <> 0 then
        Result := Found.Name;
    finally
      FindClose(Found);
    end;
end;

procedure StarterPageClick(Sender: TObject);
var
  ErrorCode: Integer;
begin
  ShellExecAsOriginalUser('open', StarterURL, '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
end;

procedure UpdateStarterStatus;
begin
  if StarterInstalled then
    VariantPage.SubCaptionLabel.Caption := FmtMessage(CustomMessage('StarterFound'), [StarterDir('')])
  else if FileExists(AddBackslash(StarterDir('')) + StarterExe) then
    VariantPage.SubCaptionLabel.Caption := FmtMessage(CustomMessage('StarterOld'), [StarterDir('')])
  else
    VariantPage.SubCaptionLabel.Caption := CustomMessage('StarterMissing');
  StarterPageButton.Visible := not StarterInstalled;
end;

procedure InitializeWizard;
var
  Variant: String;
  Lang: Integer;
begin
  GamePage := CreateInputDirPage(wpWelcome, CustomMessage('GameDirCaption'), CustomMessage('GameDirDesc'),
    CustomMessage('GameDirSub'), False, '');
  GamePage.Add('');
  GamePage.Values[0] := ExpandConstant('{param:EIGAMEDIR|}');
  if GamePage.Values[0] = '' then
    GamePage.Values[0] := FindGameDir('');

  LangPage := CreateInputOptionPage(GamePage.ID, CustomMessage('LangCaption'), CustomMessage('LangDesc'),
    CustomMessage('LangSub'), True, False);
  LangPage.Add('Русский');
  LangPage.Add('English');
  LangPage.Add('Deutsch');
  Lang := LangIndex(ExpandConstant('{param:EILANG|}'));
  if Lang < 0 then
    Lang := DetectLang(GamePage.Values[0])
  else
    DetectedFor := GamePage.Values[0];
  LangPage.SelectedValueIndex := Lang;
  if DetectedFor = '' then
    DetectedFor := GamePage.Values[0];

  VariantPage := CreateInputOptionPage(LangPage.ID, CustomMessage('VariantCaption'), CustomMessage('VariantDesc'),
    '', True, False);
  VariantPage.Add(CustomMessage('VariantStarter'));
  VariantPage.Add(CustomMessage('VariantStandalone'));
  Variant := ExpandConstant('{param:EIVARIANT|starter}');
  if Variant = 'standalone' then
    VariantPage.SelectedValueIndex := 1
  else
    VariantPage.SelectedValueIndex := 0;
  StarterPageButton := TNewButton.Create(VariantPage);
  StarterPageButton.Parent := VariantPage.Surface;
  StarterPageButton.Caption := CustomMessage('OpenStarterPage');
  StarterPageButton.Width := ScaleX(200);
  StarterPageButton.Height := ScaleY(25);
  StarterPageButton.Top := VariantPage.SurfaceHeight - StarterPageButton.Height;
  StarterPageButton.OnClick := @StarterPageClick;
  VariantPage.CheckListBox.Height := StarterPageButton.Top - VariantPage.CheckListBox.Top - ScaleY(8);
  UpdateStarterStatus;

  { Every option needs eix, which only the starter version has. }
  OptionsPage := CreateInputOptionPage(VariantPage.ID, CustomMessage('OptionsCaption'), CustomMessage('OptionsDesc'),
    CustomMessage('OptionsSub'), False, False);
  OptionsPage.Add(CustomMessage('OptCompanions'));
  OptionsPage.Add(CustomMessage('OptRunSystem'));
  OptionsPage.Add(CustomMessage('OptPauseHealth'));
  OptionsPage.Add(CustomMessage('OptPauseSighted'));
  OptionsPage.Add(CustomMessage('OptPauseAggro'));
  OptionsPage.Add(CustomMessage('OptPauseDead'));
  OptionsPage.Add(CustomMessage('OptClipCursor'));
  OptionsPage.Values[0] := ExpandConstant('{param:EICOMPANIONS|1}') <> '0';
  OptionsPage.Values[1] := ExpandConstant('{param:EIRUNSYSTEM|1}') <> '0';
  OptionsPage.Values[2] := ExpandConstant('{param:EIPAUSEHEALTH|1}') <> '0';
  OptionsPage.Values[3] := ExpandConstant('{param:EIPAUSESIGHTED|0}') = '1';
  OptionsPage.Values[4] := ExpandConstant('{param:EIPAUSEAGGRO|0}') = '1';
  OptionsPage.Values[5] := ExpandConstant('{param:EIPAUSEDEAD|0}') = '1';
  OptionsPage.Values[6] := ExpandConstant('{param:EICLIPCURSOR|0}') = '1';

  WizardForm.SelectDirLabel.Caption := CustomMessage('StarterDirLabel');
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  { A changed game folder is detected again; a choice made for the same folder is kept. }
  if (CurPageID = LangPage.ID) and (CompareText(DetectedFor, GamePage.Values[0]) <> 0) then
  begin
    LangPage.SelectedValueIndex := DetectLang(GamePage.Values[0]);
    DetectedFor := GamePage.Values[0];
  end;
  if CurPageID = VariantPage.ID then
    UpdateStarterStatus;
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := ((PageID = wpSelectDir) or (PageID = OptionsPage.ID)) and IsStandalone;
end;

{ The first problem with the chosen folders, or '' when there is none. }
function FolderProblem: String;
begin
  Result := '';
  if not FileExists(AddBackslash(GameDirValue('')) + 'game.exe') then
    Result := CustomMessage('NoGame');
end;

{ The last page before installing: the version page for standalone, the launcher folder page for starter. When this
  run cannot write where EItweaks goes, it starts again with administrator rights. }
function ReadyToInstall: Boolean;
begin
  Result := True;
  if not IsAdminInstallMode and (not CanWrite(WizardDirValue) or not CanWrite(GameDirValue(''))) then
  begin
    Log('Cannot write into ' + WizardDirValue + ' or ' + GameDirValue('') + ': starting again as administrator');
    RelaunchAsAdmin;
    Result := False;
  end;
end;

function NextButtonClick(CurPageID: Integer): Boolean;
var
  Problem: String;
begin
  Result := True;
  Problem := '';
  if (CurPageID = GamePage.ID) and not FileExists(AddBackslash(GameDirValue('')) + 'game.exe') then
    Problem := CustomMessage('NoGame')
  else if CurPageID = VariantPage.ID then
  begin
    { A folder given with /DIR (by the player, or by the relaunch as administrator) stays the starter's folder. }
    if IsStarter then
    begin
      if ExpandConstant('{param:DIR|}') <> '' then
        WizardForm.DirEdit.Text := ExpandConstant('{param:DIR}')
      else
        WizardForm.DirEdit.Text := StarterDir('');
    end
    else
    begin
      WizardForm.DirEdit.Text := GameDirValue('');
      Result := ReadyToInstall;
    end;
  end
  else if CurPageID = wpSelectDir then
  begin
    Problem := FolderProblem;
    { Unpack after the rights check so a restarted installer does not repeat the work. }
    if Problem = '' then
    begin
      Result := ReadyToInstall;
      if Result then
        Problem := StarterProblem;
    end;
  end;
  if Problem <> '' then
  begin
    MsgBox(Problem, mbError, MB_OK);
    Result := False;
  end;
end;

{ Also reached by silent installs, which skip the wizard pages and unpack the launcher here. }
function PrepareToInstall(var NeedsRestart: Boolean): String;
begin
  Result := FolderProblem;
  if Result = '' then
    Result := StarterProblem;
end;

{ Standalone: before each file is copied, keeps the game's original once, under eitweaks-backup. }
procedure Backup;
var
  Dest, Saved: String;
begin
  Dest := ExpandConstant(CurrentFileName);
  Saved := ExpandConstant('{app}\eitweaks-backup\') + Copy(Dest, Length(ExpandConstant('{app}\')) + 1, MaxInt);
  if FileExists(Dest) and not FileExists(Saved) then
  begin
    ForceDirectories(ExtractFileDir(Saved));
    CopyFile(Dest, Saved, False);
  end;
end;

{ The screen's display modes ('1024x768'): those at 32 bits, the game's colour depth, or every one when the driver
  reports none at 32 bits; and the desktop's own, '' when unknown. }
procedure ScreenModes(Modes: TStringList; var Desktop: String);
var
  Mode: TDevMode;
  Any: TStringList;
  I: Cardinal;
  J: Integer;
  Size: String;
begin
  Any := TStringList.Create;
  try
    I := 0;
    Mode.D[17] := 220;
    while EnumDisplaySettings(0, I, Mode) do
    begin
      Size := IntToStr(Mode.D[43]) + 'x' + IntToStr(Mode.D[44]);
      if Any.IndexOf(Size) < 0 then
        Any.Add(Size);
      if (Mode.D[42] = 32) and (Modes.IndexOf(Size) < 0) then
        Modes.Add(Size);
      I := I + 1;
      Mode.D[17] := 220;
    end;
    if Modes.Count = 0 then
      for J := 0 to Any.Count - 1 do
        Modes.Add(Any[J]);
  finally
    Any.Free;
  end;
  Desktop := '';
  Mode.D[17] := 220;
  if EnumDisplaySettings(0, ENUM_CURRENT_SETTINGS, Mode) then
    Desktop := IntToStr(Mode.D[43]) + 'x' + IntToStr(Mode.D[44]);
end;

{ A resolution the screen offers for Want, as EIStarter-UM picks it: Want itself, else the desktop's, else the
  largest. The game cannot start in a size the screen lacks, and the add-on hides the error. }
function FitResolution(const Want: String): String;
var
  Modes: TStringList;
  Desktop: String;
  I, X, Pixels, Best: Integer;
begin
  Result := Want;
  Modes := TStringList.Create;
  try
    ScreenModes(Modes, Desktop);
    if (Modes.Count = 0) or (Modes.IndexOf(Want) >= 0) then
      Exit;
    if Modes.IndexOf(Desktop) >= 0 then
    begin
      Result := Desktop;
      Exit;
    end;
    Result := Modes[0];
    Best := 0;
    for I := 0 to Modes.Count - 1 do
    begin
      X := Pos('x', Modes[I]);
      Pixels := StrToIntDef(Copy(Modes[I], 1, X - 1), 0) * StrToIntDef(Copy(Modes[I], X + 1, MaxInt), 0);
      if Pixels > Best then
      begin
        Best := Pixels;
        Result := Modes[I];
      end;
    end;
  finally
    Modes.Free;
  end;
end;

{ A game setting as the launcher sees it: its copy of the game's key over the game's key. }
function GameSetting(const Section, Name: String; var Value: String): Boolean;
begin
  Result := RegQueryStringValue(HKCU, StarterCopyKey + '\' + Section, Name, Value) or
    RegQueryStringValue(HKCU, NivalKey + '\' + Section, Name, Value);
end;

function GameSettingDWord(const Section, Name: String; var Value: Cardinal): Boolean;
begin
  Result := RegQueryDWordValue(HKCU, StarterCopyKey + '\' + Section, Name, Value) or
    RegQueryDWordValue(HKCU, NivalKey + '\' + Section, Name, Value);
end;

{ What EIStarter-UM changes in the game's settings on its first start, which a written config skips: the cursor drawn
  independently of the frame rate off (it flickers with D7VK), a resolution the screen offers, 32-bit colour. Written
  where the launcher reads them: its copy of the game's key once it has one, else the game's key it makes it from. }
procedure FirstStartSettings;
var
  Key, Res, Fit: String;
  Depth: Cardinal;
begin
  if StarterCopiedSettings then
    Key := StarterCopyKey + '\General Settings'
  else
    Key := NivalKey + '\General Settings';
  RegWriteDWordValue(HKCU, Key, 'FPSIndependentCursor', 0);
  if GameSetting('General Settings', 'VideoResolution', Res) and (Res <> '') then
  begin
    Fit := FitResolution(Res);
    if Fit <> Res then
    begin
      Log('Resolution ' + Res + ' is not offered by this screen: ' + Fit);
      RegWriteStringValue(HKCU, Key, 'VideoResolution', Fit);
    end;
  end;
  if GameSettingDWord('General Settings', 'VideoColorDepthInBits', Depth) and (Depth <> 32) then
  begin
    Log('Colour depth ' + IntToStr(Depth) + ' bits: 32');
    RegWriteDWordValue(HKCU, Key, 'VideoColorDepthInBits', 32);
  end;
end;

{ An [Addon] line of the launcher's config from EI starter's registry value, which EIStarter-UM reads on its first
  start; '' when absent, so the launcher's own default applies. }
function AddonLine(const RegName, CfgName: String; IsBool: Boolean): String;
var
  Value: Cardinal;
begin
  Result := '';
  if RegQueryDWordValue(HKCU, AddonKey, RegName, Value) then
    if not IsBool then
      Result := CfgName + '=' + IntToStr(Value) + CRLF
    else if Value <> 0 then
      Result := CfgName + '=true' + CRLF
    else
      Result := CfgName + '=false' + CRLF;
end;

{ Selects EItweaks in the launcher. A new config also turns off the launcher's first-start questions: downloading
  Universal Mod, asked only while no config exists, and the original CD camera, which the [Registry] section already
  applies; so it carries what that first start would have set. }
procedure WriteStarterConfig;
var
  Cfg, Text: String;
begin
  Cfg := ExpandConstant('{app}\EIStarter-UM.cfg');
  if FileExists(Cfg) then
  begin
    if not SetIniString('Launcher', 'Mod', 'eitweaks', Cfg) then
      Log('Could not select EItweaks in ' + Cfg);
    Exit;
  end;
  Text := '[Launcher]' + CRLF + 'Mod=eitweaks' + CRLF + 'Language=' + LangCode(LangPage.SelectedValueIndex) + CRLF +
    'CameraCheck=false' + CRLF + CRLF + '[Addon]' + CRLF +
    AddonLine('LandscapeDrawRadius', 'LandscapeDrawRadius', False) +
    AddonLine('ObjectsDrawRadius', 'ObjectsDrawRadius', False) +
    AddonLine('PauseOnMinimize', 'PauseOnMinimize', True) +
    AddonLine('MP Speed-control', 'MPSpeedControl', True) +
    AddonLine('MQ client', 'MQClient', True) +
    AddonLine('MP console', 'MPConsole', True) +
    AddonLine('LogLevel', 'LogLevel', False) +
    AddonLine('ConsoleLogLevel', 'ConsoleLogLevel', False);
  if SaveStringToFile(Cfg, Text, False) then
    FirstStartSettings
  else
    Log('Could not write ' + Cfg);
end;

{ The game exe the launcher runs. The launcher's own is the Russian one, whose briefing voices an English or German
  game's speech does not have, so on the GOG English or German version the launcher runs a copy of that game's own
  exe, with the large address aware bit set as in the launcher's; eix supports both. Any other game gets the
  launcher's own back. }
procedure SetStarterExe;
var
  Cfg, ExeCopy: String;
  Exe: AnsiString;
  Header, Flags: Integer;
begin
  Cfg := ExpandConstant('{app}\EIStarter-UM.cfg');
  ExeCopy := ExpandConstant('{app}\Engine\') + GameExeCopy;
  if Lowercase(GetSHA256OfFile(AddBackslash(GameDirValue('')) + 'game.exe')) <> GogExeSHA256 then
  begin
    if CompareText(GetIniString('Launcher', 'ExeName', '', Cfg), GameExeCopy) = 0 then
      DeleteIniEntry('Launcher', 'ExeName', Cfg);
    DeleteFile(ExeCopy);
    Exit;
  end;
  if not LoadStringFromFile(AddBackslash(GameDirValue('')) + 'game.exe', Exe) then
    RaiseException('Could not read the game''s game.exe.');
  { The PE header's offset is at 0x3C; its Characteristics field, 0x16 into it, holds the bit (0x20). }
  Header := Ord(Exe[$3D]) or (Ord(Exe[$3E]) shl 8) or (Ord(Exe[$3F]) shl 16) or (Ord(Exe[$40]) shl 24);
  Flags := Ord(Exe[Header + $17]) or $20;
  Exe[Header + $17] := Chr(Flags);
  if not SaveStringToFile(ExeCopy, Exe, False) or (Lowercase(GetSHA256OfFile(ExeCopy)) <> GogExeLargeSHA256) then
    RaiseException('Could not write ' + ExeCopy + '.');
  if not SetIniString('Launcher', 'ExeName', GameExeCopy, Cfg) then
    RaiseException('Could not set the game exe in ' + Cfg + '.');
end;

procedure SetModIni(const Section, Key, Value, FileName: String);
begin
  if not SetIniString(Section, Key, Value, ExpandConstant('{app}\mods\eitweaks\') + FileName) then
    RaiseException('Could not write ' + Key + ' into ' + FileName + '.');
end;

{ The options page's choices, into the mod's settings files, which every install replaces. Off gives the game's own
  behaviour: the mercenaries' farewells, and running's drain and speed without the load. }
procedure WriteOptions;
var
  Run: String;
begin
  SetModIni('Companions', 'Travel', BoolFlag(OptionsPage.Values[0]), 'eitweaks.ini');
  Run := BoolFlag(OptionsPage.Values[1]);
  SetModIni('Encumbrance', 'Enabled', Run, 'eix.ini');
  SetModIni('rebalanceengine', 'newrunsystem', Run, 'spelladdon.ini');
  SetModIni('rebalanceengine', 'rewriterunabilitytime', Run, 'spelladdon.ini');
  if OptionsPage.Values[2] then
    SetModIni('AutoPause', 'HealthPercent', '25', 'eix.ini')
  else
    SetModIni('AutoPause', 'HealthPercent', '0', 'eix.ini');
  SetModIni('AutoPause', 'EnemySighted', BoolFlag(OptionsPage.Values[3]), 'eix.ini');
  SetModIni('AutoPause', 'EnemyAggro', BoolFlag(OptionsPage.Values[4]), 'eix.ini');
  SetModIni('AutoPause', 'EnemyDead', BoolFlag(OptionsPage.Values[5]), 'eix.ini');
  SetModIni('EngineFixes', 'ClipCursorToWindow', BoolFlag(OptionsPage.Values[6]), 'eix.ini');
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if (CurStep = ssPostInstall) and IsStarter then
  begin
    WriteStarterConfig;
    SetStarterExe;
    WriteOptions;
    { Existing launcher configs skip FirstStartSettings. Both keys must agree: the launcher switches between them. }
    if not RegWriteDWordValue(HKCU, NivalKey + '\General Settings', 'FPSIndependentCursor', 0) then
      RaiseException('Could not disable the independent cursor for D7VK.');
    if IsStarter and StarterCopiedSettings then
      if not RegWriteDWordValue(HKCU, StarterCopyKey + '\General Settings', 'FPSIndependentCursor', 0) then
        RaiseException('Could not disable the independent cursor in the launcher settings.');
  end;
end;

procedure RestoreDir(const Src, Dst: String);
var
  Found: TFindRec;
begin
  if FindFirst(Src + '\*', Found) then
    try
      repeat
        if (Found.Name <> '.') and (Found.Name <> '..') then
          if Found.Attributes and FILE_ATTRIBUTE_DIRECTORY <> 0 then
          begin
            ForceDirectories(Dst + '\' + Found.Name);
            RestoreDir(Src + '\' + Found.Name, Dst + '\' + Found.Name);
          end
          else
            CopyFile(Src + '\' + Found.Name, Dst + '\' + Found.Name, False);
      until not FindNext(Found);
    finally
      FindClose(Found);
    end;
end;

{ After the uninstaller has removed EItweaks' files: the standalone version puts the game's originals back; the
  starter version removes what the game and the add-on wrote into the mod's folder, and the launcher's selection of
  it, so the launcher picks a mod of its own. }
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  Saved, Cfg: String;
begin
  if CurUninstallStep = usPostUninstall then
  begin
    Saved := ExpandConstant('{app}\eitweaks-backup');
    if DirExists(Saved) then
    begin
      RestoreDir(Saved, ExpandConstant('{app}'));
      DelTree(Saved, True, True, True);
    end;
    { The uninstaller may already have removed an empty mod folder, so the launcher's selection is cleared either way. }
    if FileExists(ExpandConstant('{app}\' + StarterExe)) then
    begin
      DelTree(ExpandConstant('{app}\mods\eitweaks'), True, True, True);
      Cfg := ExpandConstant('{app}\EIStarter-UM.cfg');
      if CompareText(GetIniString('Launcher', 'Mod', '', Cfg), 'eitweaks') = 0 then
        DeleteIniEntry('Launcher', 'Mod', Cfg);
      if CompareText(GetIniString('Launcher', 'ExeName', '', Cfg), GameExeCopy) = 0 then
        DeleteIniEntry('Launcher', 'ExeName', Cfg);
      DeleteFile(ExpandConstant('{app}\Engine\') + GameExeCopy);
    end;
  end;
end;
