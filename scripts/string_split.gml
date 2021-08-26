///string_split(str,sepChar)
var str = argument0;
var sepChar = argument1;

var result;
var resultIndex = 0;
var length = string_length(str);

var lastIndex = 1;
for (var i = 1; true; ++i) {
    var char;
    if (i != length + 1) {
        char = string_char_at(str, i);
    }
    if (i == length + 1 || char == sepChar) {
        result[resultIndex++] = string_copy(str, lastIndex, i - lastIndex);
        lastIndex = i + 1;
    }
    if (i == length + 1) {
        break;
    }
}

return result;
