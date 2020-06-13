import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shinro_int2/constant/app_properties.dart';
import 'package:shinro_int2/constant/socket_constant.dart' as SOCKET_CONSTANT;
import 'package:flutter/material.dart';
import 'package:shinro_int2/screens/product/product_page.dart';
import 'package:socket_io_client/socket_io_client.dart';

class RoomCnWordList extends StatefulWidget {
  List cw;
  RoomCnWordList({this.cw});
  @override
  RoomCnWordListState createState() {
    return new RoomCnWordListState();
  }
}

class RoomCnWordListState extends State<RoomCnWordList> {
  //List<dynamic> rooms = [];
  void initState() {
    super.initState();

    // widget.socket.emit(SOCKET_CONSTANT.client_get_rooms, 'cw');
    // widget.socket.on(SOCKET_CONSTANT.server_send_rooms, (data) {
    //   setState(() {
    //     //rooms = data;
    //     print(data);
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IntrinsicHeight(
                child: Container(
                  margin: const EdgeInsets.only(left: 16.0, right: 8.0),
                  width: 4,
                  color: mediumYellow,
                ),
              ),
              Center(
                  child: Text(
                'Chinese Word',
                style: TextStyle(
                    color: darkGrey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: widget.cw.length,
              itemBuilder: (BuildContext context, int index) => new ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                              colors: [Colors.grey[500], Colors.grey[700]],
                              center: Alignment(0, 0),
                              radius: 0.6,
                              focal: Alignment(0, 0),
                              focalRadius: 0.1),
                        ),
                        child: Text(
                          widget.cw[index],
                        )),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
