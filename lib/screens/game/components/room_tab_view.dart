import 'package:flutter/material.dart';
import 'package:shinro_int2/screens/game/components/rooms_list.dart';

class TabView extends StatelessWidget {
  final TabController tabController;
  List cw;
  List vc;
  List gr;
  TabView({Key key, this.tabController, this.cw, this.vc, this.gr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height / 9);
    return TabBarView(
        //physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 16.0,
                ),
                Flexible(child: RoomsList(cw: cw)),
              ],
            ),
          ),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RoomsList(cw: cw))
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RoomsList(cw: cw))
          ]),
        ]);
  }
}
