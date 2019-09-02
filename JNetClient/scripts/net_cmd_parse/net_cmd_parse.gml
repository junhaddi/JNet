/// @desc 서버에서 보낸 데이터를 반환하고, 서버와의 연결을 관리합니다

var netResponseType = ds_map_find_value(async_load, "type");

switch (netResponseType) {
    case network_type_data:
        var netResponseBuffer = ds_map_find_value(async_load, "buffer");
        var netResponseData = buffer_read(netResponseBuffer, buffer_string);
        buffer_seek(netResponseBuffer, buffer_seek_start, 0);
        var netResponseMap = json_decode(netResponseData);
        buffer_delete(netResponseBuffer);
        return netResponseMap;
		
    case network_type_connect:
    case network_type_non_blocking_connect:
        global.isNetConnect = async_load[? "succeeded"];
    
        if (async_load[? "succeeded"]) {
            return NetEvent.CONNECT;
        }
		show_message_async("NETWORK 부분 연결실패");
        return NetEvent.CONNECTFAIL;
		
    case network_type_disconnect:
        global.isNetConnect = false;
        return NetEvent.DISCONNECT;
		
    default:
        return NetEvent.UNKNOW;   
}