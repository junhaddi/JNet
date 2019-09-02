/// @description 서버 연결|유지

var buffer = buffer_create(1, buffer_fixed, 1);
var res = network_send_raw(global.netSocket, buffer, buffer_get_size(buffer));
buffer_delete(buffer);

if (res < 0) {
	// 초기화
	global.isNetConnect = false;		
	global.playerId = -1;
	
	with (obj_chr_dummy) {
		instance_destroy();
	}
	
	// 서버 연결
	show_debug_message("서버 연결... " + string(global.isNetConnect));
	network_destroy(global.netSocket);
	global.netSocket = network_create_socket(network_socket_tcp);
	net_connect(SERVER_IP, SERVER_PORT);
}