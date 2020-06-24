import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final TabController controller;

  const CustomBottomBar({Key key, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
 

    return BottomAppBar(
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            //SvgPicture
            icon: Icon(Icons.home, size: 32, color: Colors.grey),
            onPressed: () {
              controller.animateTo(0);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.g_translate,
              size: 28,
              color: Colors.grey,
            ),
            onPressed: () {
              controller.animateTo(1);
            },
          ),
          IconButton(
            icon: Icon(Icons.videogame_asset, size: 28, color: Colors.grey),
            onPressed: () {
              controller.animateTo(2);
            },
          ),
          IconButton(
            icon: Icon(Icons.person_pin, size: 28, color: Colors.grey),
            onPressed: () {
              controller.animateTo(3);
            },
          )
        ],
      ),
    );
  }
}
