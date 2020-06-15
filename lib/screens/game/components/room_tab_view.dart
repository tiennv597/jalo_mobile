import 'package:flutter/material.dart';
import 'package:shinro_int2/screens/game/components/rooms_list.dart';
import 'package:socket_io_client/socket_io_client.dart';

class TabView extends StatelessWidget {
  final TabController tabController;
  final Socket socket;
  final List cw;
  final List vc;
  final List gr;
  TabView({Key key, this.tabController, this.cw, this.vc, this.gr, this.socket})
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
                Flexible(
                    child: RoomsList(
                  rooms: cw,
                  type: "Chinese Word",
                  socket: socket,
                )),
              ],
            ),
          ),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(
                child: RoomsList(
              rooms: cw,
              type: "Vocabulary",
              socket: socket,
            ))
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(
                child: RoomsList(
              rooms: cw,
              type: "Grammar",
              socket: socket,
            ))
          ]),
        ]);
  }
}
