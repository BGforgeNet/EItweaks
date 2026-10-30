; EItweaks installer, one for every game language and both versions:
;   iscc installer.iss /DVersion=<version>
; Expects payload\ beside this file, as `eibuild payload` writes it; writes to out\.
;
; The player picks the game folder, the game's language (detected, can be changed) and the version:
; with EI starter (recommended): the mod goes into starter's Mods folder, SpellAddon into the game and Engine folders;
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
OutputBaseFilename=eitweaks-{#Version}-setup
Compression=lzma2/ultra64
SolidCompression=yes
; Game folders are usually writable by the user; one under Program Files needs the administrator choice.
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
DisableProgramGroupPage=yes
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
en.VariantStarter=With EI starter (recommended): selected in starter, the game's files stay untouched
en.VariantStandalone=Standalone: copied over the game's files, which are backed up and restored on uninstall
en.StarterFound=EI starter is installed in %1.
en.StarterMissing=EI starter is not installed. Download it with the button below, install it, then continue here.
en.DownloadStarter=Download EI starter
en.StarterDirLabel=Select the folder where EI starter is installed.
en.NoStarter=There is no EIStarter.exe in this folder. Select the folder where EI starter 1.046.1 is installed, or install it first: https://www.gipath.org/forum/thread-3828.html
en.ReadyGame=Game folder:
en.ReadyLang=Game language:
en.ReadyVariant=Version:
en.ReadyStarter=EI starter folder:
ru.GameDirCaption=Папка игры
ru.GameDirDesc=Куда установлены Проклятые Земли?
ru.GameDirSub=Выберите папку игры, для которой устанавливается EItweaks.
ru.NoGame=В этой папке нет game.exe. Выберите папку Проклятых Земель.
ru.LangCaption=Язык игры
ru.LangDesc=На каком языке игра?
ru.LangSub=Определён по папке игры. Измените, если неверно.
ru.VariantCaption=Вариант
ru.VariantDesc=Как вы хотите играть в EItweaks?
ru.VariantStarter=С EI starter (рекомендуется): выбирается в стартере, файлы игры не меняются
ru.VariantStandalone=Отдельно: копируется поверх файлов игры, которые сохраняются и восстанавливаются при удалении
ru.StarterFound=EI starter установлен в %1.
ru.StarterMissing=EI starter не установлен. Скачайте его кнопкой ниже, установите и продолжите здесь.
ru.DownloadStarter=Скачать EI starter
ru.StarterDirLabel=Выберите папку, куда установлен EI starter.
ru.NoStarter=В этой папке нет EIStarter.exe. Выберите папку, куда установлен EI starter 1.046.1, или сначала установите его: https://www.gipath.org/forum/thread-3828.html
ru.ReadyGame=Папка игры:
ru.ReadyLang=Язык игры:
ru.ReadyVariant=Вариант:
ru.ReadyStarter=Папка EI starter:
de.GameDirCaption=Spielordner
de.GameDirDesc=Wo ist Evil Islands installiert?
de.GameDirSub=Wählen Sie den Ordner des Spiels, für das EItweaks bestimmt ist.
de.NoGame=In diesem Ordner gibt es keine game.exe. Wählen Sie den Ordner von Evil Islands.
de.LangCaption=Sprache des Spiels
de.LangDesc=In welcher Sprache ist das Spiel?
de.LangSub=Aus dem Spielordner erkannt. Ändern Sie sie, falls sie nicht stimmt.
de.VariantCaption=Variante
de.VariantDesc=Wie möchten Sie EItweaks spielen?
de.VariantStarter=Mit EI starter (empfohlen): im Starter ausgewählt, die Spieldateien bleiben unverändert
de.VariantStandalone=Eigenständig: über die Spieldateien kopiert, die gesichert und bei der Deinstallation wiederhergestellt werden
de.StarterFound=EI starter ist in %1 installiert.
de.StarterMissing=EI starter ist nicht installiert. Laden Sie ihn mit der Schaltfläche unten herunter, installieren Sie ihn und fahren Sie dann hier fort.
de.DownloadStarter=EI starter herunterladen
de.StarterDirLabel=Wählen Sie den Ordner, in dem EI starter installiert ist.
de.NoStarter=In diesem Ordner gibt es keine EIStarter.exe. Wählen Sie den Ordner, in dem EI starter 1.046.1 installiert ist, oder installieren Sie ihn zuerst: https://www.gipath.org/forum/thread-3828.html
de.ReadyGame=Spielordner:
de.ReadyLang=Sprache des Spiels:
de.ReadyVariant=Variante:
de.ReadyStarter=Ordner von EI starter:

[Files]
; SpellAddon's licence forbids distributing its files apart from its whole folder: the installer carries the folder
; unmodified and installs it complete, beside the mod, as the release zips do. SpellAddon may serve other mods too, so
; uninstalling EItweaks leaves the starter version's copies; its own SPELLADDON.INI changes nothing in the game, and
; one already there is kept.
Source: "payload\SpellAddon\*"; DestDir: "{app}\Mods\eitweaks\SpellAddon"; Flags: recursesubdirs ignoreversion; Check: IsStarter
Source: "payload\SpellAddon\SpellAddonXa.asi"; DestDir: "{code:GameDirValue}"; Flags: ignoreversion uninsneveruninstall; Check: IsStarter
Source: "payload\SpellAddon\SpellAddonInfo.txt"; DestDir: "{code:GameDirValue}"; Flags: ignoreversion uninsneveruninstall; Check: IsStarter
Source: "payload\SpellAddon\SPELLADDON.INI"; DestDir: "{code:GameDirValue}"; Flags: onlyifdoesntexist uninsneveruninstall; Check: IsStarter
Source: "payload\SpellAddon\SpellAddonXa.asi"; DestDir: "{app}\Engine"; Flags: ignoreversion uninsneveruninstall; Check: IsStarter
Source: "payload\SpellAddon\SpellAddonInfo.txt"; DestDir: "{app}\Engine"; Flags: ignoreversion uninsneveruninstall; Check: IsStarter
Source: "payload\SpellAddon\SPELLADDON.INI"; DestDir: "{app}\Engine"; Flags: onlyifdoesntexist uninsneveruninstall; Check: IsStarter
Source: "payload\SpellAddon\*"; DestDir: "{app}\eitweaks-SpellAddon"; Flags: recursesubdirs ignoreversion; Check: IsStandalone
Source: "payload\SpellAddon\SpellAddonXa.asi"; DestDir: "{app}"; Flags: ignoreversion; Check: IsStandalone; BeforeInstall: Backup
Source: "payload\SpellAddon\SpellAddonInfo.txt"; DestDir: "{app}"; Flags: ignoreversion; Check: IsStandalone; BeforeInstall: Backup

[Code]
const
  StarterURL = 'https://www.gipath.org/forum/thread-3828.html';
  { texts.res of the GOG Russian version, the same as the official Russian patch 1.06's. }
  RussianTextsSHA256 = '96d8e49a3472f93d92ec8b4ad4286fa7662d78fc4577fe2335832542014b3a5a';

var
  GamePage: TInputDirWizardPage;
  LangPage, VariantPage: TInputOptionWizardPage;
  DownloadButton: TNewButton;
  DetectedFor: String;

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

procedure DownloadStarterClick(Sender: TObject);
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
  DownloadButton.Visible := not StarterInstalled;
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
  DownloadButton := TNewButton.Create(VariantPage);
  DownloadButton.Parent := VariantPage.Surface;
  DownloadButton.Caption := CustomMessage('DownloadStarter');
  DownloadButton.Width := ScaleX(200);
  DownloadButton.Height := ScaleY(25);
  DownloadButton.Top := VariantPage.SurfaceHeight - DownloadButton.Height;
  DownloadButton.OnClick := @DownloadStarterClick;
  VariantPage.CheckListBox.Height := DownloadButton.Top - VariantPage.CheckListBox.Top - ScaleY(8);
  UpdateStarterStatus;

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

function NextButtonClick(CurPageID: Integer): Boolean;
var
  Problem: String;
begin
  Problem := '';
  if (CurPageID = GamePage.ID) and not FileExists(AddBackslash(GameDirValue('')) + 'game.exe') then
    Problem := CustomMessage('NoGame')
  else if CurPageID = VariantPage.ID then
  begin
    if IsStarter then
      WizardForm.DirEdit.Text := StarterDir('')
    else
      WizardForm.DirEdit.Text := GameDirValue('');
  end
  else if CurPageID = wpSelectDir then
    Problem := FolderProblem;
  Result := Problem = '';
  if not Result then
    MsgBox(Problem, mbError, MB_OK);
end;

{ Also reached by silent installs, which skip the wizard pages. }
function PrepareToInstall(var NeedsRestart: Boolean): String;
begin
  Result := FolderProblem;
end;

function UpdateReadyMemo(Space, NewLine, MemoUserInfoInfo, MemoDirInfo, MemoTypeInfo, MemoComponentsInfo,
  MemoGroupInfo, MemoTasksInfo: String): String;
begin
  Result := CustomMessage('ReadyGame') + NewLine + Space + GameDirValue('') + NewLine + NewLine +
    CustomMessage('ReadyLang') + NewLine + Space + LangPage.CheckListBox.ItemCaption[LangPage.SelectedValueIndex] +
    NewLine + NewLine + CustomMessage('ReadyVariant') + NewLine + Space +
    VariantPage.CheckListBox.ItemCaption[VariantPage.SelectedValueIndex];
  if IsStarter then
    Result := Result + NewLine + NewLine + CustomMessage('ReadyStarter') + NewLine + Space + WizardDirValue;
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
