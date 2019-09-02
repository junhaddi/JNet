randomize();

global.SERVER_IP = "34.97.69.69";
//global.SERVER_IP = "127.0.0.1";
global.SERVER_PORT = 3001;
net_init(4000, false);

net_connect(global.SERVER_IP, global.SERVER_PORT);

net_cmd_add_handler("connected", handle_connected);
net_cmd_add_handler("disconnected", handle_disconnected);
net_cmd_add_handler("getId", handle_getid);
net_cmd_add_handler("newPlayer", handle_newplayer);
net_cmd_add_handler("movePlayer", handle_moveplayer);