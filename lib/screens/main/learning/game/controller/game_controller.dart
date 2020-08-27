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

class GameController extends GetxController {
  Socket socket;
  User inviter;
  User invitee;
  InfoRoom infoRoom;

  // onListenSocketEvent(User user) {
  //   socket = io(basURL + default_ns, <String, dynamic>{
  //     'transports': ['websocket'],
  //     'extraHeaders': {'foo': 'bar'} // optional
  //   });
  //   socket.on(connect, (_) {
  //     print('connect');
  //     //_confirmDialog();
  //     socket.emit(create_socket_private, user.sId);
  //   });
  //   socket.on(add_friends, (_) {
  //     print('ket loi thanh cong');
  //     //  socket.emit('msg', 'test');
  //   });
  //   socket.on(invite_into, (data) {

  //   });
  // }

  addFriendsEvent() {}
}
