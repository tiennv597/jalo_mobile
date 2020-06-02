import 'package:flutter/material.dart';

class TypePlayCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 200,
      width: 250,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        image: new DecorationImage(
            image: new ExactAssetImage('assets/image.jpg'),
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
            'COMPETITION',
            style: TextStyle(color: Colors.blueAccent),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'GEORGE W BUSH',
                style: TextStyle(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
