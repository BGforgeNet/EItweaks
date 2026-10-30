/* EI starter plugin for EItweaks.
 *
 * - The CD check: starter runs its own game.exe, the Russian 1.06 one, which checks that the current drive is the
 *   game disc. GOG's game.exe skips that check; this applies the same one-byte change in memory, after checking the
 *   exact bytes expected, so any other exe is left alone.
 * - Tutorials: the game's "Show tutorial" option (Options > Windows) is turned off once, on the first start with
 *   EItweaks; the player's later choice in that option is kept. */
#include <windows.h>
#include <string.h>

static int patch(void *at, const void *expected, const void *replacement, size_t size)
{
    MEMORY_BASIC_INFORMATION mbi;
    DWORD old;
    if (VirtualQuery(at, &mbi, sizeof mbi) == 0 || mbi.State != MEM_COMMIT)
        return 0;
    if (memcmp(at, expected, size) != 0)
        return 0;
    if (!VirtualProtect(at, size, PAGE_EXECUTE_READWRITE, &old))
        return 1;
    memcpy(at, replacement, size);
    VirtualProtect(at, size, old, &old);
    FlushInstructionCache(GetCurrentProcess(), at, size);
    return 0;
}

/* Starter keeps the game's settings under its own key, where the game reads them when run through starter. The
 * marker file in the mod's folder (path, ending in a backslash) says it was done. */
static int tutorials_off_once(const char *path)
{
    static const DWORD off = 0;
    char marker[MAX_PATH];
    HKEY settings;
    HANDLE f;
    if (!path || strlen(path) + sizeof "tutorials-off" > sizeof marker)
        return 2;
    strcpy(marker, path);
    strcat(marker, "tutorials-off");
    if (GetFileAttributesA(marker) != INVALID_FILE_ATTRIBUTES)
        return 0;
    if (RegCreateKeyExA(HKEY_CURRENT_USER, "Software\\Gipat.ru\\EI_Starter\\EvilIslands\\Game Specific Settings", 0,
                        NULL, 0, KEY_WRITE, NULL, &settings, NULL) != ERROR_SUCCESS)
        return 4;
    LONG set = RegSetValueExA(settings, "ShowTutorial", 0, REG_DWORD, (const BYTE *)&off, sizeof off);
    RegCloseKey(settings);
    if (set != ERROR_SUCCESS)
        return 8;
    f = CreateFileA(marker, GENERIC_WRITE, 0, NULL, CREATE_NEW, FILE_ATTRIBUTE_NORMAL, NULL);
    if (f == INVALID_HANDLE_VALUE)
        return 16;
    CloseHandle(f);
    return 0;
}

/* Runs before the game reads its settings; path is the mod's folder. A non-zero result goes to starter's addon.log. */
__declspec(dllexport) int __cdecl EntryBeforePatch(const char *path)
{
    return tutorials_off_once(path);
}

__declspec(dllexport) int __cdecl EntryAfterPatch(const char *path)
{
    (void)path;
    /* je 0x456c10; mov edi, [0x73b670] -> jmp 0x456c10, as in GOG's game.exe. */
    static const unsigned char cd_check[] = {0x74, 0x59, 0x8b, 0x3d, 0x70, 0xb6, 0x73, 0x00};
    static const unsigned char cd_skip[] = {0xeb, 0x59, 0x8b, 0x3d, 0x70, 0xb6, 0x73, 0x00};
    return patch((void *)0x456bb5, cd_check, cd_skip, sizeof cd_check);
}
