; EItweaks installer, one for every game language and both versions:
;   iscc installer.iss /DVersion=<version>
; Expects payload\ beside this file, as `eibuild payload` writes it; writes to out\.
;
; The player picks the game folder, the game's language (detected, can be changed) and the version:
; with EI starter (recommended): the mod goes into starter's Mods folder, SpellAddon into the game folder;
; standalone: the mod is copied over the game, each replaced file backed up and restored on uninstall.
; Silent installs take /EIGAMEDIR=<folder>, /EILANG=<ru|en|de> and /EIVARIANT=<starter|standalone>.

#if !Defined(Version)
  #error Define Version
#endif

#include "payload\files.iss"

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
; Unpacks the downloaded EI starter zip.
ArchiveExtraction=full
DirExistsWarning=no
AppendDefaultDirName=no
; {app} is starter's folder or the game's, depending on the version chosen.
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
en.VariantStarter=With EI starter (recommended): selected in starter, the game's files stay untouched.
en.VariantStandalone=Standalone: installed directly into the game folder. Can be used with Cursed Lands.
en.StarterFound=EI starter is installed in %1.
en.StarterMissing=EI starter is not installed: Next downloads and installs it.
en.OpenStarterPage=EI starter's page
en.DownloadCaption=EI starter
en.DownloadDesc=Downloading EI starter 1.046.1 from its site.
en.StarterFailed=EI starter could not be downloaded: %1%n%nInstall it from its page, then click Next again, or choose the standalone version.
en.StarterNotInstalled=EI starter was not installed. Install it, then click Next again, or choose the standalone version.
en.StarterDirLabel=Select the folder where EI starter is installed.
en.NoStarter=There is no EIStarter.exe in this folder. Select the folder where EI starter 1.046.1 is installed, or install it first: https://www.gipath.org/forum/thread-3828.html
en.OldSpellAddon=An older SpellAddon, %1, could not be moved aside and would load together with EItweaks' one. Remove it by hand.
en.LaunchStarter=Launch EI starter
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
ru.VariantStarter=С EI starter (рекомендуется): выбирается в стартере, файлы игры не меняются.
ru.VariantStandalone=Отдельно: устанавливается прямо в папку игры. Подходит для Cursed Lands.
ru.StarterFound=EI starter установлен в %1.
ru.StarterMissing=EI starter не установлен: «Далее» скачает и установит его.
ru.OpenStarterPage=Страница EI starter
ru.DownloadCaption=EI starter
ru.DownloadDesc=Загрузка EI starter 1.046.1 с его сайта.
ru.StarterFailed=Не удалось скачать EI starter: %1%n%nУстановите его со страницы стартера и снова нажмите «Далее» или выберите отдельный вариант.
ru.StarterNotInstalled=EI starter не установлен. Установите его и снова нажмите «Далее» или выберите отдельный вариант.
ru.StarterDirLabel=Выберите папку, куда установлен EI starter.
ru.NoStarter=В этой папке нет EIStarter.exe. Выберите папку, куда установлен EI starter 1.046.1, или сначала установите его: https://www.gipath.org/forum/thread-3828.html
ru.OldSpellAddon=Старую версию SpellAddon, %1, не удалось убрать, и она будет загружаться вместе с версией EItweaks. Удалите её вручную.
ru.LaunchStarter=Запустить EI starter
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
de.VariantStarter=Mit EI starter (empfohlen): im Starter ausgewählt, die Spieldateien bleiben unverändert.
de.VariantStandalone=Eigenständig: direkt in den Spielordner installiert. Auch mit Cursed Lands nutzbar.
de.StarterFound=EI starter ist in %1 installiert.
de.StarterMissing=EI starter ist nicht installiert: "Weiter" lädt ihn herunter und installiert ihn.
de.OpenStarterPage=Seite von EI starter
de.DownloadCaption=EI starter
de.DownloadDesc=EI starter 1.046.1 wird von seiner Seite heruntergeladen.
de.StarterFailed=EI starter konnte nicht heruntergeladen werden: %1%n%nInstallieren Sie ihn von seiner Seite und klicken Sie dann erneut auf "Weiter", oder wählen Sie die eigenständige Variante.
de.StarterNotInstalled=EI starter wurde nicht installiert. Installieren Sie ihn und klicken Sie dann erneut auf "Weiter", oder wählen Sie die eigenständige Variante.
de.StarterDirLabel=Wählen Sie den Ordner, in dem EI starter installiert ist.
de.NoStarter=In diesem Ordner gibt es keine EIStarter.exe. Wählen Sie den Ordner, in dem EI starter 1.046.1 installiert ist, oder installieren Sie ihn zuerst: https://www.gipath.org/forum/thread-3828.html
de.OldSpellAddon=Eine ältere SpellAddon-Version, %1, konnte nicht beiseitegelegt werden und würde zusammen mit der von EItweaks geladen. Entfernen Sie sie von Hand.
de.LaunchStarter=EI starter starten
de.LaunchGame=Spiel starten

[Files]
; SpellAddon's licence forbids distributing its files apart from its whole folder: the installer carries the folder
; unmodified (dontcopy) and installs the files SpellAddon's own instructions name, into the game folder. The game loads
; .asi files from there, also when run through starter 1.046.1; a copy in starter's Engine folder is not loaded.
; SpellAddon may serve other mods too, so uninstalling EItweaks leaves the starter version's copies; its own
; SPELLADDON.INI changes nothing in the game, and one already there is kept.
Source: "payload\SpellAddon\*"; Flags: dontcopy recursesubdirs
Source: "payload\SpellAddon\SpellAddonXa.asi"; DestDir: "{code:GameDirValue}"; Flags: ignoreversion uninsneveruninstall; Check: IsStarter
Source: "payload\SpellAddon\SpellAddonInfo.txt"; DestDir: "{code:GameDirValue}"; Flags: ignoreversion uninsneveruninstall; Check: IsStarter
Source: "payload\SpellAddon\SPELLADDON.INI"; DestDir: "{code:GameDirValue}"; Flags: onlyifdoesntexist uninsneveruninstall; Check: IsStarter
Source: "payload\SpellAddon\SpellAddonXa.asi"; DestDir: "{app}"; Flags: ignoreversion; Check: IsStandalone; BeforeInstall: Backup
Source: "payload\SpellAddon\SpellAddonInfo.txt"; DestDir: "{app}"; Flags: ignoreversion; Check: IsStandalone; BeforeInstall: Backup

[Registry]
; The game settings EI starter reads; the game writes them only when quit from its main menu, and starter reports a
; missing one on its first start. These are the game's own defaults, written only where absent. Starter copies the
; game's key on its first start; once it has, its copy gets them too.
#define GameSettings(Key) \
  "Root: HKCU; Subkey: """ + Key + "\General Settings""; ValueType: dword; ValueName: ""Antialiasing""; ValueData: 0; Flags: createvalueifdoesntexist; Check: IsStarter" + NewLine + \
  "Root: HKCU; Subkey: """ + Key + "\General Settings""; ValueType: dword; ValueName: ""Audio""; ValueData: 1; Flags: createvalueifdoesntexist; Check: IsStarter" + NewLine + \
  "Root: HKCU; Subkey: """ + Key + "\General Settings""; ValueType: dword; ValueName: ""Dithering""; ValueData: 0; Flags: createvalueifdoesntexist; Check: IsStarter" + NewLine + \
  "Root: HKCU; Subkey: """ + Key + "\General Settings""; ValueType: dword; ValueName: ""FPSIndependentCursor""; ValueData: 1; Flags: createvalueifdoesntexist; Check: IsStarter" + NewLine + \
  "Root: HKCU; Subkey: """ + Key + "\General Settings""; ValueType: dword; ValueName: ""FullScreen""; ValueData: 1; Flags: createvalueifdoesntexist; Check: IsStarter" + NewLine + \
  "Root: HKCU; Subkey: """ + Key + "\General Settings""; ValueType: dword; ValueName: ""Video""; ValueData: 1; Flags: createvalueifdoesntexist; Check: IsStarter" + NewLine + \
  "Root: HKCU; Subkey: """ + Key + "\General Settings""; ValueType: dword; ValueName: ""VideoColorDepthInBits""; ValueData: 32; Flags: createvalueifdoesntexist; Check: IsStarter" + NewLine + \
  "Root: HKCU; Subkey: """ + Key + "\General Settings""; ValueType: string; ValueName: ""VideoResolution""; ValueData: ""1024x768""; Flags: createvalueifdoesntexist; Check: IsStarter" + NewLine + \
  "Root: HKCU; Subkey: """ + Key + "\Terrain Settings""; ValueType: dword; ValueName: ""LightingFreq""; ValueData: 1000; Flags: createvalueifdoesntexist; Check: IsStarter" + NewLine + \
  "Root: HKCU; Subkey: """ + Key + "\Terrain Settings""; ValueType: dword; ValueName: ""EnableWaterWaves""; ValueData: 1; Flags: createvalueifdoesntexist; Check: IsStarter" + NewLine + \
  "Root: HKCU; Subkey: """ + Key + "\Network Settings""; ValueType: string; ValueName: ""Master Server Name""; ValueData: """"; Flags: createvalueifdoesntexist; Check: IsStarter" + NewLine
; Starter's selected mod: EItweaks, just installed.
Root: HKCU; Subkey: "Software\Gipat.ru\EI_Starter\Settings"; ValueType: string; ValueName: "AddonPath"; ValueData: "{app}\MODS\eitweaks"; Check: IsStarter
; Starter's game loads its add-on (and so EItweaks' plugin) through the dinput.dll beside it, which Wine skips for its
; own unless told otherwise; without the add-on, the game asks for the disc. Starter needs this for any mod, so it stays.
Root: HKCU; Subkey: "Software\Wine\AppDefaults\game.exe\DllOverrides"; ValueType: string; ValueName: "dinput"; ValueData: "native,builtin"; Check: IsStarter and IsWine
#emit GameSettings("Software\Nival Interactive\EvilIslands")
#emit StringChange(GameSettings("Software\Gipat.ru\EI_Starter\EvilIslands"), "Check: IsStarter", "Check: IsStarter and StarterCopiedSettings")
; The GOG versions' installers write no camera or light settings, so the game saves its built-in defaults, which
; differ from what the CD installer wrote: the camera tilts in jumps, and quest and hero lights glare. A value still at
; the built-in default (the same in every language's GOG exe), or missing, gets the CD installer's; one the player
; changed is kept. Both versions; starter's copy too, once it has made one. The texture and landscape detail settings
; follow the same rule, to their highest, as starter's options write them: textures High (full size), trilinear
; filtering, landscape detail High (90 and 130, as the CD installer had), and mipmapping on.
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
Filename: "{app}\EIStarter.exe"; WorkingDir: "{app}"; Description: "{cm:LaunchStarter}"; Flags: postinstall nowait skipifsilent runasoriginaluser; Check: IsStarter
Filename: "{app}\game.exe"; WorkingDir: "{app}"; Description: "{cm:LaunchGame}"; Flags: postinstall nowait skipifsilent runasoriginaluser; Check: IsStandalone

[Code]
const
  StarterURL = 'https://www.gipath.org/forum/thread-3828.html';
  { EI starter 1.046.1 as published on its page; the download is checked against this. }
  StarterZipURL = 'https://www.gipath.org/forum/attachment.php?aid=3003';
  StarterZipSHA256 = 'ee13fa2b7317eadc77b9d69d00d9835c83b56f0fef1f199cd005c2ce9db011e0';
  { texts.res of the GOG Russian version, the same as the official Russian patch 1.06's. }
  RussianTextsSHA256 = '96d8e49a3472f93d92ec8b4ad4286fa7662d78fc4577fe2335832542014b3a5a';

var
  GamePage: TInputDirWizardPage;
  LangPage, VariantPage: TInputOptionWizardPage;
  DownloadPage: TDownloadWizardPage;
  StarterPageButton: TNewButton;
  DetectedFor: String;
  Relaunched: Boolean;

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

{ Every Wine prefix has this key. }
function IsWine: Boolean;
begin
  Result := RegKeyExists(HKLM, 'Software\Wine');
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

function StarterDir(Param: String): String;
begin
  if not RegQueryStringValue(HKCU, 'Software\Gipat.ru\EI_Starter', 'path', Result) or (Result = '') then
    Result := ExpandConstant('{autopf}\EI starter');
  Result := RemoveBackslashUnlessRoot(Result);
end;

function StarterInstalled: Boolean;
begin
  Result := FileExists(AddBackslash(StarterDir('')) + 'EIStarter.exe');
end;

{ Starter copies the game's key on its first start; writing its copy before that would make it skip the copy. }
function StarterCopiedSettings: Boolean;
begin
  Result := RegKeyExists(HKCU, 'Software\Gipat.ru\EI_Starter\EvilIslands\Path Settings');
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

{ Whether this run can write into Dir: a folder under Program Files needs administrator rights. }
function CanWrite(Dir: String): Boolean;
var
  Probe: String;
begin
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

{ Downloads EI starter, checks it, and runs its installer for the game's language; True once starter is installed. }
function InstallStarter: Boolean;
var
  Setup: String;
  ErrorCode: Integer;
begin
  Result := False;
  DownloadPage.Clear;
  DownloadPage.Add(StarterZipURL, 'eistarter.zip', StarterZipSHA256);
  DownloadPage.Show;
  try
    try
      DownloadPage.Download;
      ExtractArchive(ExpandConstant('{tmp}\eistarter.zip'), ExpandConstant('{tmp}\eistarter'), '', True, nil);
    except
      MsgBox(FmtMessage(CustomMessage('StarterFailed'), [GetExceptionMessage]), mbError, MB_OK);
      Exit;
    end;
  finally
    DownloadPage.Hide;
  end;
  { Starter has Russian and English installers only. }
  if IsGameLang('ru') then
    Setup := ExpandConstant('{tmp}\eistarter\setup_ru.exe')
  else
    Setup := ExpandConstant('{tmp}\eistarter\setup_en.exe');
  { ShellExec, not Exec: starter's installer asks for administrator rights. }
  ShellExecAsOriginalUser('', Setup, '', '', SW_SHOWNORMAL, ewWaitUntilTerminated, ErrorCode);
  Result := StarterInstalled;
  if not Result then
    MsgBox(CustomMessage('StarterNotInstalled'), mbError, MB_OK);
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
    Result := CustomMessage('NoGame')
  else if IsStarter and not FileExists(AddBackslash(WizardDirValue) + 'EIStarter.exe') then
    Result := CustomMessage('NoStarter');
end;

{ The last page before installing: the version page for standalone, the starter folder page for starter. When this
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
    begin
      if not StarterInstalled then
        Result := InstallStarter;
      if Result then
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
    if Problem = '' then
      Result := ReadyToInstall;
  end;
  if Problem <> '' then
  begin
    MsgBox(Problem, mbError, MB_OK);
    Result := False;
  end;
end;

{ Also reached by silent installs, which skip the wizard pages. }
function PrepareToInstall(var NeedsRestart: Boolean): String;
begin
  Result := FolderProblem;
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

{ Standalone: into eitweaks-backup, which uninstalling puts back along with removing our SpellAddon. Starter: our
  SpellAddon stays after uninstalling, so the old ones stay aside too. Starter's Engine is checked as its readme tells
  players to copy SpellAddon there. }
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssInstall then
    if IsStandalone then
      MoveOldSpellAddons(GameDirValue(''), ExpandConstant('{app}\eitweaks-backup'))
    else
    begin
      MoveOldSpellAddons(GameDirValue(''), AddBackslash(GameDirValue('')) + 'eitweaks-old-SpellAddon');
      MoveOldSpellAddons(ExpandConstant('{app}\Engine'), ExpandConstant('{app}\eitweaks-old-SpellAddon'));
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
  starter version removes what the game and the plugin wrote into the mod's folder. }
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  Saved: String;
begin
  if CurUninstallStep = usPostUninstall then
  begin
    Saved := ExpandConstant('{app}\eitweaks-backup');
    if DirExists(Saved) then
    begin
      RestoreDir(Saved, ExpandConstant('{app}'));
      DelTree(Saved, True, True, True);
    end;
    if FileExists(ExpandConstant('{app}\EIStarter.exe')) and DirExists(ExpandConstant('{app}\Mods\eitweaks')) then
      DelTree(ExpandConstant('{app}\Mods\eitweaks'), True, True, True);
  end;
end;
