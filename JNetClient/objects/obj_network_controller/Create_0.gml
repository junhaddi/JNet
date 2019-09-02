randomize();
show_debug_overlay(true);

net_init();
alarm[0] = 1;

net_cmd_add_handler("connected", handle_connected);
net_cmd_add_handler("disconnected", handle_disconnected);

net_cmd_add_handler("keepAlive", handle_keepalive);

net_cmd_add_handler("getId", handle_getid);
net_cmd_add_handler("newPlayer", handle_newplayer);
net_cmd_add_handler("movePlayer", handle_moveplayer);

