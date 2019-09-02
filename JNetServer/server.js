const PORT = 3001;
const ONE_SECOND = 1000;
const TICK_RATE = 60;
const ALIVE_TIMEOUT = 1;
const Server = require("patchwire").Server;
const ClientManager = require("patchwire").ClientManager;
var tickCount = 0;

// 명령어 헨들러
var commandHandlers = {
    connected: (socket, data) => {
        socket.set("playerId", socket.clientId);
        socket.set("isAlive", true);
        socket.set("x", data.x);
        socket.set("y", data.y);

        // 고유 ID 받기
        socket.send("getId", {
            playerId: socket.get("playerId"),
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
                    playerId: socket.get("playerId"),
                    x: data.x,
                    y: data.y,
                });
            }
        });
    },
    clientDropped: (player) => {
        // 플레이어 연결 끊김
        clientManager.broadcast("disconnected", {
            playerId: player.get("playerId"),
        });
        console.log("["+player.get("playerId")+"] Player Disconnect...");
    },
    movePlayer: (socket, data) => {
        socket.set("x", data.x);
        socket.set("y", data.y);

        // 다른 플레이어들에게 위치 전송
        clientManager.broadcast("movePlayer", {
            playerId: socket.get("playerId"),
            x: data.x,
            y: data.y,
        });
    },
    keepAlive: (socket) => {
        socket.set("isAlive", true);
    }
};

// 클라이언트 매니저
const clientManager = new ClientManager();
clientManager.setTickMode(true);
clientManager.setTickRate(ONE_SECOND / TICK_RATE);
clientManager.startTicking();

clientManager.addCommandListener("connected", commandHandlers.connected);
clientManager.addCommandListener("movePlayer", commandHandlers.movePlayer);
clientManager.addCommandListener("keepAlive", commandHandlers.keepAlive);
clientManager.on("clientDropped", commandHandlers.clientDropped);
clientManager.on("tick", () => {
    tickCount++;

    if (tickCount == TICK_RATE * (ALIVE_TIMEOUT / 2)) {
        clientManager.getClients().forEach((player) => {
            player.set("isAlive", false);
        });
        clientManager.broadcast("keepAlive", {});
    }

    // 게임 오버 선언
    if (tickCount == TICK_RATE * ALIVE_TIMEOUT) {
        clientManager.getClients().forEach((player) => {
            if (player.get("isAlive") == false) {
                // 연결 끊김 간주
                clientManager.fire("clientDropped", player);
                clientManager.removeClient(player.get("playerId"));
            }
            else {
                console.log("["+player.get("playerId")+"] ALIVE");
            }
            player.set("isAlive", false);
        });
        console.log("======== USER: " + clientManager.getClientCount());
        tickCount = 0;
    }
});

// 서버
var server = new Server((client) => {
    clientManager.addClient(client);
    console.log("Player Connected!!");
});

server.listen(PORT, () => {
    console.log("Server is running...");
});