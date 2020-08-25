import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinro_int2/models/user/user_model.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:shinro_int2/constant/constant.dart';

class UserSocket extends GetxController {
  Socket socket;

  onListenSocketEvent(User user) {
    socket = io(basURL + default_ns, <String, dynamic>{
      'transports': ['websocket'],
      'extraHeaders': {'foo': 'bar'} // optional
    });
    socket.on(connect, (_) {
      print('connect');
      _confirmDialog();
      socket.emit(create_socket_private, user.sId);
    });
    socket.on(add_friends, (_) {
      print('ket loi thanh cong');
      //  socket.emit('msg', 'test');
    });
  }

  addFriendsEvent() {
    print("addfi");
    socket.emit(add_friends, 'test');
  }

  // socket.on(NETWORK_CONSTANT.connect, (_) {
  //   print('connect');
  //   socket.emit('msg', 'test');
  // });
  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: Get.context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
