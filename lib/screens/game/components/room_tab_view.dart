import 'package:flutter/material.dart';
import 'package:shinro_int2/screens/game/components/room_cn_word_list.dart';
import 'package:shinro_int2/screens/game/components/room_vocabulary_list.dart';
import 'package:shinro_int2/screens/game/components/room_grammar_list.dart';
import 'package:socket_io_client/socket_io_client.dart';

class TabView extends StatelessWidget {
  final TabController tabController;
  Socket socket;

  TabView({Key key, this.tabController,this.socket}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
  
    print(MediaQuery.of(context).size.height / 9);
    return TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 16.0,
                ),
                Flexible(child: RoomCnWordList(socket:socket)),
              ],
            ),
          ),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RoomVocabularyList())
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RoomGrammarList())
          ]),
        ]);
  }
}
