/// @desc 네트워크 설정을 초기화힙니다
/// @param 연결시간
/// @param 논블로킹

var timeout = argument0;
var blocking = argument1;

network_set_config(network_config_connect_timeout, timeout);
network_set_config(network_config_use_non_blocking_socket, blocking);

global.netSocket = network_create_socket(network_socket_tcp);
global.netHandlerMap = ds_map_create();						
global.isNetConnect = false;		
global.playerId = -1;

enum NetEvent {
	COMMAND = 0,
    CONNECT = -1,
    DISCONNECT = -2,
    CONNECTFAIL = -3,
    UNKNOW = -4,
}