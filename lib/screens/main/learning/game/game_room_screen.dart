import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinro_int2/constant/app_colors.dart' as COLORS;
import 'package:shinro_int2/constant/network_constant.dart' as NETWORK_CONSTANT;
import 'package:shinro_int2/screens/main/learning/game/controller/game_controller.dart';
import 'package:shinro_int2/socket/user_socket.dart';
import 'package:shinro_int2/utils/custom_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'components/room_tab_view.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:shinro_int2/models/game/info_room.dart';
import 'package:shinro_int2/models/game/rooms.dart';
import 'package:shinro_int2/models/game/info_user.dart';
import 'package:shinro_int2/models/game/info.dart';
import 'package:shinro_int2/constant/shared_preferences.dart'
    as SHARED_PREFERNCES;

import 'game_start_screen.dart';

class GameRoomPage extends StatefulWidget {
  @override
  _GameRoomPageState createState() => _GameRoomPageState();
}

class _GameRoomPageState extends State<GameRoomPage>
    with TickerProviderStateMixin<GameRoomPage> {
  UserSocket userSocket = Get.find();
  SwiperController swiperController;
  TabController tabController;
  TextEditingController _tfRoomController;
  TextEditingController _tfPasswordController;
  String id = '';
  String password = '';
  String level = 'N5';
  String type = 'Hán tự';
  String quantity = '10';
  String time = '5';
  // List cw = [];
  // List vc = [];
  // List gr = [];
  GameController gameController = Get.put(GameController());
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    tabController = TabController(length: 1, vsync: this);
    _tfRoomController = TextEditingController();
    _tfPasswordController = TextEditingController();
    //Creating the socket

    userSocket.socket.on(NETWORK_CONSTANT.connect, (_) {
      print('connect');
      userSocket.socket.emit('msg', 'test');
    });
    userSocket.socket.on(NETWORK_CONSTANT.result_check_room, (data) {
      print(data);
    });
    userSocket.socket.on(NETWORK_CONSTANT.server_send_rooms, (data) {
      setState(() {
        gameController.rooms = ListRooms.fromJson(json.decode(data));
      });
    });
    userSocket.socket.emit(NETWORK_CONSTANT.client_get_rooms);
    //userSocket.socket.connect();
    super.initState();
  }

  void _strartGameScreen() {
    userSocket.socket.emit(NETWORK_CONSTANT.check_info_room, {
      id,
      password,
    });
  }

  Future<void> _createRoomByName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString(SHARED_PREFERNCES.user_id);
    String fullName = prefs.getString(SHARED_PREFERNCES.fullName);
    InfoRoom infoRoom = new InfoRoom();
    UserInfo user = new UserInfo();
    Info info = new Info();
    user.id = userId;
    user.fullName = fullName;
    info.idRoom = '';
    info.level = level;
    info.type = type;
    info.quantity = quantity;
    info.time = time;
    infoRoom.users = user;
    infoRoom.info = info;
    gameController.infoRoom = infoRoom;
    Get.back();
    Get.to(StrartGameScreen(infoRoom));
  }

  void _getRoom() {
    //socket.emit(NETWORK_CONSTANT.client_get_rooms, {});
  }

  Future<String> _showSearchDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Search Room'),
          content: Container(
            height: 120,
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _tfRoomController,
                  autofocus: true,
                  decoration: const InputDecoration(
                      labelText: 'Room Name', hintText: 'Enter room name'),
                  onChanged: (value) {},
                ),
                TextField(
                  controller: _tfPasswordController,
                  autofocus: true,
                  decoration: const InputDecoration(
                      labelText: 'Password', hintText: 'Enter password'),
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Get.back();
                  _strartGameScreen();
                }),
          ],
        );
      },
    );
  }

  //dialog creatr room
  Future<String> _showCreateDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create Room'),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 300,
              width: 300,
              child: new Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 120,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, right: 32),
                          child: Text("Level : "),
                        ),
                      ),
                      DropdownButton<String>(
                        dropdownColor: Colors.white,
                        value: level,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 16,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 1,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            level = newValue;
                          });
                        },
                        items: <String>['N5', 'N4', 'N3', 'N2', 'N1']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 120,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text("Quantity : "),
                        ),
                      ),
                      DropdownButton<String>(
                        dropdownColor: Colors.white,
                        value: quantity,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 16,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 1,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            quantity = newValue;
                          });
                        },
                        items: <String>['5', '10', '15', '20', '25']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 120,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, right: 32),
                          child: Text("Time : "),
                        ),
                      ),
                      DropdownButton<String>(
                        dropdownColor: Colors.white,
                        value: time,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 16,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 1,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            time = newValue;
                          });
                        },
                        items: <String>['5', '10', '15', '20', '25']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 120,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, right: 32),
                          child: Text("Type : "),
                        ),
                      ),
                      DropdownButton<String>(
                        dropdownColor: Colors.white,
                        value: type,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 16,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 1,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            type = newValue;
                          });
                        },
                        items: <String>['Hán tự', 'Từ vựng', 'Ngữ pháp']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Get.back();
              },
            ),
            FlatButton(child: Text('Ok'), onPressed: _createRoomByName),
          ],
        );
      },
    );
  }

  Widget _buildButtonFL() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Row(
                children: <Widget>[
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: RaisedButton(
                  //     child: Text("Search"),
                  //     onPressed: () async {
                  //       final String currentTeam =
                  //           await _showSearchDialog(context);
                  //       print("Current team name is $currentTeam");
                  //     },
                  //     color: COLORS.tiColor52,
                  //     textColor: Colors.white,
                  //     padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  //     splashColor: Colors.grey,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: RaisedButton(
                  //     child: Text("Play Now"),
                  //     onPressed: _getRoom,
                  //     color: COLORS.tiColor52,
                  //     textColor: Colors.white,
                  //     padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  //     splashColor: Colors.grey,
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: RaisedButton(
                      child: Text("Create"),
                      onPressed: () async {
                        // final String currentTeam =
                        await _showCreateDialog(context);
                      },
                      color: COLORS.tiColor52,
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      splashColor: Colors.grey,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    Widget tabBar = TabBar(
      isScrollable: true,
      unselectedLabelColor: Colors.grey,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Colors.black,
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      tabs: <Widget>[
        Tab(
          child: Container(
            height: 32,
            child: Align(
              alignment: Alignment.center,
              child: Text("Chọn Phòng"),
            ),
          ),
        ),
        // Tab(
        //   child: Container(
        //     height: 32,
        //     child: Align(
        //       alignment: Alignment.center,
        //       child: Text("Từ vựng"),
        //     ),
        //   ),
        // ),
        // Tab(
        //   child: Container(
        //     height: 32,
        //     child: Align(
        //       alignment: Alignment.center,
        //       child: Text("Ngữ pháp"),
        //     ),
        //   ),
        // ),
      ],
      controller: tabController,
    );
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0), // here the desired height
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Room",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: CustomPaint(
        painter: MainBackground(),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              DefaultTabController(
                length: 1,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(-20),
                      child: Align(
                        child: Container(
                          height: 32,
                          child: tabBar,
                        ),
                      ),
                    ),
                  ),
                  body: FutureBuilder(
                      future: gameController.getFutureRooms(),
                      builder: (context, snapshot) {
                        // InfoRoom room = new InfoRoom();
                        // room=snapshot.data;
                        //print(room);
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Container(
                            height: screenHeight * 75 / 100,
                            child: TabView(
                              tabController: tabController,
                              cw: gameController
                                  .rooms.roomsCw, // list rooms chinese word
                              vc: gameController
                                  .rooms.roomsCw, // list rooms vocabulary
                              gr: gameController
                                  .rooms.roomsCw, // list rooms grammar
                              socket: userSocket.socket, //sockets
                            ),
                          );
                        }
                      }),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              _buildButtonFL(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}
