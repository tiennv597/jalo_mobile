import 'package:get/get.dart';
import 'package:shinro_int2/models/user/user_model.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:shinro_int2/constant/network_constant.dart' as NETWORK_CONSTANT;

class UserSocket extends GetxController {
  var count = 0.obs;

  Socket socket;

  onListenSocketEvent() {
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
    socket.on(NETWORK_CONSTANT.add_friends, (_) {
      print('ket loi thanh cong');
      //  socket.emit('msg', 'test');
    });
  }

  addFriendsEvent() {
    print("addfi");
    socket.emit(NETWORK_CONSTANT.add_friends, 'test');
  }
  // socket.on(NETWORK_CONSTANT.connect, (_) {
  //   print('connect');
  //   socket.emit('msg', 'test');
  // });
}
