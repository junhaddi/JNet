/// @desc 서버에 정보 등록요청

global.isNetConnect = true;

var command = net_cmd_init("connected");
command[? "x"] = obj_chr.x;
command[? "y"] = obj_chr.y;
net_cmd_send(command);

show_debug_message("서버 연결 성공!!!!!!");