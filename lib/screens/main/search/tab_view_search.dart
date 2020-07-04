import 'package:flutter/material.dart';

import 'grammar/example_screen.dart';


class TabSearchView extends StatelessWidget {
  final TabController tabController;

  TabSearchView({Key key, this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
        //physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: <Widget>[
          Column(children: <Widget>[Flexible(child: ExamplePage())]),
        ]);
  }
}
