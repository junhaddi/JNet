var data = argument0;
var startX = data[? "startX"];
var startY = data[? "startY"];

instance_create_depth(startX, startY, 0, obj_chr_dummy);
show_debug_message("handle_createPlayer");