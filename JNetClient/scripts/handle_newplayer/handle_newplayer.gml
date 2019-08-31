/// @desc 새로운 플레이어 정보 받기

var data = argument0;

var obj = instance_create_depth(data[? "x"], data[? "y"], 0, obj_chr_dummy);
obj.playerId = data[? "playerId"];

show_debug_message("새로운 플레이어 접속!!!!!!");