import 'package:shinro_int2/constant/app_properties.dart';
import 'package:flutter/material.dart';

class RoomsList extends StatefulWidget {
  List cw;
  RoomsList({this.cw});
  @override
  RoomsListState createState() {
    return new RoomsListState();
  }
}

class RoomsListState extends State<RoomsList> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        
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
                  onTap: () {
                    print("object");
                  },
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
