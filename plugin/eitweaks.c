/* EI starter plugin for EItweaks. The starter runs its own game.exe, the Russian 1.06 one, which checks that the
 * current drive is the game disc. GOG's game.exe skips that check; this applies the same one-byte change in memory,
 * after checking the exact bytes expected, so any other exe is left alone. */
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

__declspec(dllexport) int __cdecl EntryBeforePatch(const char *path)
{
    (void)path;
    return 0;
}

__declspec(dllexport) int __cdecl EntryAfterPatch(const char *path)
{
    (void)path;
    /* je 0x456c10; mov edi, [0x73b670] -> jmp 0x456c10, as in GOG's game.exe. */
    static const unsigned char cd_check[] = {0x74, 0x59, 0x8b, 0x3d, 0x70, 0xb6, 0x73, 0x00};
    static const unsigned char cd_skip[] = {0xeb, 0x59, 0x8b, 0x3d, 0x70, 0xb6, 0x73, 0x00};
    return patch((void *)0x456bb5, cd_check, cd_skip, sizeof cd_check);
}
