import 'package:flutter/material.dart';
import 'package:shinro_int2/models/game/info_room.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../game_start_page.dart';

class RoomsList extends StatefulWidget {
  final List rooms;
  final String type;
  final Socket socket;
  RoomsList({this.rooms, this.type, this.socket});
  @override
  RoomsListState createState() {
    return new RoomsListState();
  }
}

class RoomsListState extends State<RoomsList> {
  void initState() {
    super.initState();
  }

// check info room
  // void _checkInfoRoom() {
  //   // socket.emit(SOCKET_CONSTANT.join_room,
  //   //     {_tfRoomController.text, _tfPasswordController});

  //   widget.socket.emit(SOCKET_CONSTANT.check_info_room, {});

  //   // Navigator.of(context).pushReplacement(
  //   //     MaterialPageRoute(builder: (_) => StrartGameScreen(infoRoom)));
  // }

  void _strartGameScreen(String id) {
    // socket.emit(SOCKET_CONSTANT.join_room,
    //     {_tfRoomController.text, _tfPasswordController});
    InfoRoom infoRoom = InfoRoom(id, '', '', widget.type, '', '');

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => StrartGameScreen(infoRoom)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: Container(
            padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: widget.rooms.length,
              itemBuilder: (BuildContext context, int index) => new ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: InkWell(
                  onTap: () {
                    _strartGameScreen(widget.rooms[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                              colors: [Colors.grey[500], Colors.grey[700]],
                              center: Alignment(0, 0),
                              radius: 0.6,
                              focal: Alignment(0, 0),
                              focalRadius: 0.1),
                        ),
                        child: Text(
                          widget.rooms[index],
                        )),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
