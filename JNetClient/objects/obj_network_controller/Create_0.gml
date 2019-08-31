randomize();

net_init(1000, false);
net_connect("127.0.0.1", 3001);

net_cmd_add_handler("connected", handle_connected);
net_cmd_add_handler("getId", handle_getid);
net_cmd_add_handler("newPlayer", handle_newplayer);
net_cmd_add_handler("movePlayer", handle_moveplayer);