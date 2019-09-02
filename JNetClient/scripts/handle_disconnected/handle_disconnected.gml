/// @desc 접속중인 플레이어 연결 끊김

var data = argument0;

with (obj_chr_dummy) {
	if (playerId == data[? "playerId"]) {
		instance_destroy();
	}
}