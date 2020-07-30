import 'package:shinro_int2/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinro_int2/constant/shared_preferences.dart'
    as SHARED_PREFERNCES;
import 'package:shinro_int2/constant/app_colors.dart' as COLORS;
import 'package:shinro_int2/screens/main/learning/game/components/rank_type_tab.dart';
import 'package:shinro_int2/screens/main/search/grammar/example_screen.dart';

import 'game/game_room_screen.dart';

class LearingPage extends StatefulWidget {
  final TabController tabController;
  LearingPage({Key key, this.tabController}) : super(key: key);
  @override
  _LearingPageState createState() => _LearingPageState();
}

class _LearingPageState extends State<LearingPage>
    with TickerProviderStateMixin<LearingPage> {
  SwiperController swiperController = SwiperController();
  bool logined;
  String displayName;

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
      user.displayName = prefs.getString(SHARED_PREFERNCES.fullName);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ExamplePage()));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16,left: 16,top: 8,bottom: 8),
              child: Container(
                width: MediaQuery.of(context).size.width * 90 / 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200]),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                    ),
                    Align(
                        child: Text(
                      "Search (Grammar, mẫu câu,...)",
                      style: TextStyle(color: Colors.grey),
                    )),
                  ],
                ),
              ),
            ),
          ),
          // IconButton(
          //     icon: Icon(
          //       Icons.search,
          //       color: Colors.black,
          //     ),
          //     onPressed: () {
          //       Navigator.of(context).push(
          //           MaterialPageRoute(builder: (context) => ExamplePage()));
          //     })
        ],
      ),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Learing',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          FlatButton(
                            child: Text('View All'),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 8, bottom: 8, left: 8),
                                child: _buildTypeBtn('Competition',
                                    'assets/ninja.png', COLORS.colorOrange),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _buildTypeBtn('JLPT',
                                    'assets/benkyou.png', COLORS.colorBlue),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 8, bottom: 8, left: 8),
                                child: _buildTypeBtn('Practice',
                                    'assets/gokaku.png', COLORS.colorGreen),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _buildTypeBtn('Competition',
                                    'assets/good.png', COLORS.colorPurple),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Rank',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          FlatButton(
                            child: Text('View All'),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(0),
                sliver: SliverAppBar(
                  expandedHeight: 10,
                  pinned: true,
                  floating: true,
                  primary: true,
                  //disable AppBar shadow when no content is scrolled under it
                  elevation: 0.0,
                  backgroundColor: Colors.white,
                  //forceElevated: innerBoxIsScrolled,
                  bottom: PreferredSize(
                    preferredSize: new Size(200.0, 32.0),
                    child: Container(
                      height: 30,
                      child: TabBar(
                        unselectedLabelColor: COLORS.cyan600,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: COLORS.cyan600),
                        tabs: <Widget>[
                          Tab(
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: COLORS.cyan600, width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Competition"),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: COLORS.cyan600, width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("JLPT"),
                              ),
                            ),
                          ),
                        ],
                        controller: widget.tabController,
                      ),
                    ),
                  ),
                ),
              )
            ];
          },
          body: RankTypeTab(
            tabController: widget.tabController,
          ),
        ),
      ),
    );
  }
}
