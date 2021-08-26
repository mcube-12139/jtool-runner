var str = argument0;

var result;
var resultIndex = 0;
var length = string_length(str);
var yy = 0;
for (var i = 1; i <= length; {}) {
    if (string_char_at(str, i) == "-") {
        yy = base32_decode_int(string_copy(str, i + 1, 2));
        i += 3;
    } else {
        var objectID = jmap_id_to_object(base32_decode_int(string_copy(str, i, 1)));
        if (objectID != -1) {
            var xx = base32_decode_int(string_copy(str, i + 1, 2));
            
            var oneObject = ds_map_create();
            oneObject[? "x"] = xx - 128;
            oneObject[? "y"] = yy - 128;
            oneObject[? "id"] = objectID;
            
            result[resultIndex++] = oneObject;
        }
        i += 3;
    }
}

return result;
