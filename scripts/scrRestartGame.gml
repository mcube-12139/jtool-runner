///restarts the game

if (surface_exists(global.pauseSurf))
    surface_free(global.pauseSurf);  //free pause surface in case the game is currently paused

if (global.gameStarted) {
    instance_destroy(objPlayer);
    scrStopMusic();
    
    scrInitializeGlobals();
    scrLoadConfig();
    
    room_goto(rTitle);
}
