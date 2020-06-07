import 'package:shinro_int2/constant/app_properties.dart';
import 'package:shinro_int2/constant/socket_constant.dart' as SOCKET_CONSTANT;
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class RoomGrammarList extends StatefulWidget {
  Socket socket;

  RoomGrammarList({this.socket});
  @override
  RoomGrammarListState createState() {
    return new RoomGrammarListState();
  }
}

class RoomGrammarListState extends State<RoomGrammarList> {
  void initState() {
    super.initState();

    widget.socket.emit(SOCKET_CONSTANT.client_get_rooms, {});
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
        //     Flexible(
        //       child: Container(
        //         padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
        //         child: StaggeredGridView.countBuilder(
        // physics: NeverScrollableScrollPhysics(),
        //           padding: EdgeInsets.zero,
        //           crossAxisCount: 4,
        //           itemCount: products.length,
        //           itemBuilder: (BuildContext context, int index) => new ClipRRect(
        //                 borderRadius: BorderRadius.all(Radius.circular(5.0)),
        //                 child: InkWell(
        //                   onTap: () => Navigator.of(context).push(
        //                       MaterialPageRoute(builder: (_) => ProductPage(product:products[index]))),
        //                   child: Container(
        //                       decoration: BoxDecoration(
        //                         gradient: RadialGradient(
        //                             colors: [Colors.grey[500], Colors.grey[700]],
        //                             center: Alignment(0, 0),
        //                             radius: 0.6,
        //                             focal: Alignment(0, 0),
        //                             focalRadius: 0.1),
        //                       ),
        //                       // child: Hero(
        //                       //     tag: products[index].image,
        //                       //     child: Image.asset(products[index].image))
        //                           ),
        //                 ),
        //               ),
        //           staggeredTileBuilder: (int index) =>
        //               new StaggeredTile.count(2, index.isEven ? 3 : 2),
        //           mainAxisSpacing: 4.0,
        //           crossAxisSpacing: 4.0,
        //         ),
        //       ),
        //     ),
      ],
    );
  }
}
