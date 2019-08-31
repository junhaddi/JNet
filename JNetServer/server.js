const PORT = 3001;
const Server = require("patchwire").Server;
const ClientManager = require("patchwire").ClientManager;

// 명령어 헨들러
var commandHandlers = {
    isConnected: function(socket, data) {
        var playerId = Date.now().toString();
        socket.set("playerId", playerId);
        socket.set("x", data.x);
        socket.set("y", data.y);

        // 고유 ID 받기
        socket.send("getId", {
            playerId: playerId,
        });

        // 접속중인 플레이어 정보 받기
        clientManager.getClients().forEach((player) => {
            if (socket.get("playerId") != player.get("playerId")) {
                socket.send("newPlayer", {
                    playerId: player.get("playerId"),
                    x: player.get("x"),
                    y: player.get("y"),
                });
            }
        });

        // 다른 플레이어들에게 정보 전송
        clientManager.getClients().forEach((player) => {
            if (socket.get("playerId") != player.get("playerId")) {
                player.send("newPlayer", {
                    playerId: playerId,
                    x: data.x,
                    y: data.y,
                });
            }
        });
    },
    movePlayer: function(socket, data) {
        socket.set("x", data.x);
        socket.set("y", data.y);

        // 다른 플레이어들에게 위치 전송
        clientManager.broadcast("movePlayer", {
            playerId: socket.get("playerId"),
            x: data.x,
            y: data.y,
        });
    },
};

// 클라이언트 매니저
const clientManager = new ClientManager();
clientManager.setTickMode(true);
clientManager.setTickRate(1000 / 60);
clientManager.startTicking();

clientManager.addCommandListener("isConnected", commandHandlers.isConnected);
clientManager.addCommandListener("movePlayer", commandHandlers.movePlayer);

// 서버
var server = new Server(function(client) {
    clientManager.addClient(client);
    console.log("Player connected!!");
});

server.listen(PORT, function() {
    console.log("Server is running...");
});