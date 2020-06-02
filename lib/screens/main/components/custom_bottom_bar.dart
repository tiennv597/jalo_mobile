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
            icon: Image.asset(
                    'assets/icons/icon_home.png',
                    fit: BoxFit.fitWidth,
                    ),
            onPressed: () {
              controller.animateTo(0);
            },
          ),
          IconButton(
            icon: Image.asset('assets/icons/icon_grammar.png'),
            onPressed: () {
              controller.animateTo(1);
            },
          ),
          IconButton(
            icon: Image.asset('assets/icons/icon_play_game.png'),
            onPressed: () {
              controller.animateTo(2);
            },
          ),
          IconButton(
            icon: Image.asset('assets/icons/icon_info.png'),
            onPressed: () {
              controller.animateTo(3);
            },
          )
        ],
      ),
    );
  }
}
