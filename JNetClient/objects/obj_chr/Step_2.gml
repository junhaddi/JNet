if (speed != 0) {
	var command = net_cmd_init("movePlayer");
	command[? "playerId"] = global.playerId;
	command[? "x"] = x;
	command[? "y"] = y;
	net_cmd_send(command);
}