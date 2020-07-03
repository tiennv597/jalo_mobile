import 'package:shinro_int2/constant/app_properties.dart';
import 'package:shinro_int2/screens/game/game_room_page.dart';
import 'package:shinro_int2/screens/grammar/example_page.dart';
import 'package:shinro_int2/screens/main/components/rank_type_tab.dart';
import 'package:shinro_int2/constant/app_colors.dart' as COLORS;
import 'package:shinro_int2/screens/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'components/tab_view.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage> {
  SwiperController swiperController;
  TabController tabController;
  TabController tabController2;
  TabController bottomTabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController2 = TabController(length: 2, vsync: this);
    bottomTabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
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
      labelColor: darkGrey,
      unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.5),
      isScrollable: true,
      controller: tabController,
      indicatorColor: transparentPurple,
    );
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    Widget _buildTypeBtn(
        String title, String urlImage, LinearGradient lgColor) {
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

    List<Widget> _widgetOptions = <Widget>[
      DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(-20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 32,
                  child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.grey,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.black,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    tabs: <Widget>[
                      Tab(
                        child: Container(
                          height: 32,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Related"),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 32,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Hot"),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 32,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Explore"),
                          ),
                        ),
                      ),
                    ],
                    controller: tabController,
                  ),
                ),
              ),
            ),
          ),
          body: TabView(
            tabController: tabController,
          ),
        ),
      ),
      ExamplePage(),
      //GameHomePage(),
      SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
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
                            'Game',
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
                  // title: Text('Board Top'),
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
                        unselectedLabelColor: Colors.redAccent,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.redAccent),
                        tabs: <Widget>[
                          Tab(
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.redAccent, width: 1)),
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
                                      color: Colors.redAccent, width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("JLPT"),
                              ),
                            ),
                          ),
                        ],
                        controller: tabController2,
                      ),
                    ),
                  ),
                ),
              )
            ];
          },
          body: RankTypeTab(
            tabController: tabController2,
          ),
        ),
      ),
      ProfilePage()
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.g_translate),
            title: Text('Grammar'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            title: Text('Game'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin),
            title: Text('Profile'),
          ),
        ],
        iconSize: 28,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        fixedColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions[_selectedIndex],
    );
  }
}
