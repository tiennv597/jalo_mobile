import 'package:shinro_int2/models/game/types.dart';
import 'package:shinro_int2/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinro_int2/constant/shared_preferences.dart'
    as SHARED_PREFERNCES;
import 'package:shinro_int2/constant/app_colors.dart'as COLORS;

import 'game_room_page.dart';

class GameHomePage extends StatefulWidget {
  @override
  _GameHomePageState createState() => _GameHomePageState();
}

class _GameHomePageState extends State<GameHomePage> {
  SwiperController swiperController = SwiperController();
  bool logined;
  String displayName;
  List<Types> types = [
    Types(
      Color(0xff36E892),
      Color(0xff33B2B9),
      'Competition',
      'assets/background.png',
    ),
    Types(
      Color(0xffF123C4),
      Color(0xff668CEA),
      'Practice',
      'assets/background.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<User> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    logined = prefs.getBool(SHARED_PREFERNCES.logined);
    User user = new User();
    if (logined == true && logined != null) {
      user.displayName = prefs.getString(SHARED_PREFERNCES.displayName);
      return user;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var withS = MediaQuery.of(context).size.width / 3;
    var heightS = MediaQuery.of(context).size.height / 8;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Game"),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => GameRoomPage()));
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              width: withS,
                              height: heightS,
                              decoration: const BoxDecoration(
                                gradient: COLORS.colorOrange,
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: const Text('Competition'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => GameRoomPage()));
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              width: withS,
                              height: heightS,
                              decoration: const BoxDecoration(
                                gradient:COLORS.colorBlue,
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: const Text('Competition'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => GameRoomPage()));
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              width: withS,
                              height: heightS,
                              decoration: const BoxDecoration(
                                gradient: COLORS.colorGreen,
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: const Text('Competition'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => GameRoomPage()));
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              width: withS,
                              height: heightS,
                              decoration: const BoxDecoration(
                                gradient: COLORS.colorPurple,
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: const Text('Competition'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          )
          // GridView.count(
          //   primary: false,
          //   padding: const EdgeInsets.all(24),
          //   crossAxisSpacing: 10,
          //   mainAxisSpacing: 10,

          //   crossAxisCount: 2,
          //   children: <Widget>[
          //     RaisedButton(
          //       color: Colors.white,
          //       onPressed: () {
          //         Navigator.of(context)
          //             .push(MaterialPageRoute(builder: (_) => GameRoomPage()));
          //       },

          //       textColor: Colors.white,
          //       padding: const EdgeInsets.all(0.0),
          //       child: Container(
          //         height: 200,
          //         width: 200,
          //         decoration: const BoxDecoration(
          //           gradient: LinearGradient(
          //             colors: <Color>[
          //               Color(0xFF42A5F5),
          //               Color(0xFF1976D2),
          //               Color(0xFF0D47A1),
          //             ],
          //           ),
          //         ),
          //         padding: const EdgeInsets.all(10.0),
          //         child: const Text('Competition'),
          //       ),
          //     ),
          //     Container(
          //       padding: const EdgeInsets.all(8),
          //       child: const Text('Heed not the rabble'),
          //       color: Colors.teal[200],
          //     ),
          //     Container(
          //       padding: const EdgeInsets.all(8),
          //       child: const Text('Sound of screams but the'),
          //       color: Colors.teal[300],
          //     ),
          //     Container(
          //       padding: const EdgeInsets.all(8),
          //       child: const Text('Who scream'),
          //       color: Colors.teal[400],
          //     ),
          //   ],
          // )
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: <Widget>[
          //     // infoUser(),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Text(
          //         'Game',
          //         style: TextStyle(
          //             fontSize: 20,
          //             color: darkGrey,
          //             fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //     // SizedBox(
          //     //   height: MediaQuery.of(context).size.width / 1.5,
          //     //   child: Swiper(
          //     //     itemCount: types.length,
          //     //     itemBuilder: (_, index) {
          //     //       return TypePlayCard(types[index],logined);
          //     //     },
          //     //     scale: 0.8,
          //     //     controller: swiperController,
          //     //     viewportFraction: 0.6,
          //     //     loop: false,
          //     //     fade: 0.7,
          //     //   ),
          //     // ),
          //     // SizedBox(height: 36),

          //   ],
          // )
          ),
    );
  }
}

// class Scroll extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     LinearGradient grT = LinearGradient(
//         colors: [Colors.transparent, Colors.black26],
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter);
//     LinearGradient grB = LinearGradient(
//         colors: [Colors.transparent, Colors.black26],
//         begin: Alignment.bottomCenter,
//         end: Alignment.topCenter);

//     canvas.drawRect(
//         Rect.fromLTRB(0, 0, size.width, 30),
//         Paint()
//           ..shader = grT.createShader(Rect.fromLTRB(0, 0, size.width, 30)));

//     canvas.drawRect(Rect.fromLTRB(0, 30, size.width, size.height - 40),
//         Paint()..color = Color.fromRGBO(50, 50, 50, 0.4));

//     canvas.drawRect(
//         Rect.fromLTRB(0, size.height - 40, size.width, size.height),
//         Paint()
//           ..shader = grB.createShader(
//               Rect.fromLTRB(0, size.height - 40, size.width, size.height)));
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
