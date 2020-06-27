import 'package:shinro_int2/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinro_int2/constant/shared_preferences.dart'
    as SHARED_PREFERNCES;
import 'package:shinro_int2/constant/app_colors.dart' as COLORS;

import 'components/rank_tab_view.dart';
import 'game_room_page.dart';

class GameHomePage extends StatefulWidget {
  @override
  _GameHomePageState createState() => _GameHomePageState();
}

class _GameHomePageState extends State<GameHomePage>
    with TickerProviderStateMixin<GameHomePage> {
  SwiperController swiperController = SwiperController();
  TabController tabController;
  bool logined;
  String displayName;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
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

  Widget _buildTypeBtn(String title, String urlImage, LinearGradient lgColor) {
    var withS = MediaQuery.of(context).size.width / 2.5;
    var heightS = MediaQuery.of(context).size.height / 8;
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      color: Colors.white,
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => GameRoomPage()));
      },
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        width: withS,
        height: heightS,
        decoration: BoxDecoration(
          gradient: lgColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
                width: withS / 4,
                height: withS / 4,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill, image: ExactAssetImage(urlImage)))),
            Text(title),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var withS = MediaQuery.of(context).size.width;
    var heightS = MediaQuery.of(context).size.height / 2.1;
    tabController = TabController(length: 3, vsync: this);

    Widget tabBar = TabBar(
      tabs: [
        Tab(text: 'Related'),
        Tab(text: 'Hot'),
        Tab(text: 'Explore'),
      ],
      labelStyle: TextStyle(fontSize: 16.0),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0,
      ),
      labelColor: COLORS.darkGrey,
      unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.5),
      isScrollable: true,
      controller: tabController,
      indicatorColor: COLORS.transparentPurple,
    );

    // Widget _buildRankTab() {
    //   return;
    // }

    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 20, bottom: 0),
              child: Text("Game"),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildTypeBtn('Competition', 'assets/ninja.png',
                            COLORS.colorOrange),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildTypeBtn(
                            'JLPT', 'assets/benkyou.png', COLORS.colorBlue),
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
                        child: _buildTypeBtn(
                            'Practice', 'assets/gokaku.png', COLORS.colorGreen),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildTypeBtn('Competition', 'assets/good.png',
                            COLORS.colorPurple),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                width: withS,
                height: heightS,
                color: Colors.red,
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    // These are the slivers that show up in the "outer" scroll view.
                    return <Widget>[
                      SliverToBoxAdapter(
                        child: tabBar,
                      )
                    ];
                  },
                  body: RankTabView(
                    tabController: tabController,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
