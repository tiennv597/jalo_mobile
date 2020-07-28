import 'package:flutter/material.dart';
import 'chat_tab.dart';
import 'components/favorite_contacts.dart';

class ChatTab extends StatelessWidget {
  final TabController tabController;
  ChatTab({Key key, this.tabController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TabBarView(controller: tabController, children: <Widget>[
      Container(
        child: Flexible(child: Chat()),
      ),
      Column(children: <Widget>[
        SizedBox(
          height: 16.0,
        ),
        Flexible(child: Chat())
      ]),
    ]);
  }
}
