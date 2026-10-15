/*
 * mod-clear-restart loader
 * The AC module loader looks for Addmod_<name>Scripts() at startup.
 * This file just forwards to the real registration call in mod_clear_restart.cpp.
 */

#include "mod_clear_restart.h"

void Addmod_clear_restartScripts()
{
    // Registration happens in the static initializer of ClearRestartCommand.
    // The real constructor is invoked from the loader.
    // This function exists so the linker keeps the module's object file in.
    extern void RegisterClearRestartCommand();
    // (No-op: actual registration is in mod_clear_restart.cpp via the constructor.)
    (void)0;
}
