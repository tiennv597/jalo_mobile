import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shinro_int2/models/game/info_rooms.dart';
import 'package:shinro_int2/models/message/message.dart';
import 'package:shinro_int2/models/question/questions.dart';
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
  InfoRooms room;
  List<User> users = new List<User>();
  Future<InfoRooms> getFutureInfoRoom() async =>
      await Future.delayed(Duration(seconds: 1), () {
        return room;
      });
  @override
  void initState() {
    super.initState();
    questionList = new Questions();
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
      print(data);
      questionList = Questions.fromJson(data);
      print(questionList);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => GameQuizPage(
              socket: socket,
              idRoom: room.info.idRoom,
              owner: owner,
              infoRoom: widget.infoRoom,
              users: users,
              questionList: questionList,
              userInRoom:userInRoom)));
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
      print(data);
      setState(() {
        room = InfoRooms.fromJson(json.decode(data));
        users = room.allUser;
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
      ChatMessage chatMessage = new ChatMessage(
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
      room.info.idRoom,
      room.info.quantity,
      room.info.type,
      room.info.level,
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
        future: getFutureInfoRoom(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
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
                      Size.fromHeight(40.0), // here the desired height
                  child: new AppBar(
                    iconTheme: IconThemeData(
                      color: Colors.black, //change your color here
                    ),
                    title: Text(
                      "Solo 122",
                      style: TextStyle(color: Colors.black),
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
                            // What you want to do
                          },
                          child: Icon(Icons.group_add),
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
                          Container(
                            height: 30,
                            width: 70,
                            //button show list user in room
                            child: RaisedButton.icon(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(color: Colors.white)),
                                icon: Icon(Icons.account_circle),
                                label: Text(userInRoom.toString()),
                                onPressed: _showListUser),
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
    return new CupertinoButton(
      child: new Text("S"),
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
                  decoration:
                      new InputDecoration.collapsed(hintText: "Send a message"),
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
      height: MediaQuery.of(context).size.width / 3,
      width: MediaQuery.of(context).size.width - 16,
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
                      'Phòng: ' + room.info.idRoom,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: Text(
                      'Số câu: ' + room.info.quantity,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: Text(
                      'Thời gian: ' + room.info.time + ' giây/ câu',
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
                  room.info.type + ': ' + room.info.level,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Setting',
                    style: TextStyle(
                        color: COLORS.tiColor41, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
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

  @override
  void dispose() {
    super.dispose();
    print("close");
    socket.emit(NETWORK_CONSTANT.leave, room.info.idRoom);
  }
}
