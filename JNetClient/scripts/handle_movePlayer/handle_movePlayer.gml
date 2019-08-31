/// @desc 플레이어 이동

var data = argument0;

with (obj_chr_dummy) {
	if (playerId == data[? "playerId"]) {
		x = data[? "x"];
		y = data[? "y"];
	}
}