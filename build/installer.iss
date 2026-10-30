; EItweaks installer, one per language and version (variant):
;   iscc installer.iss /DLang=<ru|en|de> /DVariant=<starter|standalone> /DVersion=<version>
; Expects the release zip's folders (eitweaks, SpellAddon) in payload\ beside this file; writes to out\.
;
; starter: puts the mod into EI starter's Mods folder and SpellAddon into the game folder and starter's Engine folder.
; standalone: copies the mod over the game folder, backing up each file it replaces; uninstalling restores them.

#if !Defined(Lang) || !Defined(Variant) || !Defined(Version)
  #error Define Lang, Variant and Version
#endif

[Setup]
AppId=EItweaks-{#Variant}
AppName=EItweaks
AppVersion={#Version}
AppVerName=EItweaks {#Version}
AppPublisher=BGforge
AppPublisherURL=https://github.com/BGforgeNet/EItweaks
UninstallDisplayName=EItweaks {#Version} ({#Variant})
OutputDir=out
OutputBaseFilename=eitweaks-{#Version}-{#Lang}-{#Variant}-setup
Compression=lzma2/ultra64
SolidCompression=yes
; Game folders are usually writable by the user; one under Program Files needs the administrator choice.
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
DisableProgramGroupPage=yes
DirExistsWarning=no
AppendDefaultDirName=no
UsePreviousAppDir=yes
ShowLanguageDialog=no
WizardStyle=modern
#if Variant == "starter"
DefaultDirName={code:StarterDir}
#else
DefaultDirName={code:FindGameDir}
#endif

[Languages]
#if Lang == "ru"
Name: "ru"; MessagesFile: "compiler:Languages\Russian.isl"
#elif Lang == "de"
Name: "de"; MessagesFile: "compiler:Languages\German.isl"
#else
Name: "en"; MessagesFile: "compiler:Default.isl"
#endif

[CustomMessages]
#if Lang == "ru"
NoStarter=В этой папке нет EIStarter.exe. Выберите папку, куда установлен EI starter 1.046.1, или сначала установите его: https://www.gipath.org/forum/thread-3828.html
NoGame=В этой папке нет game.exe. Выберите папку Проклятых Земель.
GameDirCaption=Папка игры
GameDirDesc=Куда установлены Проклятые Земли?
GameDirSub=SpellAddon, который EItweaks использует для бега, устанавливается в папку игры.
#elif Lang == "de"
NoStarter=In diesem Ordner gibt es keine EIStarter.exe. Wählen Sie den Ordner, in dem EI starter 1.046.1 installiert ist, oder installieren Sie ihn zuerst: https://www.gipath.org/forum/thread-3828.html
NoGame=In diesem Ordner gibt es keine game.exe. Wählen Sie den Ordner von Evil Islands.
GameDirCaption=Spielordner
GameDirDesc=Wo ist Evil Islands installiert?
GameDirSub=SpellAddon, das EItweaks für das Laufen nutzt, wird in den Spielordner installiert.
#else
NoStarter=There is no EIStarter.exe in this folder. Select the folder where EI starter 1.046.1 is installed, or install it first: https://www.gipath.org/forum/thread-3828.html
NoGame=There is no game.exe in this folder. Select the Evil Islands folder.
GameDirCaption=Game folder
GameDirDesc=Where is Evil Islands installed?
GameDirSub=SpellAddon, which EItweaks uses for running, goes into the game folder.
#endif

[Files]
; SpellAddon's licence forbids distributing its files apart from its whole folder: the installer carries the folder
; unmodified and installs it complete, beside the mod, as the release zip does.
#if Variant == "starter"
Source: "payload\SpellAddon\*"; DestDir: "{app}\Mods\eitweaks\SpellAddon"; Flags: recursesubdirs ignoreversion
Source: "payload\eitweaks\*"; DestDir: "{app}\Mods\eitweaks"; Flags: recursesubdirs createallsubdirs ignoreversion
; SpellAddon may serve other mods too, so uninstalling EItweaks leaves it; its own SPELLADDON.INI changes nothing in the
; game and one already there is kept.
Source: "payload\SpellAddon\SpellAddonXa.asi"; DestDir: "{code:GameDirValue}"; Flags: ignoreversion uninsneveruninstall
Source: "payload\SpellAddon\SpellAddonInfo.txt"; DestDir: "{code:GameDirValue}"; Flags: ignoreversion uninsneveruninstall
Source: "payload\SpellAddon\SPELLADDON.INI"; DestDir: "{code:GameDirValue}"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "payload\SpellAddon\SpellAddonXa.asi"; DestDir: "{app}\Engine"; Flags: ignoreversion uninsneveruninstall
Source: "payload\SpellAddon\SpellAddonInfo.txt"; DestDir: "{app}\Engine"; Flags: ignoreversion uninsneveruninstall
Source: "payload\SpellAddon\SPELLADDON.INI"; DestDir: "{app}\Engine"; Flags: onlyifdoesntexist uninsneveruninstall
#else
Source: "payload\SpellAddon\*"; DestDir: "{app}\eitweaks-SpellAddon"; Flags: recursesubdirs ignoreversion
Source: "payload\eitweaks\*"; DestDir: "{app}"; Flags: recursesubdirs createallsubdirs ignoreversion; BeforeInstall: Backup
Source: "payload\SpellAddon\SpellAddonXa.asi"; DestDir: "{app}"; Flags: ignoreversion; BeforeInstall: Backup
Source: "payload\SpellAddon\SpellAddonInfo.txt"; DestDir: "{app}"; Flags: ignoreversion; BeforeInstall: Backup
#endif

[UninstallDelete]
#if Variant == "starter"
; The game and the plugin write files into the mod's folder.
Type: filesandordirs; Name: "{app}\Mods\eitweaks"
#endif

[Code]
var
  GamePage: TInputDirWizardPage;

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

function GameDirValue(Param: String): String;
begin
  Result := GamePage.Values[0];
end;

procedure InitializeWizard;
begin
#if Variant == "starter"
  GamePage := CreateInputDirPage(wpSelectDir, CustomMessage('GameDirCaption'), CustomMessage('GameDirDesc'),
    CustomMessage('GameDirSub'), False, '');
  GamePage.Add('');
  GamePage.Values[0] := FindGameDir('');
#endif
end;

{ The first problem with the chosen folders, or '' when there is none. }
function FolderProblem(PageID: Integer): String;
begin
  Result := '';
#if Variant == "starter"
  if (PageID = wpSelectDir) and not FileExists(AddBackslash(WizardDirValue) + 'EIStarter.exe') then
    Result := CustomMessage('NoStarter')
  else if (PageID = GamePage.ID) and not FileExists(AddBackslash(GamePage.Values[0]) + 'game.exe') then
    Result := CustomMessage('NoGame');
#else
  if (PageID = wpSelectDir) and not FileExists(AddBackslash(WizardDirValue) + 'game.exe') then
    Result := CustomMessage('NoGame');
#endif
end;

function NextButtonClick(CurPageID: Integer): Boolean;
var
  Problem: String;
begin
  Problem := FolderProblem(CurPageID);
  Result := Problem = '';
  if not Result then
    MsgBox(Problem, mbError, MB_OK);
end;

{ Also reached by silent installs, which skip the wizard pages. }
function PrepareToInstall(var NeedsRestart: Boolean): String;
begin
  Result := FolderProblem(wpSelectDir);
#if Variant == "starter"
  if Result = '' then
    Result := FolderProblem(GamePage.ID);
#endif
end;

#if Variant == "standalone"
{ Before each file is copied: keeps the game's original once, under eitweaks-backup. }
procedure Backup;
var
  Dest, Saved: String;
begin
  Dest := ExpandConstant(CurrentFileName);
  Saved := ExpandConstant('{app}\eitweaks-backup\') + Copy(Dest, Length(ExpandConstant('{app}\')) + 1, MaxInt);
  if FileExists(Dest) and not FileExists(Saved) then
  begin
    ForceDirectories(ExtractFileDir(Saved));
    FileCopy(Dest, Saved, False);
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
            FileCopy(Src + '\' + Found.Name, Dst + '\' + Found.Name, False);
      until not FindNext(Found);
    finally
      FindClose(Found);
    end;
end;

{ After the uninstaller has removed EItweaks' files: puts the game's originals back. }
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
  end;
end;
#endif
