import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinro_int2/models/game/info.dart';
import 'package:shinro_int2/models/game/info_room.dart';
import 'package:shinro_int2/models/game/info_rooms.dart';
import 'package:shinro_int2/models/game/info_user.dart';
import 'package:shinro_int2/models/user/user_model.dart';
import 'package:shinro_int2/screens/main/learning/game/game_start_screen.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:shinro_int2/constant/constant.dart';

class UserSocket extends GetxController {
  Socket socket;
  User inviter;
  User invitee;
  // InfoRoom infoRoom;
  InfoRooms roomAndAllUser;
  Info info;

  onListenSocketEvent(User user) {
    socket = io(basURL + default_ns, <String, dynamic>{
      'transports': ['websocket'],
      'extraHeaders': {'foo': 'bar'} // optional
    });
    socket.on(connect, (_) {
      print('connect');
      //_confirmDialog();
      socket.emit(create_socket_private, user.sId);
    });
    socket.on(add_friends, (_) {
      print('ket loi thanh cong');
      //  socket.emit('msg', 'test');
    });
    socket.on(invite_into, (data) {
      User inviter = new User();
      User invitee = new User();
      Info info = new Info();
      inviter = User.fromJson(data[0]);
      invitee = User.fromJson(data[1]);
      info = Info.fromJson(data[2]);
      print(data);
      _confirmDialog(inviter, invitee, info);
      //  socket.emit('msg', 'test');
    });
  }

  addFriendsEvent() {
    print("addfi");
    socket.emit(add_friends, 'test');
  }

  inviteInto(User inviter, User invitee) {
    socket
        .emit(invite_into, {inviter.toJson(), invitee.toJson(), info.toJson()});
  }

  // socket.on(NETWORK_CONSTANT.connect, (_) {
  //   print('connect');
  //   socket.emit('msg', 'test');
  // });
  Future<void> _confirmDialog(User inviter, User invitee, Info info) async {
    InfoRoom infoRoom = new InfoRoom();
    UserInfo userInfo = new UserInfo();
    userInfo.id = invitee.sId;
    userInfo.fullName = invitee.firstName + " " + invitee.lastName;
    infoRoom.info = info;
    infoRoom.users = userInfo;
    return showDialog<void>(
      context: Get.context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          title: const Text('Lời mời vào phòng'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Bạn nhận đười lời mời chơi game từ ${inviter.firstName} ${inviter.lastName}'),
                Text('Thể loại: ${info.type}, Cấp độ: ${info.level}'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Chấp nhận'),
              onPressed: () {
                //Navigator.of(context).pop();
                Get.to(StrartGameScreen(infoRoom));
              },
            ),
          ],
        );
      },
    );
  }
}
