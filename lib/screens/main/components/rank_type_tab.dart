import 'package:flutter/material.dart';
import 'package:shinro_int2/screens/main/components/rank_list.dart';

class RankTypeTab extends StatelessWidget {
  final TabController tabController;

  RankTypeTab({Key key, this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height / 9);
    return TabBarView(controller: tabController, children: <Widget>[
      Column(children: <Widget>[
        SizedBox(
          height: 16.0,
        ),
        Flexible(child: RankList())
      ]),
      Column(children: <Widget>[
        SizedBox(
          height: 16.0,
        ),
        Flexible(child: RankList())
      ]),
      Column(children: <Widget>[
        SizedBox(
          height: 16.0,
        ),
        Flexible(child: RankList())
      ]),
      Column(children: <Widget>[
        SizedBox(
          height: 16.0,
        ),
        Flexible(child: RankList())
      ]),
      Column(children: <Widget>[
        SizedBox(
          height: 16.0,
        ),
        Flexible(child: RankList())
      ]),
    ]);
  }
}
