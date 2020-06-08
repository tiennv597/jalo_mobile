import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shinro_int2/models/category.dart';
import 'package:shinro_int2/models/message/message.dart';
import 'package:shinro_int2/screens/game/components/message_list_item.dart';
import 'package:shinro_int2/screens/game/components/user_list_modal.dart';
import 'package:shinro_int2/screens/game/game_quiz_page.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:shinro_int2/constant/socket_constant.dart' as SOCKET_CONSTANT;
import 'components/user_item.dart';
import 'package:shinro_int2/models/game/info_room.dart';

class StrartGameScreen extends StatefulWidget {
  InfoRoom infoRoom;

  StrartGameScreen(this.infoRoom);
  @override
  StrartGameScreenState createState() {
    return new StrartGameScreenState();
  }
}

class StrartGameScreenState extends State<StrartGameScreen> {
  //text filde send messga
  final TextEditingController _textEditingController =
      new TextEditingController();
  String nsp = '';
  //on or off button send
  bool _isComposingMessage = false;
  bool _visibilityBtn = false; //Hide button send
  bool _visibility = true; // Hide or show [send icon, ...]
  ScrollController _controller;
  final List<ChatMessage> _messages = <ChatMessage>[];
  //focus TextField message
  FocusNode _focus = new FocusNode();
  UserListModal userListModal = new UserListModal();
  Socket socket;
// data test
  List<Category> categories = [
    Category(
      Color(0xffFCE183),
      Color(0xffF68D7F),
      'Gadgets',
      'assets/image.jpg',
    ),
    Category(
      Color(0xffF749A2),
      Color(0xffFF7375),
      'Clothes',
      'assets/image.jpg',
    ),
    Category(
      Color(0xff00E9DA),
      Color(0xff5189EA),
      'Fashion',
      'assets/image.jpg',
    ),
    Category(
      Color(0xffAF2D68),
      Color(0xff632376),
      'Home',
      'assets/image.jpg',
    ),
    Category(
      Color(0xff36E892),
      Color(0xff33B2B9),
      'Beauty',
      'assets/image.jpg',
    ),
    Category(
      Color(0xffF123C4),
      Color(0xff668CEA),
      'Appliances',
      'assets/image.jpg',
    ),
  ];
  List dataquiz = [
    {
      "1":
          "What Will Be The Output Of the Following Code ?\na = \"p\" * 3\nprint(a)",
      "2": "Which function finds out the Variable type in Python ?",
      "3":
          "Which of the following keyword is used to define a function in Python ?",
      "4": "Which of the following is a print Function in Python ?",
      "5": "Which function finds out the Variable type in Python ?"
    },
    {
      "1": {"a": "pp", "b": "ppp", "c": "3p", "d": "p3"},
      "2": {"a": "typedef", "b": "typeof", "c": "type", "d": "find"},
      "3": {"a": "func", "b": "def", "c": "void", "d": "function"},
      "4": {"a": "cout", "b": "print", "c": "println", "d": "stderr"},
      "5": {"a": "typedef", "b": "typeof", "c": "type", "d": "find"}
    },
    {"1": "ppp", "2": "type", "3": "def", "4": "print", "5": "type"}
  ];
  @override
  void initState() {
    super.initState();

    switch (widget.infoRoom.type) {
      case 'Chinese Word':
        {
          nsp = SOCKET_CONSTANT.china_word_ns;
        }
        break;

      case 'Vocabulary':
        {
          nsp = SOCKET_CONSTANT.vocabulary_ns;
        }
        break;
      case 'Grammar':
        {
          nsp = SOCKET_CONSTANT.grammar_ns;
        }
        break;

      default:
        {}
        break;
    }

    socket = io(SOCKET_CONSTANT.basURL + nsp, <String, dynamic>{
      'transports': ['websocket'],
      'extraHeaders': {'foo': 'bar'} // optional
    });

    socket.emit(SOCKET_CONSTANT.creat_room, {
      widget.infoRoom.type,
      widget.infoRoom.level,
      widget.infoRoom.quantity
    });

    socket.on(SOCKET_CONSTANT.connect, (_) {
      print('connect');
    });

    socket.on(SOCKET_CONSTANT.server_send_message, (data) {
      // Parsing JSON to Jobject
      Message message = Message.fromJson(json.decode(data));
      ChatMessage chatMessage = new ChatMessage(
        text: message.message,
      );
      _focus.addListener(_onFocusChange);
      _controller = ScrollController();
      _controller.addListener(_scrollListener);
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

  void _getdRoom() {
    socket.emit(SOCKET_CONSTANT.creat_room, {widget.infoRoom});
    print("object");
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0), // here the desired height
          child: new AppBar(
            elevation:
                Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
            actions: <Widget>[
              new IconButton(
                  icon: new Icon(Icons.exit_to_app), onPressed: _signOut)
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 0, bottom: 32),
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                // in changelog 1 we will pass the langname name to ther other widget class
                // this name will be used to open a particular JSON file
                // for a particular language
                builder: (context) =>
                    GameQuizPage(socket: socket, mydata: dataquiz),
              ));
            },
            label: Text('Start'),
            icon: Icon(Icons.local_airport),
            backgroundColor: Colors.pink,
          ),
        ),
        body: new Container(
          child: new Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(8.0),
                      height: 30,
                      width: MediaQuery.of(context).size.width / 3,
                      //list user in room
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (_, index) => UserItem(
                                category: categories[index],
                              ))),
                  Container(
                    height: 30,
                    width: 70,
                    //button show list user in room
                    child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(color: Colors.white)),
                        icon: Icon(Icons.account_circle),
                        label: Text("9"),
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
                decoration:
                    new BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildTextComposer(),
              ),
            ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
                  border: new Border(
                      top: new BorderSide(
                  color: Colors.grey[200],
                )))
              : null,
        ));
  }

  CupertinoButton getIOSSendButton() {
    return new CupertinoButton(
      child: new Text("Send"),
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
                            width: 280.0,
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
      height: 128,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Text(
                    'Phòng: 5545 ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Text(
                    'Số câu: ' + widget.infoRoom.quantity,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Text(
                    'Thời gian: ' + widget.infoRoom.time + ' giây/ câu',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.infoRoom.type + ':' + widget.infoRoom.level,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text("Setting"),
                    onPressed: _getdRoom,
                    color: Colors.red,
                    textColor: Colors.yellow,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    splashColor: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _textMessageSubmitted(String value) {
    //send massage
    socket.emit(SOCKET_CONSTANT.client_send_message,
        {"tttt", "tien2", _textEditingController.text});
    //remove focus
    FocusScope.of(context).requestFocus(new FocusNode());

    // clear content
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _textEditingController.clear());
  }

  void _signOut() {}

  // void _startGame() {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (_) => MainPage()));
  // }

  void _showListUser() {
    userListModal.mainBottomSheet(context, categories);
  }
}
