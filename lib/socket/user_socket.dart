import 'package:get/get.dart';
import 'package:shinro_int2/models/user/user_model.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:shinro_int2/constant/network_constant.dart' as NETWORK_CONSTANT;

class UserSocket extends GetxController {
  //Socket socket;
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  var count = 0.obs;
  Socket socket;

  onListenSocketEvent(User user) {
    socket = io(
        NETWORK_CONSTANT.basURL + NETWORK_CONSTANT.default_ns,
        <String, dynamic>{
          'transports': ['websocket'],
          'extraHeaders': {'foo': 'bar'} // optional
        });
    socket.on(NETWORK_CONSTANT.connect, (_) {
      print('connect');
      socket.emit('msg', 'test');
    });
  }

  addFriendsEvent() {
    socket.on(NETWORK_CONSTANT.connect, (_) {
      print('add friends');
      socket.emit('msg', 'test');
    });
  }
  // socket.on(NETWORK_CONSTANT.connect, (_) {
  //   print('connect');
  //   socket.emit('msg', 'test');
  // });
}
