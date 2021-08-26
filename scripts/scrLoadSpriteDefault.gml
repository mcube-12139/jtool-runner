///scrLoadSpriteDefault(path,imgnumb,xorigin,yorigin,sepmasks,kind,default)
var path = argument0;
var imgnumb = argument1;
var xorigin = argument2;
var yorigin = argument3;
var sepmasks = argument4;
var kind = argument5;
var _default = argument6;

if (FS_file_exists(path)) {
    var copiedPath = working_directory + "temp.png";
    FS_file_copy(path, copiedPath);
    var sprite = sprite_add(copiedPath, imgnumb, false, false, xorigin, yorigin);
    FS_file_delete(copiedPath);
    sprite_collision_mask(sprite, sepmasks, 0, 0, 0, 0, 0, kind, 0);
    return sprite;
}

return _default;
