import 'package:socket_io_client/socket_io_client.dart' as IO;

class _Events {
  static const String connect = 'connect';
  static const String connect_error = 'connect_error';
  static const String connect_timeout = 'connect_timeout';
  static const String connecting = 'connecting';
  static const String disconnect = 'disconnect';
  static const String error = 'error';
  static const String reconnect = 'reconnect';
  static const String reconnect_attempt = 'reconnect_attempt';
  static const String reconnect_failed = 'reconnect_failed';
  static const String reconnect_error = 'reconnect_error';
  static const String reconnecting = 'reconnecting';
  static const String ping = 'ping';
  static const String pong = 'pong';

  //Additton
  static const String createNamespase = 'createNamespase';
  static const String message = 'message';
}

// class SocketProvider {
//   final IO.Socket io;

//   SocketProvider()
//       : io = IO.io('http://192.168.1.28:3000', <String, dynamic>{
//           'transports': ['websocket'],
//           'extraHeaders': {'foo': 'bar'} // optional
//         });
//   connect() {
//     io.on(_Events.connect, (smg) {
//       print('connected');
//       io.emit(_Events.message, 'test');
//     });
//   }
// }
