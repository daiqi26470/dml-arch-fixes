# mod-clear-restart C++20 API fix

The new AzerothCore deprecates `std::vector<ChatCommand>`. Use
`Acore::ChatCommands::ChatCommandTable` + `const` + brace-init:

```cpp
ChatCommandTable GetCommands() const override {
    static ChatCommandTable commandTable = {
        { "clearrestart", HandleClearRestart, SEC_GAMEMASTER, Console::No }
    };
    return commandTable;
}

static bool HandleClearRestart(ChatHandler* handler) { ... }
```

Also: `sWorld->SendServerMessage` is gone; use
`sWorld->ShutdownServ(10, 0, SHUTDOWN_MASK_RESTART)` which broadcasts
the standard "Server shutting down" on its own.
