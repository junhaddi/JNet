/// @desc 새로운 명령어를 만들거나, 기존 명령어에 다른 핸들러(스크립트)를 추가합니다
/// @param 명령어
/// @param 핸들러스크립트
/// Note: 이 스크립트를 여러 번 호출하여 주어진 명령어에 여러 개의 핸들러를 추가 할 수 있습니다

var command = argument0;
var handler = argument1;

if (ds_map_exists(global.netHandlerMap, command)) {
    var handlerList = ds_map_find_value(global.netHandlerMap, command);
    handlerList[array_length_1d(handlerList)] = handler;
    ds_map_replace(global.netHandlerMap, command, handlerList);
}
else {
    var handlerList;
    handlerList[0] = handler;
    ds_map_add(global.netHandlerMap, command, handlerList);
}