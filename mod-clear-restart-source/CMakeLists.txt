set(MOD_NAME "mod-clear-restart")

list(APPEND MODULES_LIST "${MOD_NAME}")

set(MOD_${MOD_NAME}_SOURCES
    "src/mod_clear_restart.cpp"
    "src/mod_clear_restart_loader.cpp"
)

message(STATUS "[${MOD_NAME}] configured")
