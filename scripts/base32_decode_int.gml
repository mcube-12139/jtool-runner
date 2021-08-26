var str = argument0;

var base32String = "0123456789abcdefghijklmnopqrstuv";
var result = 0;
var length = string_length(str);

for (var i = 0; i != length; ++i) {
    var char = string_char_at(str, i + 1);
    var base32Index = string_pos(char, base32String) - 1;
    var placeValue = power(32, length - 1 - i);
    result += base32Index * placeValue;
}

return result;
