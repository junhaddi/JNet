/// @desc 명령어를 실행 합니다
/// @param 명령어
/// @param 데이터

var command = argument0;
var dataMap = argument1;

if (ds_map_exists(global.netHandlerMap, command)) {
    var handlerList = ds_map_find_value(global.netHandlerMap, command);
    var handlerListLength = array_length_1d(handlerList);
    
    for (var i = 0; i < handlerListLength; i++) {
        var handler = handlerList[i]
        script_execute(handler, dataMap);
    }
}