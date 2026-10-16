/*
 * mod-clear-restart
 *
 * Registers one GM command: `.clearrestart`
 *
 * Truncates the four instance-related tables in acore_characters and
 * triggers a graceful restart. The ac-worldserver container is configured
 * with `restart: unless-stopped` in docker-compose, so it comes back
 * automatically.
 *
 * Uses the modern Acore::ChatCommands::ChatCommandBuilder API as required
 * by the Playerbot branch of AzerothCore.
 */

#include "mod_clear_restart.h"
#include "ScriptMgr.h"
#include "Chat.h"
#include "DatabaseEnv.h"
#include "World.h"
#include "Player.h"
#include "Language.h"

using namespace Acore::ChatCommands;

class ClearRestartCommand : public CommandScript
{
public:
    ClearRestartCommand() : CommandScript("clearrestart_command") {}

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable commandTable =
        {
            { "clearrestart", HandleClearRestart, SEC_GAMEMASTER, Console::No }
        };
        return commandTable;
    }

    static bool HandleClearRestart(ChatHandler* handler)
    {
        std::string who = "<console>";
        if (handler && handler->GetSession())
        {
            if (Player* p = handler->GetSession()->GetPlayer())
            {
                who = p->GetName();
            }
        }

        // 1. Truncate the four instance tables
        CharacterDatabase.Execute("TRUNCATE TABLE character_instance");
        CharacterDatabase.Execute("TRUNCATE TABLE instance");
        CharacterDatabase.Execute("TRUNCATE TABLE instance_reset");
        CharacterDatabase.Execute("TRUNCATE TABLE account_instance_times");

        printf("[ClearRestart] Instance tables truncated by %s. Restarting in 10s...\n",
               who.c_str());

        if (handler)
        {
            handler->SendSysMessage("Instance tables cleared. Server will restart in 10 seconds.");
        }

        // sWorld->ShutdownServ broadcasts the standard "Server is shutting down"
        // message to all online players, so we don't need a separate broadcast.
        sWorld->ShutdownServ(10, 0, SHUTDOWN_MASK_RESTART);

        return true;
    }
};

void Addmod_clear_restartScripts()
{
    new ClearRestartCommand();
}
