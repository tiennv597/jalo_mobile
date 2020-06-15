import 'package:shinro_int2/constant/app_properties.dart';
import 'package:flutter/material.dart';

class InfoUserItem extends StatefulWidget {
  final String displayName;

  // In the constructor, require a Example.
  InfoUserItem(this.displayName);
  @override
  _InfoUserItemPageState createState() => _InfoUserItemPageState();
}

class _InfoUserItemPageState extends State<InfoUserItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(top: 20),
      height: 200,
      child: Stack(
        children: <Widget>[
          Container(
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadow,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Column(
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: new NetworkImage(
                                              "https://i.imgur.com/BoN9kdC.png")))),
                            ),
                            new Text(widget.displayName, textScaleFactor: 1.5)
                          ],
                        )),
                        Container(
                          padding: EdgeInsets.only(left: 24, right: 30),
                          width: 180,
                          child: Column(
                            
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Level: 00',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: darkGrey,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Coin: 00',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: darkGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                  Container(
                    padding: EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'なし',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: darkGrey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ),
                                Text(
                                  'なし',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: darkGrey, fontSize: 16.0),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'なし',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: darkGrey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ),
                                Text(
                                  'なし',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: darkGrey, fontSize: 16.0),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
