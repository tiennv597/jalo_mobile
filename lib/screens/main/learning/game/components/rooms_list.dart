import 'package:flutter/material.dart';
import 'package:shinro_int2/models/game/info_room.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:shinro_int2/constant/app_colors.dart' as COLORS;
import 'package:shinro_int2/models/game/rooms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinro_int2/constant/shared_preferences.dart'
    as SHARED_PREFERNCES;
import 'package:shinro_int2/models/game/info_user.dart';
import 'package:shinro_int2/models/game/info.dart';
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

  void _strartGameScreen(String id, String userId, String fullName, String type,
      String password, String time) {
    InfoRoom infoRoom = InfoRoom();
    User user = new User();
    Info info = new Info();
    user.id = userId;
    user.fullName = fullName;
    infoRoom.users = user;
    info.idRoom = id;
    info.type = type;
    info.time = time;
    info.password = password;
    infoRoom.info = info;
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
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String userId = prefs.getString(SHARED_PREFERNCES.user_id);
                    String fullName =
                        prefs.getString(SHARED_PREFERNCES.fullName);
                    _strartGameScreen(
                        widget.rooms[index].info.idRoom,
                        userId,
                        fullName,
                        widget.rooms[index].info.type,
                        widget.rooms[index].info.password,
                        widget.rooms[index].info.time);
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
                                        widget.rooms[index].info.idRoom,
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.rooms[index].info.type,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.rooms[index].info.level,
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
                                        "1",
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
