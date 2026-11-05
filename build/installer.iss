; EItweaks installer, one for every game language and both versions:
;   iscc installer.iss /DVersion=<version>
; Expects payload\ beside this file, as `eibuild payload` writes it; writes to out\.
;
; The player picks the game folder, the game's language (detected, can be changed) and the version:
; with EIStarter-UM (recommended): the launcher is downloaded when its folder has none, the mod goes into its mods
; folder, SpellAddon into its Engine folder, and the launcher's config selects EItweaks;
; standalone: the mod is copied over the game, each replaced file backed up and restored on uninstall.
; Silent installs take /EIGAMEDIR=<folder>, /EILANG=<ru|en|de> and /EIVARIANT=<starter|standalone>.

#if !Defined(Version)
  #error Define Version
#endif

#include "payload\files.iss"

; The downloaded EIStarter-UM package, kept in the launcher's folder so installing again needs no download (the
; release's files can be replaced upstream).
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
; Unpacks the downloaded EIStarter-UM zip.
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
en.StarterMissing=EIStarter-UM is not installed: it is downloaded from GitHub into the folder chosen next.
en.StarterOld=EIStarter-UM in %1 is older than 0.2.9, which keeps the options changed in the game: it is updated from GitHub, keeping its settings and mods.
en.OpenStarterPage=EIStarter-UM's page
en.DownloadCaption=EIStarter-UM
en.DownloadDesc=Downloading EIStarter-UM 0.2.9 from GitHub.
en.StarterFailed=EIStarter-UM could not be downloaded: %1%n%nClick Next to try again, or go back and choose the standalone version.
en.StarterDirLabel=Select the folder of EIStarter-UM. When it is not there, it is downloaded into this folder.
en.OldSpellAddon=An older SpellAddon, %1, could not be moved aside and would load together with EItweaks' one. Remove it by hand.
en.LaunchStarter=Launch EIStarter-UM
en.LaunchGame=Launch the game
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
ru.StarterMissing=EIStarter-UM не установлен: он будет скачан с GitHub в папку, выбранную далее.
ru.StarterOld=EIStarter-UM в %1 старше версии 0.2.9, которая сохраняет настройки, изменённые в игре: он будет обновлён с GitHub, его настройки и моды сохранятся.
ru.OpenStarterPage=Страница EIStarter-UM
ru.DownloadCaption=EIStarter-UM
ru.DownloadDesc=Загрузка EIStarter-UM 0.2.9 с GitHub.
ru.StarterFailed=Не удалось скачать EIStarter-UM: %1%n%nНажмите «Далее», чтобы попробовать снова, или вернитесь и выберите отдельный вариант.
ru.StarterDirLabel=Выберите папку EIStarter-UM. Если его там нет, он будет скачан в эту папку.
ru.OldSpellAddon=Старую версию SpellAddon, %1, не удалось убрать, и она будет загружаться вместе с версией EItweaks. Удалите её вручную.
ru.LaunchStarter=Запустить EIStarter-UM
ru.LaunchGame=Запустить игру
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
de.StarterMissing=EIStarter-UM ist nicht installiert: Er wird von GitHub in den als Nächstes gewählten Ordner heruntergeladen.
de.StarterOld=EIStarter-UM in %1 ist älter als 0.2.9, die im Spiel geänderte Optionen behält: Er wird von GitHub aktualisiert, seine Einstellungen und Mods bleiben erhalten.
de.OpenStarterPage=Seite von EIStarter-UM
de.DownloadCaption=EIStarter-UM
de.DownloadDesc=EIStarter-UM 0.2.9 wird von GitHub heruntergeladen.
de.StarterFailed=EIStarter-UM konnte nicht heruntergeladen werden: %1%n%nKlicken Sie auf "Weiter", um es erneut zu versuchen, oder gehen Sie zurück und wählen Sie die eigenständige Variante.
de.StarterDirLabel=Wählen Sie den Ordner von EIStarter-UM. Ist er dort nicht vorhanden, wird er in diesen Ordner heruntergeladen.
de.OldSpellAddon=Eine ältere SpellAddon-Version, %1, konnte nicht beiseitegelegt werden und würde zusammen mit der von EItweaks geladen. Entfernen Sie sie von Hand.
de.LaunchStarter=EIStarter-UM starten
de.LaunchGame=Spiel starten

[InstallDelete]
; EItweaks 1.0 and the 2.0 test builds replaced the new game's movie with an empty file; one left in the mod folder by
; an earlier install would keep hiding it.
Type: files; Name: "{app}\mods\eitweaks\movies\intro.bik"; Check: IsStarter
Type: dirifempty; Name: "{app}\mods\eitweaks\movies"; Check: IsStarter

[Files]
; EIStarter-UM, when its folder had none or an older one: the downloaded package, unpacked into {tmp}. It may serve
; other mods, so it stays after uninstalling, as the launcher a player installs by hand would.
Source: "{tmp}\eistarter-um\EIStarter-UM\*"; DestDir: "{app}"; Flags: external recursesubdirs createallsubdirs ignoreversion uninsneveruninstall; Check: StarterDownloaded
; The downloaded package itself, kept beside it for installing again without a download.
Source: "{tmp}\eistarter-um.zip"; DestDir: "{app}"; DestName: "{#StarterZipName}"; Flags: external ignoreversion uninsneveruninstall; Check: StarterFetchedNow
; SpellAddon's licence forbids distributing its files apart from its whole folder: the installer carries the folder
; unmodified (dontcopy) and installs the files SpellAddon's own instructions name. EIStarter-UM's game runs with its
; own Miles (Engine\mss32.dll), which loads the .asi files of the Engine folder only, so they go there, in place of the
; older SpellAddon the launcher ships (moved aside after installing); the INI also into the game folder, where the
; instructions put it. SpellAddon may serve other mods too, so uninstalling EItweaks leaves the starter version's
; copies; its own SPELLADDON.INI changes nothing in the game, and one already there is kept.
Source: "payload\SpellAddon\*"; Flags: dontcopy recursesubdirs
Source: "payload\SpellAddon\SpellAddonXa.asi"; DestDir: "{app}\Engine"; Flags: ignoreversion uninsneveruninstall; Check: IsStarter
Source: "payload\SpellAddon\SpellAddonInfo.txt"; DestDir: "{app}\Engine"; Flags: ignoreversion uninsneveruninstall; Check: IsStarter
Source: "payload\SpellAddon\SPELLADDON.INI"; DestDir: "{app}\Engine"; Flags: onlyifdoesntexist uninsneveruninstall; Check: IsStarter
Source: "payload\SpellAddon\SPELLADDON.INI"; DestDir: "{code:GameDirValue}"; Flags: onlyifdoesntexist uninsneveruninstall; Check: IsStarter
Source: "payload\SpellAddon\SpellAddonXa.asi"; DestDir: "{app}"; Flags: ignoreversion; Check: IsStandalone; BeforeInstall: Backup
Source: "payload\SpellAddon\SpellAddonInfo.txt"; DestDir: "{app}"; Flags: ignoreversion; Check: IsStandalone; BeforeInstall: Backup

[Registry]
; At every Play EIStarter-UM itself writes the selected mod (AddonPath), the game settings a fresh installation has
; where missing, and, under Wine, the dinput override its loader needs.
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
    every Play), published with Universal Mod's 0.8.7 pre-release; the download is checked against this. }
  StarterZipURL = 'https://github.com/Kyr4l/ei-universal-mod/releases/download/0.8.7/EIStarter-UM-0.2.9.zip';
  StarterZipSHA256 = '5f190de3f59e1cb3604de9c127f1100d577b40cb0564b1cbae173c3a5638d2a9';
  StarterZipName = '{#StarterZipName}';
  StarterExe = 'EIStarter-UM.exe';
  { texts.res of the GOG Russian version, the same as the official Russian patch 1.06's. }
  RussianTextsSHA256 = '96d8e49a3472f93d92ec8b4ad4286fa7662d78fc4577fe2335832542014b3a5a';
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
  LangPage, VariantPage: TInputOptionWizardPage;
  DownloadPage: TDownloadWizardPage;
  StarterPageButton: TNewButton;
  DetectedFor: String;
  Relaunched: Boolean;
  { The launcher folder the package was downloaded and unpacked for, into the temporary folder; '' before that. }
  DownloadedFor: String;
  { The package came from the network, not from the kept copy. }
  StarterFetched: Boolean;

function EnumDisplaySettings(DeviceName: Cardinal; ModeNum: Cardinal; var DevMode: TDevMode): BOOL;
  external 'EnumDisplaySettingsW@user32.dll stdcall';

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
  older one is updated by the download like a missing one; its config and mods stay. }
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

function StarterDownloaded: Boolean;
begin
  Result := (DownloadedFor <> '') and (CompareText(DownloadedFor, WizardDirValue) = 0);
end;

function StarterFetchedNow: Boolean;
begin
  Result := StarterDownloaded and StarterFetched;
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

{ The copy of the launcher package kept in its folder after a download, when it is the pinned one. }
function CachedStarterZip: String;
begin
  Result := AddBackslash(WizardDirValue) + StarterZipName;
  if not FileExists(Result) or (Lowercase(GetSHA256OfFile(Result)) <> StarterZipSHA256) then
    Result := '';
end;

{ Gets EIStarter-UM, from the copy a previous install kept in its folder, else downloaded and checked, and unpacks it
  into the temporary folder, from where [Files] installs it; the wizard shows its download page, a silent install has
  none. The error message, or '' once unpacked. }
function DownloadStarter(UsePage: Boolean): String;
var
  Zip: String;
begin
  Result := '';
  if StarterDownloaded then
    Exit;
  try
    Zip := CachedStarterZip;
    StarterFetched := Zip = '';
    if StarterFetched then
    begin
      if UsePage then
      begin
        DownloadPage.Clear;
        DownloadPage.Add(StarterZipURL, 'eistarter-um.zip', StarterZipSHA256);
        DownloadPage.Show;
        try
          DownloadPage.Download;
        finally
          DownloadPage.Hide;
        end;
      end
      else
        DownloadTemporaryFile(StarterZipURL, 'eistarter-um.zip', StarterZipSHA256, nil);
      Zip := ExpandConstant('{tmp}\eistarter-um.zip');
    end
    else
      Log('EIStarter-UM from the kept copy ' + Zip);
    DelTree(ExpandConstant('{tmp}\eistarter-um'), True, True, True);
    ExtractArchive(Zip, ExpandConstant('{tmp}\eistarter-um'), '', True, nil);
    DownloadedFor := WizardDirValue;
  except
    Result := GetExceptionMessage;
    Log('EIStarter-UM download failed: ' + Result);
  end;
end;

{ What keeps the launcher from being installed into the chosen folder: '' when it is there or has been downloaded. }
function StarterProblem(UsePage: Boolean): String;
begin
  Result := '';
  if IsStarter and not HasStarter(WizardDirValue) then
  begin
    Result := DownloadStarter(UsePage);
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

  DownloadPage := CreateDownloadPage(CustomMessage('DownloadCaption'), CustomMessage('DownloadDesc'), nil);
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
  Result := (PageID = wpSelectDir) and IsStandalone;
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
    if IsStarter then
      WizardForm.DirEdit.Text := StarterDir('')
    else
    begin
      WizardForm.DirEdit.Text := GameDirValue('');
      Result := ReadyToInstall;
    end;
  end
  else if CurPageID = wpSelectDir then
  begin
    Problem := FolderProblem;
    { After the rights check: a run started again as administrator would download again. }
    if Problem = '' then
    begin
      Result := ReadyToInstall;
      if Result then
        Problem := StarterProblem(True);
    end;
  end;
  if Problem <> '' then
  begin
    MsgBox(Problem, mbError, MB_OK);
    Result := False;
  end;
end;

{ Also reached by silent installs, which skip the wizard pages and so download the launcher here. }
function PrepareToInstall(var NeedsRestart: Boolean): String;
begin
  Result := FolderProblem;
  if Result = '' then
    Result := StarterProblem(False);
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

{ SpellAddon's instructions ask to remove its older versions first: any other SpellAddon*.asi would load beside ours.
  They are moved into BackupDir, not deleted; one already backed up under the same name is kept and the player told. }
procedure MoveOldSpellAddons(const Dir, BackupDir: String);
var
  Found: TFindRec;
  Names: TStringList;
  I: Integer;
begin
  Names := TStringList.Create;
  try
    if FindFirst(Dir + '\SpellAddon*.asi', Found) then
      try
        repeat
          if CompareText(Found.Name, 'SpellAddonXa.asi') <> 0 then
            Names.Add(Found.Name);
        until not FindNext(Found);
      finally
        FindClose(Found);
      end;
    for I := 0 to Names.Count - 1 do
    begin
      ForceDirectories(BackupDir);
      if FileExists(BackupDir + '\' + Names[I]) or not RenameFile(Dir + '\' + Names[I], BackupDir + '\' + Names[I]) then
      begin
        Log('Could not move ' + Dir + '\' + Names[I] + ' into ' + BackupDir);
        SuppressibleMsgBox(FmtMessage(CustomMessage('OldSpellAddon'), [Dir + '\' + Names[I]]), mbError, MB_OK, IDOK);
      end
      else
        Log('Moved ' + Dir + '\' + Names[I] + ' into ' + BackupDir);
    end;
  finally
    Names.Free;
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

{ Standalone: before installing, into eitweaks-backup, which uninstalling puts back along with removing our SpellAddon.
  Starter: after installing, as the launcher package just installed brings its own SpellAddon; ours stays after
  uninstalling, so the old ones stay aside too. }
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if (CurStep = ssInstall) and IsStandalone then
    MoveOldSpellAddons(GameDirValue(''), ExpandConstant('{app}\eitweaks-backup'))
  else if (CurStep = ssPostInstall) and IsStarter then
  begin
    MoveOldSpellAddons(ExpandConstant('{app}\Engine'), ExpandConstant('{app}\eitweaks-old-SpellAddon'));
    WriteStarterConfig;
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
  starter version removes what the game and the plugin wrote into the mod's folder, and the launcher's selection of
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
    if FileExists(ExpandConstant('{app}\' + StarterExe)) and DirExists(ExpandConstant('{app}\mods\eitweaks')) then
    begin
      DelTree(ExpandConstant('{app}\mods\eitweaks'), True, True, True);
      Cfg := ExpandConstant('{app}\EIStarter-UM.cfg');
      if CompareText(GetIniString('Launcher', 'Mod', '', Cfg), 'eitweaks') = 0 then
        DeleteIniEntry('Launcher', 'Mod', Cfg);
    end;
  end;
end;
