import 'dart:convert';
import 'package:shinro_int2/constant/app_properties.dart';
import 'package:shinro_int2/constant/socket_constant.dart' as SOCKET_CONSTANT;
import 'package:shinro_int2/models/game/rooms.dart';
import 'package:shinro_int2/screens/game/game_start_page.dart';
import 'package:shinro_int2/utils/custom_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'components/room_tab_view.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:shinro_int2/models/game/info_room.dart';

class GameRoomPage extends StatefulWidget {
  @override
  _GameRoomPageState createState() => _GameRoomPageState();
}

class _GameRoomPageState extends State<GameRoomPage>
    with TickerProviderStateMixin<GameRoomPage> {
  Socket socket;
  SwiperController swiperController;
  TabController tabController;
  TextEditingController _tfRoomController;
  TextEditingController _tfPasswordController;
  String id = '';
  String password = '';
  String level = 'N5';
  String type = 'Chinese Word';
  String quantity = '10';
  String time = '10';
  List cw = [];
  List vc = [];
  List gr = [];

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    _tfRoomController = new TextEditingController();
    _tfPasswordController = new TextEditingController();
    //Creating the socket
    socket = io(
        SOCKET_CONSTANT.basURL + SOCKET_CONSTANT.default_ns, <String, dynamic>{
      'transports': ['websocket'],
      'extraHeaders': {'foo': 'bar'} // optional
    });
    socket.on(SOCKET_CONSTANT.connect, (_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    socket.on(SOCKET_CONSTANT.result_check_room, (data) {
      print(data);
    });
    socket.on(SOCKET_CONSTANT.server_send_rooms, (data) {
      Rooms rooms = Rooms.fromJson(json.decode(data));
      setState(() {
        //rooms = data;
        cw = rooms.idRoomCw;
        vc = rooms.idRoomVc;
        gr = rooms.idRoomGr;
        print(cw);
      });
    });
    socket.emit(SOCKET_CONSTANT.client_get_rooms);
    socket.connect();
    super.initState();
  }

  void _strartGameScreen() {
    // socket.emit(SOCKET_CONSTANT.join_room,
    //     {_tfRoomController.text, _tfPasswordController});
    // InfoRoom infoRoom =
    //     InfoRoom(id, _tfPasswordController.text, level, type, quantity, time);
    socket.emit(SOCKET_CONSTANT.check_info_room, {
      id,
      password,
    });

    // Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (_) => StrartGameScreen(infoRoom)));
  }

  void _createRoomByName() {
    InfoRoom infoRoom = new InfoRoom(id, password, level, type, quantity, time);
    //socket.emit('join-room', {_tfRoomController.text, "tien2"});
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => StrartGameScreen(infoRoom)));
  }

  void _getRoom() {
    //socket.emit(SOCKET_CONSTANT.client_get_rooms, {});
  }

  Future<String> _showSearchDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Search Room'),
          content: Container(
            height: 120,
            child: new Column(
              children: <Widget>[
                TextField(
                  controller: _tfRoomController,
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Room Name', hintText: 'Enter room name'),
                  onChanged: (value) {},
                ),
                TextField(
                  controller: _tfPasswordController,
                  autofocus: true,
                  decoration: new InputDecoration(
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
            FlatButton(child: Text('Ok'), onPressed: _strartGameScreen),
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
                        items: <String>['Chinese Word', 'Vocabulary', 'Grammar']
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
                Navigator.of(context).pop();
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text("Search"),
                      onPressed: () async {
                        final String currentTeam =
                            await _showSearchDialog(context);
                        print("Current team name is $currentTeam");
                      },
                      color: Colors.red,
                      textColor: Colors.yellow,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      splashColor: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text("Play Now"),
                      onPressed: _getRoom,
                      color: Colors.red,
                      textColor: Colors.yellow,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      splashColor: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text("Create"),
                      onPressed: () async {
                        // final String currentTeam =
                        await _showCreateDialog(context);
                      },
                      color: Colors.red,
                      textColor: Colors.yellow,
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
    Widget tabBar = TabBar(
      tabs: [
        Tab(text: 'Chinese Word'),
        Tab(text: 'Vocabulary'),
        Tab(text: 'Grammar'),
      ],
      labelStyle: TextStyle(fontSize: 24.0),
      unselectedLabelStyle: TextStyle(
        fontSize: 18.0,
      ),
      labelColor: darkGrey,
      unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.5),
      isScrollable: true,
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
          title: Text("Room"),
        ),
      ),
      backgroundColor: Colors.white,
      body: CustomPaint(
        painter: MainBackground(),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  // These are the slivers that show up in the "outer" scroll view.
                  return <Widget>[
                    SliverToBoxAdapter(
                      child: tabBar,
                    ),
                  ];
                },
                body: TabView(
                  tabController: tabController,
                  cw: cw, // list rooms chinese word
                  vc: vc, // list rooms vocabulary
                  gr: gr, // list rooms grammar
                  socket: socket,//sockets
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
}
