import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shinro_int2/models/message/message.dart';
import 'package:shinro_int2/screens/game/components/message_list_item.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:shinro_int2/constant/socket_constant.dart' as SOCKET_CONSTANT;

class StrartGameScreen extends StatefulWidget {
  final Socket socket;

  StrartGameScreen({this.socket});
  @override
  StrartGameScreenState createState() {
    return new StrartGameScreenState();
  }
}

class StrartGameScreenState extends State<StrartGameScreen> {
  final TextEditingController _textEditingController =
      new TextEditingController();
  bool _isComposingMessage = false;
  bool _visibilityBtn = false; //Hide button send
  bool _visibility = true; // Hide or show [send icon, ...]
  ScrollController _controller;
  final List<ChatMessage> _messages = <ChatMessage>[];

  FocusNode _focus = new FocusNode();
  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    widget.socket.on(SOCKET_CONSTANT.server_send_message, (data) {
      //Map messageMap = jsonDecode(data);
      Message message = Message.fromJson(json.decode(data));
      // Map<String, dynamic> map = json.decode(data);
      // List<dynamic> message = map["message"];
      // print(message[0]["name"]);
      ChatMessage chatMessage = new ChatMessage(
        text: message.message,
      );
      setState(() {
        _messages.insert(0, chatMessage);
      });
      print(message.message);
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

  void _onFocusChange() {
    setState(() {
      _visibility = !_visibility;
      _visibilityBtn = !_visibilityBtn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          title: new Text("Phòng 123"),
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.exit_to_app), onPressed: _signOut)
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 0, bottom: 32),
          child: FloatingActionButton.extended(
            onPressed: () {
              // Add your onPressed code here!
            },
            label: Text('Start'),
            icon: Icon(Icons.local_airport),
            backgroundColor: Colors.pink,
          ),
        ),
        body: new Container(
          child: new Column(
            children: <Widget>[
              new Flexible(
                child: Container(
                  decoration:
                      new BoxDecoration(color: Theme.of(context).cursorColor),
                  child: new ListView.builder(
                    padding: new EdgeInsets.all(8.0),
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

  void _textMessageSubmitted(String value) {
    //send massage
    widget.socket.emit(SOCKET_CONSTANT.client_send_message,
        {"tttt", "tien2", _textEditingController.text});
    //remove focus
    FocusScope.of(context).requestFocus(new FocusNode());

    // clear content
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _textEditingController.clear());
  }

  void _signOut() {}
}

// class ChatMessage extends StatelessWidget {
//   ChatMessage({this.text, this.animationController}); //modified
//   final String text;
//   final AnimationController animationController;
//   @override
//   Widget build(BuildContext context) {
//     return new SizeTransition(
//       sizeFactor: new CurvedAnimation(
//           parent: animationController, curve: Curves.easeOut),
//       axisAlignment: 0.0,
//       child: new Container(
//         margin: const EdgeInsets.symmetric(vertical: 10.0),
//         child: new Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             new Container(
//               margin: const EdgeInsets.only(right: 16.0),
//               child: new CircleAvatar(child: new Text(_name[0])),
//             ),
//             new Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 new Text(_name, style: Theme.of(context).textTheme.bodyText1),
//                 new Container(
//                   margin: const EdgeInsets.only(top: 5.0),
//                   child: new Text(text),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
