import 'package:flutter/material.dart';

//const String _name = "Pawan";

class ChatMessage extends StatelessWidget {
  final String fulName;
  final String message;
  ChatMessage({this.fulName,this.message});

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(
              child: new Text(fulName[0]),
            ),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(fulName,),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(message),
              )
            ],
          )
        ],
      ),
    );
  }
}