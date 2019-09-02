/// @desc 서버에 보낼 명령을 초기화 합니다
/// @param 명령어

var command = argument0;

var netCommandMap = ds_map_create();
ds_map_add(netCommandMap, "command", command);
return netCommandMap;