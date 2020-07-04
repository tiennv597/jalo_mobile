import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shinro_int2/models/game/types.dart';

import '../game_room_page.dart';

class TypePlayCard extends StatelessWidget {
  final Types types;
  final bool logined;

  TypePlayCard(this.types, this.logined);

  @override
  Widget build(BuildContext context) {
    void _checkType() {
      switch (types.types) {
        case 'Competition':
          {
            if (logined == true && logined != null) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => GameRoomPage()));
            } else {
              Fluttertoast.showToast(
                  msg: "You need to login to use!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.redAccent,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
          break;
        case 'Practice':
          {
            if (logined == true && logined != null) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => GameRoomPage()));
            } else {
               Fluttertoast.showToast(
                  msg: "You need to login to use!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
          break;
        default:
          {}
          break;
      }
    }

    return Container(
      height: 200,
      width: 250,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
          color: Colors.deepPurple[700],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            types.types,
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RaisedButton.icon(
                  color: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.deepPurple)),
                  icon: Icon(
                    Icons.games,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Start',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: _checkType),
            ],
          )
        ],
      ),
    );
  }
}
