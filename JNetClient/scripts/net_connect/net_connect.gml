/// @desc 서버에 연결합니다.
/// @param {string} 서버아이피
/// @param {real} 서버포트

var ip = argument0;
var port = argument1;

var res = network_connect_raw(global.patchwire_netSock, ip, port);

if (res < 0) {
	// 서버 연결 실패
    net_handle_command("connectFailed", "");
	show_message("연결 실패!!!!");
}