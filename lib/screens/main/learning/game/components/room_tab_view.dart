import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:shinro_int2/models/game/rooms.dart';

import 'rooms_list.dart';

class TabView extends StatelessWidget {
  final TabController tabController;
  final Socket socket;
  final List<RoomsCw> cw;
  final List<RoomsCw> vc;
  final List<RoomsCw> gr;
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
