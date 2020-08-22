import 'package:flutter/material.dart';
import 'package:shinro_int2/screens/main/profile/settings/suggestions_tab.dart';

class FriendsTabView extends StatelessWidget {
  final TabController tabController;

  FriendsTabView({Key key, this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(controller: tabController, children: <Widget>[
      Column(children: <Widget>[
        SizedBox(
          height: 16.0,
        ),
        Flexible(child: SuggestionsScreen())
      ]),
      Flexible(child: SuggestionsScreen())
    ]);
  }
}
