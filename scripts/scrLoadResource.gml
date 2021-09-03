global.gmfsDLLPath = "GMFile.dll";
global._FS_directory_exists = external_define(global.gmfsDLLPath, "directory_exists", dll_cdecl, ty_real, 1, ty_string);
global._FS_file_exists = external_define(global.gmfsDLLPath, "file_exists", dll_cdecl, ty_real, 1, ty_string);
global._FS_file_copy = external_define(global.gmfsDLLPath, "file_copy", dll_cdecl, ty_real, 2, ty_string, ty_string);
global._FS_file_delete = external_define(global.gmfsDLLPath, "file_delete", dll_cdecl, ty_real, 1, ty_string);

global._FS_file_text_open_read = external_define(global.gmfsDLLPath, "file_text_open_read", dll_cdecl, ty_real, 1, ty_string);
global._FS_file_text_close = external_define(global.gmfsDLLPath, "file_text_close", dll_cdecl, ty_real, 1, ty_real);
global._FS_file_text_read_string = external_define(global.gmfsDLLPath, "file_text_read_string", dll_cdecl, ty_string, 1, ty_real);
global._FS_file_text_read_real = external_define(global.gmfsDLLPath, "file_text_read_real", dll_cdecl, ty_real, 1, ty_real);

global._FS_file_text_readln = external_define(global.gmfsDLLPath, "file_text_readln", dll_cdecl, ty_real, 1, ty_real);

global.gmIniDLLPath = "GMIni.dll";
global._FS_ini_open = external_define(global.gmIniDLLPath, "ini_open", dll_cdecl, ty_real, 1, ty_string);
global._FS_ini_read_string = external_define(global.gmIniDLLPath, "ini_read_string", dll_cdecl, ty_string, 3, ty_string, ty_string, ty_string);
global._FS_ini_read_real = external_define(global.gmIniDLLPath, "ini_read_real", dll_cdecl, ty_real, 3, ty_string, ty_string, ty_real);
global._FS_ini_close = external_define(global.gmIniDLLPath, "ini_close", dll_cdecl, ty_real, 0);

global.objectIDs[0] = -1;
global.objectIDs[1] = objBlock;
global.objectIDs[2] = objMiniBlock;
global.objectIDs[3] = objSpikeUp;

global.objectIDs[4] = objSpikeRight;
global.objectIDs[5] = objSpikeLeft;
global.objectIDs[6] = objSpikeDown;
global.objectIDs[7] = objMiniUp;

global.objectIDs[8] = objMiniRight;
global.objectIDs[9] = objMiniLeft;
global.objectIDs[10] = objMiniDown;
global.objectIDs[11] = objCherry;

global.objectIDs[12] = objSave;
global.objectIDs[13] = objMovingPlatform;
global.objectIDs[14] = objWater;
global.objectIDs[15] = objWater2;

global.objectIDs[16] = objWalljumpL;
global.objectIDs[17] = objWalljumpR;
global.objectIDs[18] = objKillerBlock;
global.objectIDs[19] = objSaveBlocker;

global.objectIDs[20] = objPlayerStart;
global.objectIDs[21] = objWarp;
global.objectIDs[22] = objJumpRefresher;
global.objectIDs[23] = objWater3;

global.objectIDs[24] = objGravityUp;
global.objectIDs[25] = objGravityDown;
global.objectIDs[26] = objSaveFlip;
global.objectIDs[27] = objMiniKillerBlock;

//global.basePath = "D:/gamemaker-studio/project/jtool-runner.gmx/";
global.basePath = working_directory;

// check resource directory
var resourceDir = global.basePath + "resource";
if (!FS_directory_exists(resourceDir)) {
    show_message("resource目录缺失。");
    game_end();
}

// check data file
var resourcePath = resourceDir + "/";
var dataPath = resourcePath + "data";
if (!FS_file_exists(dataPath)) {
    show_message("resource\data文件缺失。");
    game_end();
}
// check skin directory
var skinDir = resourcePath + "skin";
if (!FS_directory_exists(skinDir)) {
    show_message("resource\skin目录缺失。");
    game_end();
}
// check music directory
var musicDir = resourcePath + "music";
if (!FS_directory_exists(skinDir)) {
    show_message("resource\music目录缺失。");
    game_end();
}

// load title image
var titleImagePath = resourcePath + "title-image.png";
if (FS_file_exists(titleImagePath)) {
    var copiedPath = working_directory + "temp.png";
    FS_file_copy(titleImagePath, copiedPath);
    global.titleSprite = sprite_add(copiedPath, 1, false, false, 0, 0);
    FS_file_delete(copiedPath);
    sprite_set_offset(global.titleSprite, sprite_get_width(global.titleSprite) / 2, sprite_get_height(global.titleSprite) / 2);
} else {
    global.titleSprite = -1;
}

var dataFile = FS_file_text_open_read(dataPath);

// read game name
global.gameName = scrFileReadStringLine(dataFile);

// read title skin & music
var titleSkinIndex = scrFileReadRealLine(dataFile);
var titleMusicIndex = scrFileReadRealLine(dataFile);

// read & load skin
var defaultSkin = ds_map_create();
defaultSkin[? "killerBlend"] = c_white;
defaultSkin[? "saveBlockerAlpha"] = 0.3;
defaultSkin[? "spikeFrames"] = 1;
defaultSkin[? "spikeAnimSpeed"] = 1;
defaultSkin[? "miniSpikeFrames"] = 1;
defaultSkin[? "miniSpikeAnimSpeed"] = 1;
defaultSkin[? "backType"] = "stretch";
defaultSkin[? "backHSpeed"] = 0;
defaultSkin[? "backVSpeed"] = 0;

defaultSkin[? "spikeUpSprite"] = sprSpikeUp;
defaultSkin[? "spikeRightSprite"] = sprSpikeRight;
defaultSkin[? "spikeDownSprite"] = sprSpikeDown;
defaultSkin[? "spikeLeftSprite"] = sprSpikeLeft;

defaultSkin[? "miniSpikeUpSprite"] = sprMiniUp;
defaultSkin[? "miniSpikeRightSprite"] = sprMiniRight;
defaultSkin[? "miniSpikeDownSprite"] = sprMiniDown;
defaultSkin[? "miniSpikeLeftSprite"] = sprMiniLeft;

defaultSkin[? "blockSprite"] = sprBlockMask;
defaultSkin[? "miniBlockSprite"] = sprMiniBlockMask;
defaultSkin[? "platformSprite"] = sprMovingPlatform;
defaultSkin[? "saveSprite"] = sprSave;

defaultSkin[? "appleSprite"] = sprCherry;
defaultSkin[? "water1Sprite"] = sprWater;
defaultSkin[? "water2Sprite"] = sprWater2;
defaultSkin[? "vineLeftSprite"] = sprWalljumpL;

defaultSkin[? "vineRightSprite"] = sprWalljumpR;
defaultSkin[? "killerBlockSprite"] = sprKillerBlock;
defaultSkin[? "saveBlockerSprite"] = sprSaveBlocker;
defaultSkin[? "warpSprite"] = sprWarp;

defaultSkin[? "jumpRefresherSprite"] = sprJumpRefresher;
defaultSkin[? "water3Sprite"] = sprWater3;
defaultSkin[? "playerFallSprite"] = sprPlayerFall;
defaultSkin[? "playerIdleSprite"] = sprPlayerIdle;

defaultSkin[? "playerJumpSprite"] = sprPlayerJump;
defaultSkin[? "playerRunSprite"] = sprPlayerRunning;
defaultSkin[? "playerSlideSprite"] = sprPlayerSliding;
defaultSkin[? "miniKillerBlockSprite"] = sprMiniKillerBlock;

defaultSkin[? "bulletSprite"] = sprBullet;
defaultSkin[? "playerShootSprite"] = sprPlayerIdle;
defaultSkin[? "background"] = -1;

var skinPath = skinDir + "/";
var skins;
var skinNumber = scrFileReadRealLine(dataFile);
for (var i = 0; i != skinNumber; i++) {
    var skinName = scrFileReadStringLine(dataFile);
    var skinNameDir = skinPath + skinName;
    if (!FS_directory_exists(skinNameDir)) {
        show_message(skinName + "皮肤缺失。");
        FS_file_text_close(dataFile);
        game_end();
    }
    
    var skinNamePath = skinNameDir + "/";
    var skinConfigPath = skinNamePath + "skin_config.ini";
    if (!FS_file_exists(skinConfigPath)) {
        show_message(skinName + "的skin_config.ini文件缺失。");
        FS_file_text_close(dataFile);
        game_end();
    }
    
    FS_ini_open(skinConfigPath);
    
    var skinInfo = ds_map_create();
    
    // read config
    var killerBlendString = FS_ini_read_string("objects", "killer_idle_color", "");
    var killerBlend;
    if (killerBlendString == "") {
        killerBlend = c_white;
    } else {
        var killerBlendHSV = string_split(killerBlendString, ",");
        killerBlend = make_color_hsv(real(killerBlendHSV[0]), real(killerBlendHSV[1]), real(killerBlendHSV[2]));
    }
    skinInfo[? "killerBlend"] = killerBlend;
    skinInfo[? "saveBlockerAlpha"] = FS_ini_read_real("objects", "bulletblocker_alpha", 0.3);
    skinInfo[? "spikeFrames"] = FS_ini_read_real("objects", "spike_frames", 1);
    skinInfo[? "spikeAnimSpeed"] = FS_ini_read_real("objects", "spike_animspeed", 1);
    skinInfo[? "miniSpikeFrames"] = FS_ini_read_real("objects", "minispike_frames", 1);
    skinInfo[? "backType"] = FS_ini_read_string("bg", "type", "stretch");
    skinInfo[? "backHSpeed"] = FS_ini_read_real("bg", "hspeed", 0);
    skinInfo[? "backVSpeed"] = FS_ini_read_real("bg", "vspeed", 0);
    
    FS_ini_close();
    
    // load sprite
    skinInfo[? "spikeUpSprite"] = scrLoadSpriteDefault(skinNamePath + "spikeup.png", skinInfo[? "spikeFrames"], 0, 0, false, 0, sprSpikeUp);
    skinInfo[? "spikeRightSprite"] = scrLoadSpriteDefault(skinNamePath + "spikeright.png", skinInfo[? "spikeFrames"], 0, 0, false, 0, sprSpikeRight);
    skinInfo[? "spikeDownSprite"] = scrLoadSpriteDefault(skinNamePath + "spikedown.png", skinInfo[? "spikeFrames"], 0, 0, false, 0, sprSpikeDown);
    skinInfo[? "spikeLeftSprite"] = scrLoadSpriteDefault(skinNamePath + "spikeleft.png", skinInfo[? "spikeFrames"], 0, 0, false, 0, sprSpikeLeft);
    
    skinInfo[? "miniSpikeUpSprite"] = scrLoadSpriteDefault(skinNamePath + "miniup.png", skinInfo[? "miniSpikeFrames"], 0, 0, false, 0, sprMiniUp);
    skinInfo[? "miniSpikeRightSprite"] = scrLoadSpriteDefault(skinNamePath + "miniright.png", skinInfo[? "miniSpikeFrames"], 0, 0, false, 0, sprMiniRight);
    skinInfo[? "miniSpikeDownSprite"] = scrLoadSpriteDefault(skinNamePath + "minidown.png", skinInfo[? "miniSpikeFrames"], 0, 0, false, 0, sprMiniDown);
    skinInfo[? "miniSpikeLeftSprite"] = scrLoadSpriteDefault(skinNamePath + "minileft.png", skinInfo[? "miniSpikeFrames"], 0, 0, false, 0, sprMiniLeft);
    
    skinInfo[? "blockSprite"] = scrLoadSpriteDefault(skinNamePath + "block.png", 1, 0, 0, false, 1, sprBlockMask);
    skinInfo[? "miniBlockSprite"] = scrLoadSpriteDefault(skinNamePath + "miniblock.png", 1, 0, 0, false, 1, sprMiniBlockMask);
    skinInfo[? "platformSprite"] = scrLoadSpriteDefault(skinNamePath + "platform.png", 1, 0, 0, false, 1, sprMovingPlatform);
    skinInfo[? "saveSprite"] = scrLoadSpriteDefault(skinNamePath + "save.png", 2, 0, 0, false, 1, sprSave);
    
    skinInfo[? "appleSprite"] = scrLoadSpriteDefault(skinNamePath + "apple.png", 2, 10, 12, true, 0, sprCherry);
    skinInfo[? "water1Sprite"] = scrLoadSpriteDefault(skinNamePath + "water1.png", 1, 0, 0, false, 1, sprWater);
    skinInfo[? "water2Sprite"] = scrLoadSpriteDefault(skinNamePath + "water2.png", 1, 0, 0, false, 1, sprWater2);
    skinInfo[? "vineLeftSprite"] = scrLoadSpriteDefault(skinNamePath + "walljumpL.png", 1, 0, 0, false, 1, sprWalljumpL);
    
    skinInfo[? "vineRightSprite"] = scrLoadSpriteDefault(skinNamePath + "walljumpR.png", 1, 0, 0, false, 1, sprWalljumpR);
    skinInfo[? "killerBlockSprite"] = scrLoadSpriteDefault(skinNamePath + "killerblock.png", 1, 0, 0, false, 1, sprKillerBlock);
    skinInfo[? "saveBlockerSprite"] = scrLoadSpriteDefault(skinNamePath + "bulletblocker.png", 1, 0, 0, false, 1, sprSaveBlocker);
    skinInfo[? "warpSprite"] = scrLoadSpriteDefault(skinNamePath + "warp.png", 1, 0, 0, false, 0, sprWarp);
    
    skinInfo[? "jumpRefresherSprite"] = scrLoadSpriteDefault(skinNamePath + "jumprefresher.png", 1, 15, 15, false, 0, sprJumpRefresher);
    skinInfo[? "water3Sprite"] = scrLoadSpriteDefault(skinNamePath + "water3.png", 1, 0, 0, false, 1, sprWater3);
    skinInfo[? "playerFallSprite"] = scrLoadSpriteDefault(skinNamePath + "playerfall.png", 2, 17, 23, false, 1, sprPlayerFall);
    skinInfo[? "playerIdleSprite"] = scrLoadSpriteDefault(skinNamePath + "playeridle.png", 4, 17, 23, false, 1, sprPlayerIdle);
    
    skinInfo[? "playerJumpSprite"] = scrLoadSpriteDefault(skinNamePath + "playerjump.png", 2, 17, 23, false, 1, sprPlayerJump);
    skinInfo[? "playerRunSprite"] = scrLoadSpriteDefault(skinNamePath + "playerrunning.png", 4, 17, 23, false, 1, sprPlayerRunning);
    skinInfo[? "playerSlideSprite"] = scrLoadSpriteDefault(skinNamePath + "playersliding.png", 2, 7, 10, false, 1, sprPlayerSliding);
    skinInfo[? "miniKillerBlockSprite"] = scrLoadSpriteDefault(skinNamePath + "minikillerblock.png", 1, 0, 0, false, 1, sprMiniKillerBlock);
    
    skinInfo[? "bulletSprite"] = scrLoadSpriteDefault(skinNamePath + "bullet.png", 2, 1, 1, false, 0, sprBullet);
    skinInfo[? "playerShootSprite"] = scrLoadSpriteDefault(skinNamePath + "playershoot.png", 4, 17, 23, false, 1, sprPlayerIdle);
    var bgPath = skinNamePath + "bg.png";
    if (FS_file_exists(bgPath)) {
        var copiedPath = working_directory + "temp.png";
        FS_file_copy(bgPath, copiedPath);
        skinInfo[? "background"] = background_add(copiedPath, false, false);
        FS_file_delete(copiedPath);
    } else {
        skinInfo[? "background"] = -1;
    }
    
    skins[i] = skinInfo;
}

// read & load music
var musicPath = musicDir + "/";
var musicNumber = scrFileReadRealLine(dataFile);
var musics;
global.copiedMusicPaths = array_create(0);
for (var i = 0; i != musicNumber; i++) {
    var musicName = scrFileReadStringLine(dataFile);
    var musicFilePath = musicPath + musicName;
    if (!FS_file_exists(musicFilePath)) {
        show_message(musicName + "音乐缺失。");
        FS_file_text_close(dataFile);
        game_end();
    }
    
    var copiedPath = working_directory + musicName;
    FS_file_copy(musicFilePath, copiedPath)
    var audioStream = audio_create_stream(copiedPath);
    global.copiedMusicPaths[i] = copiedPath;
    musics[i] = audioStream;
}

// read map
var mapNumber = scrFileReadRealLine(dataFile);
global.maps = array_create(0);
global.roomIDMap = ds_map_create();
for (var i = 0; i != mapNumber; i++) {
    var mapInfo = ds_map_create();
    
    mapInfo[? "enableInfJump"] = scrFileReadRealLine(dataFile);
    mapInfo[? "dotkid"] = scrFileReadRealLine(dataFile);
    mapInfo[? "saveType"] = scrFileReadRealLine(dataFile);
    mapInfo[? "borderType"] = scrFileReadRealLine(dataFile);
    
    // add room resource
    var mapRoom = room_duplicate(rTemplate);
    mapInfo[? "room"] = mapRoom;
    global.roomIDMap[? mapRoom] = i;
    
    // add room object
    var objects = jmap_decode_objects(scrFileReadStringLine(dataFile));
    var objectNumber = array_length_1d(objects);
    for (var j = 0; j != objectNumber; j++) {
        var object = objects[j];
        
        room_instance_add(mapRoom, object[? "x"], object[? "y"], object[? "id"]);
    }
    
    var skinIndex = scrFileReadRealLine(dataFile);
    if (skinIndex >= skinNumber) {
        show_message("号码为" + string(skinIndex) + "的皮肤不存在。");
        FS_file_text_close(dataFile);
        game_end();
    }
    if (skinIndex >= 0) {
        mapInfo[? "skin"] = skins[skinIndex];
    } else {
        mapInfo[? "skin"] = defaultSkin;
    }
    
    var musicIndex = scrFileReadRealLine(dataFile);
    if (musicIndex >= musicNumber) {
        show_message("号码为" + string(musicIndex) + "的音乐不存在。");
        FS_file_text_close(dataFile);
        game_end();
    }
    if (musicIndex >= 0) {
        mapInfo[? "music"] = musics[musicIndex];
    } else {
        mapInfo[? "music"] = -1;
    }
    
    global.maps[i] = mapInfo;
}

if (titleSkinIndex >= 0 && titleSkinIndex < skinNumber) {
    global.titleSkin = skins[titleSkinIndex];
} else {
    global.titleSkin = defaultSkin;
}
if (titleMusicIndex >= 0 && titleMusicIndex < musicNumber) {
    global.titleMusic = musics[titleMusicIndex];
} else {
    global.titleMusic = -1;
}

global.objectIDs = pointer_null;

FS_file_text_close(dataFile);
