import 'package:flutter/material.dart';
import 'package:shinro_int2/models/game/info_room.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:shinro_int2/constant/app_colors.dart' as COLORS;
import 'package:shinro_int2/models/game/rooms.dart';
import '../game_start_screen.dart';

class RoomsList extends StatefulWidget {
  final List<RoomsCw> rooms;
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
    InfoRoom infoRoom = InfoRoom();
    infoRoom.idRoom = id;
    infoRoom.type = widget.type;
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => StrartGameScreen(infoRoom)));
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
                    _strartGameScreen(widget.rooms[0].idRoom);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 54,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                COLORS.cyan700,
                                COLORS.cyan700,
                              ]),
                        ),
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width / 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                      backgroundColor: COLORS.tiColor52,
                                      child: Text(
                                        widget.rooms[0].nameNoom,
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Solo 1222",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "N5",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 6,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.account_circle,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "15",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
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
