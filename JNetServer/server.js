const PORT = 3001;
const Server = require('patchwire').Server;
const ClientManager = require('patchwire').ClientManager;

// 명령어 헨들러
var commandHandlers = {
    isConnected: function(socket, data) {
        // socket.set('x', Math.random() * 800);
        // socket.set('y', Math.random() * 600);
        // socket.send('createPlayer', {
        //     startX: socket.get('x'),
        //     startY: socket.get('y')
        // });
        //console.log(data.message);
        console.log(socket);
        // 서버 접속시 isConnect 레이블 송신
    },
    move: function(socket, data) {
        socket.broadcast('movePlayer', {
            dx: data.x,
            dy: data.y,
        })
    }
};

// 클라이언트 메니저
const clientManager = new ClientManager();
clientManager.addCommandListener('isConnected', commandHandlers.isConnected);
clientManager.addCommandListener('move', commandHandlers.move);
clientManager.broadcast('createPlayer', commandHandlers.isConnected);

// 서버
var server = new Server(function(client) {
    clientManager.addClient(client);
});

server.listen(PORT, function() {
    console.log('Server is running...');
});