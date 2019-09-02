/// @desc 네트워크 설정을 초기화힙니다

#macro SERVER_IP "34.97.69.69"
#macro SERVER_PORT 3001
#macro HEART_BEAT 60

network_set_config(network_config_connect_timeout, 4000);
network_set_config(network_config_use_non_blocking_socket, false);

global.netSocket = network_create_socket(network_socket_tcp);
global.netHandlerMap = ds_map_create();
global.isNetConnect = false;		
global.playerId = -1;