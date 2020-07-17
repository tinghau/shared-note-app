import 'dart:html';

abstract class SNWebSocketCallback {
  void onMessage(Object data);
}

class SNWebSocket {

  SNWebSocketCallback callback;
  final WebSocket webSocket;


  SNWebSocket()
    :  webSocket = WebSocket('ws://localhost:8080/shared/test') {
    initListeners();
  }

  SNWebSocket.withUrl(String url)
    : webSocket = WebSocket(url) {
    initListeners();
  }

  void setCallback(SNWebSocketCallback callback) {
    this.callback = callback;
  }

  send(String data) {
    webSocket.send(data);
  }

  close() => webSocket.close();

  initListeners() {
    webSocket.onOpen.listen((event) {
      print('Socket is open' + event.toString());
    });

    webSocket.onError.listen((event) {
      print('Problems with socket: ' + event.toString());
    });

    webSocket.onClose.listen((event) {
      print('Socket is closed');
    });

    webSocket.onMessage.listen((event) {
      print('Socket received message: ' + event.data);
      if (callback != null) {
        callback.onMessage(event.data);
      }
    });
  }
}