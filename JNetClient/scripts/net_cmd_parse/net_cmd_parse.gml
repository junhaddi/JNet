/// @desc 서버에서 보낸 데이터를 반환합니다

var netResponseType = ds_map_find_value(async_load, "type");

switch (netResponseType) {
    case network_type_data:
        var netResponseBuffer = ds_map_find_value(async_load, "buffer");
        var netResponseData = buffer_read(netResponseBuffer, buffer_string);
        buffer_seek(netResponseBuffer, buffer_seek_start, 0);
        var netResponseMap = json_decode(netResponseData);
        buffer_delete(netResponseBuffer);
        return netResponseMap;
}