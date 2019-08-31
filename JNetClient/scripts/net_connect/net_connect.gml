/// @desc 서버에 연결합니다
/// @param 서버아이피
/// @param 서버포트

var ip = argument0;
var port = argument1;

var res = network_connect_raw(global.netSocket, ip, port);

if (res < 0) {
	// 서버 연결 실패
    net_connectFailed();
}