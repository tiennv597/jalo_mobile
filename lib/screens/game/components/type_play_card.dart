import 'package:flutter/material.dart';
import 'package:shinro_int2/models/game/types.dart';

import '../game_room_page.dart';

class TypePlayCard extends StatelessWidget {
  final Types types;

  TypePlayCard(this.types);

  @override
  Widget build(BuildContext context) {
    void _checkType() {
      switch (types.types) {
        case 'Competition':
          {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => GameRoomPage()));
          }
          break;
        case 'Practice':
          {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => GameRoomPage()));
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
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.grey)),
                  icon: Icon(Icons.games),
                  label: Text('Start'),
                  onPressed: _checkType),
            ],
          )
        ],
      ),
    );
  }
}
