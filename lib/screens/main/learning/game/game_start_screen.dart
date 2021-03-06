import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shinro_int2/models/game/info.dart';
import 'package:shinro_int2/models/game/info_rooms.dart';
import 'package:shinro_int2/models/message/message.dart';
import 'package:shinro_int2/models/question/questions.dart';
import 'package:shinro_int2/screens/main/learning/game/components/invite_screen.dart';
import 'package:shinro_int2/screens/main/learning/game/controller/game_controller.dart';
import 'package:shinro_int2/socket/user_socket.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:shinro_int2/constant/network_constant.dart' as NETWORK_CONSTANT;
import 'package:shinro_int2/constant/app_colors.dart' as COLORS;
import 'components/message_list_item.dart';
import 'components/user_item_avata.dart';
import 'package:shinro_int2/models/game/info_user.dart';
import 'package:shinro_int2/models/game/info_room.dart';
import 'components/user_list_modal.dart';
import 'game_quiz_screen.dart';

class StrartGameScreen extends StatefulWidget {
  final InfoRoom infoRoom;
  StrartGameScreen(this.infoRoom);

  @override
  StrartGameScreenState createState() {
    return new StrartGameScreenState();
  }
}

class StrartGameScreenState extends State<StrartGameScreen> {
  final TextEditingController _textEditingController =
      new TextEditingController(); //text filde send messga
  String nsp = ''; // name space
  //String idRoom = ''; //id room current
  bool _isComposingMessage = false; //on or off button send
  bool _visibilityBtn = false; //Hide button send
  bool _visibility = true; // Hide or show [send icon, ...]
  ScrollController _controller;
  final List<ChatMessage> _messages = <ChatMessage>[]; // list messege chat
  FocusNode _focus = new FocusNode(); //focus TextField message
  UserListModal userListModal = new UserListModal(); // list user of room
  Socket socket;
  bool owner = false; // owner off room
  bool ready = false; //check user ready?
  bool allReady = true; //check user ready?
  int userReady = 1; // count user
  int userInRoom = 1; // clients in room
  Questions questionList;
  //InfoRoom room;
  UserSocket userSocket = Get.find();
  InfoRooms room;
  Info info;
  List<UserInfo> users = new List<UserInfo>();
  GameController gameController = Get.find();
  // Future<InfoRooms> getFutureInfoRoom() async =>
  //     Future.delayed(const Duration(seconds: 1), () {
  //       return room;
  //     });
  @override
  void initState() {
    super.initState();
    questionList = new Questions();
    info = new Info();
    info = widget.infoRoom.info;
    //info.idRoom = room.info.idRoom;
    _focus.addListener(_onFocusChange);
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    switch (widget.infoRoom.info.type) {
      case 'Hán tự':
        {
          nsp = NETWORK_CONSTANT.china_word_ns;
        }
        break;

      case 'Từ vựng':
        {
          nsp = NETWORK_CONSTANT.vocabulary_ns;
        }
        break;
      case 'Ngữ pháp':
        {
          nsp = NETWORK_CONSTANT.grammar_ns;
        }
        break;

      default:
        {}
        break;
    }

    socket = io(NETWORK_CONSTANT.basURL + nsp, <String, dynamic>{
      'transports': ['websocket'],
      'extraHeaders': {'foo': 'bar'} // optional
    });
    //judgment create room or join room
    if (widget.infoRoom.info.idRoom == '') {
      socket.emit(NETWORK_CONSTANT.creat_room, {
        widget.infoRoom.users.id,
        widget.infoRoom.users.fullName,
        widget.infoRoom.info.level,
        widget.infoRoom.info.type,
        widget.infoRoom.info.quantity,
        widget.infoRoom.info.time
      });
    } else {
      socket.emit(NETWORK_CONSTANT.join_room, {
        widget.infoRoom.info.idRoom,
        widget.infoRoom.info.password,
        widget.infoRoom.users.id,
        widget.infoRoom.users.fullName
      });
    }

    socket.on(NETWORK_CONSTANT.connect, (_) {
      print('connect');
    });

    socket.on(NETWORK_CONSTANT.start_game, (data) {
      questionList = Questions.fromJson(data);
      widget.infoRoom.info = info;
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => GameQuizPage(
              socket: socket,
              idRoom: room.info.idRoom,
              owner: owner,
              infoRoom: widget.infoRoom,
              users: users,
              questionList: questionList,
              userInRoom: userInRoom)));
    });

    socket.on(NETWORK_CONSTANT.update_room, (data) {
      //Info newinfo = new Info();
      // newinfo = Info.fromJson(data);
      InfoRooms roomAndAllUser = InfoRooms.fromJson(json.decode(data));
      setState(() {
        info = roomAndAllUser.info;
        userSocket.info = info;
      });
    });
    socket.on(NETWORK_CONSTANT.ready, (data) {
      if (data) {
        setState(() {
          userReady++;
        });
      } else {
        setState(() {
          userReady--;
          allReady = false;
        });
      }

      if (userReady == userInRoom) {
        setState(() {
          allReady = true;
        });
      }
    });

    socket.on(NETWORK_CONSTANT.joined_room, (data) {
      InfoRooms roomAndAllUser = InfoRooms.fromJson(json.decode(data));
      setState(() {
        room = roomAndAllUser;
        users = roomAndAllUser.allUser;
        userInRoom++;
        allReady = false;
        userSocket.info = room.info;
        userSocket.roomAndAllUser = roomAndAllUser;
      });
    });

    socket.on(NETWORK_CONSTANT.leave, (data) {
      setState(() {
        userInRoom--;
        if (userReady == userInRoom) {
          allReady = true;
        } else {
          allReady = false;
        }
      });
    });

    socket.on(NETWORK_CONSTANT.server_send_room, (data) {
      setState(() {
        room = InfoRooms.fromJson(json.decode(data));
        users = room.allUser;
        info.idRoom = room.info.idRoom;
        userSocket.info = room.info;
        if (room.info.idOwner == widget.infoRoom.users.id) {
          setState(() {
            owner = true;
          });
        }
      });
    });

    socket.on(NETWORK_CONSTANT.server_send_message, (data) {
      // Parsing JSON to Jobject
      Message message = Message.fromJson(json.decode(data));
      ChatMessage chatMessage = ChatMessage(
        message: message.message,
        fulName: message.name,
      );
      //add message to list
      setState(() {
        _messages.insert(0, chatMessage);
      });
    });
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      //"reach the bottom"
      setState(() {});
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      // "reach the top";
      setState(() {});
    }
  }

  //show or hide when focus text TextField send mesage
  void _onFocusChange() {
    setState(() {
      _visibility = !_visibility;
      _visibilityBtn = !_visibilityBtn;
    });
  }

  void _strart() {
    socket.emit(NETWORK_CONSTANT.start_game, {
      info.idRoom,
      info.quantity,
      info.type,
      info.level,
    });
  }

  void _ready() {
    setState(() {
      ready = !ready;
    });
    socket.emit(NETWORK_CONSTANT.ready, {
      room.info.idRoom,
      ready,
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return FutureBuilder(
        future: gameController.getFutureInfoRoom(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Scaffold(
                backgroundColor: Colors.white,
                appBar: PreferredSize(
                  preferredSize:
                      const Size.fromHeight(40), // here the desired height
                  child: AppBar(
                    iconTheme: const IconThemeData(
                      color: Colors.black, //change your color here
                    ),
                    title: Text(
                      widget.infoRoom.users.fullName,
                      style: const TextStyle(color: Colors.black),
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0,
                    actions: <Widget>[
                      new IconButton(
                          icon: new Icon(Icons.exit_to_app),
                          onPressed: _signOut)
                    ],
                  ),
                ),
                floatingActionButton: Visibility(
                  visible: _visibility,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 112.0,
                        right: 8.0,
                        child: FloatingActionButton(
                          backgroundColor: COLORS.cyan700,
                          heroTag: 'save',
                          onPressed: () {
                            Get.to(InviteScreen());
                          },
                          child: const Icon(Icons.group_add),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 42,
                        right: 8.0,
                        child: owner
                            ? FloatingActionButton(
                                backgroundColor: COLORS.cyan700,
                                heroTag: 'strart',
                                onPressed: allReady ? _strart : null,
                                child: Icon(
                                  Icons.arrow_right,
                                  size: 54,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              )
                            : FloatingActionButton(
                                backgroundColor: COLORS.cyan700,
                                heroTag: 'ready',
                                onPressed: _ready,
                                child: ready
                                    ? Icon(
                                        Icons.cancel,
                                        size: 40,
                                      )
                                    : Icon(
                                        Icons.touch_app,
                                        size: 40,
                                      ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                body: new Container(
                  child: new Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                                margin: EdgeInsets.all(8.0),
                                height: 30,
                                width: MediaQuery.of(context).size.width / 3,
                                //list user in room
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: users.length,
                                    itemBuilder: (_, index) => UserItemAvata(
                                          users: users[index],
                                        ))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              height: 30,
                              width: 70,
                              //button show list user in room
                              child: RaisedButton.icon(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(color: Colors.white)),
                                  icon: Icon(Icons.account_circle),
                                  label: Text(userInRoom.toString()),
                                  onPressed: _showListUser),
                            ),
                          ),
                        ],
                      ),
                      _buildRoomInfo(),
                      Flexible(
                        child: Container(
                          // list message
                          child: ListView.builder(
                            padding: EdgeInsets.all(8.0),
                            reverse: true,
                            itemBuilder: (_, int index) => _messages[index],
                            itemCount: _messages.length,
                          ),
                        ),
                      ),
                      new Divider(height: 1.0),
                      new Container(
                        decoration: new BoxDecoration(
                            color: Theme.of(context).cardColor),
                        child: _buildTextComposer(),
                      ),
                    ],
                  ),
                ));
          }
        });
  }

  CupertinoButton getIOSSendButton() {
    return CupertinoButton(
      child: const Text('S'),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : null,
    );
  }

  IconButton getDefaultSendButton() {
    return new IconButton(
      icon: new Icon(Icons.send),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : null,
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(
          color: _isComposingMessage
              ? Theme.of(context).accentColor
              : Theme.of(context).disabledColor,
        ),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  focusNode: _focus, //detect when a textfield is selected
                  controller: _textEditingController,
                  onChanged: (String messageText) {
                    setState(() {
                      _isComposingMessage = messageText.length > 0;
                    });
                  },
                  onSubmitted: _textMessageSubmitted,
                  decoration: const InputDecoration.collapsed(
                      hintText: 'Send a message'),
                ),
              ),
              _visibilityBtn
                  ? new Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Theme.of(context).platform == TargetPlatform.iOS
                          ? getIOSSendButton()
                          : getDefaultSendButton(),
                    )
                  : Container(),
              _visibility
                  ? Container(
                      margin: new EdgeInsets.symmetric(horizontal: 4.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: new Icon(
                                Icons.sentiment_very_satisfied,
                                color: Theme.of(context).accentColor,
                              ),
                              onPressed: () {}),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.6,
                          )
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ));
  }

  Widget _buildRoomInfo() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [COLORS.cyan300, COLORS.cyan700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
            alignment: Alignment(-1, 0),
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: Text(
                      'Phòng: ' + info.idRoom,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: Text(
                      'Số câu: ' + info.quantity,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: Text(
                      'Thời gian: ' + info.time + ' giây/ câu',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  info.type + ': ' + info.level,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  // final String currentTeam =
                  await _showCreateDialog(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(24))),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Setting',
                      style: TextStyle(
                          color: COLORS.tiColor41, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
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
                        value: info.level,
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
                            info.level = newValue;
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
                        value: info.quantity,
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
                            info.quantity = newValue;
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
                        value: info.time,
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
                            info.time = newValue;
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
                        value: info.type,
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
                            info.type = newValue;
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
                Navigator.of(context).pop();
              },
            ),
            FlatButton(child: Text('Ok'), onPressed: _updateInfoRoom),
          ],
        );
      },
    );
  }

  void _textMessageSubmitted(String value) {
    socket.emit(NETWORK_CONSTANT.client_send_message,
        {room.info.idRoom, widget.infoRoom.users.fullName, value});
    //remove focus
    FocusScope.of(context).requestFocus(new FocusNode());

    // clear content
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _textEditingController.clear());
  }

  void _signOut() {}

  void _showListUser() {
    userListModal.mainBottomSheet(context, users);
  }

  void _updateInfoRoom() {
    socket.emit(NETWORK_CONSTANT.update_room,
        {room.info.idRoom, info.level, info.type, info.quantity, info.time});
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    socket.emit(NETWORK_CONSTANT.leave, {room.info.idRoom, userInRoom});
  }
}
