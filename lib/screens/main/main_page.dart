import 'package:shinro_int2/screens/game/game_home_page.dart';
import 'package:shinro_int2/screens/grammar/example_page.dart';
import 'package:shinro_int2/constant/app_colors.dart' as COLORS;
import 'package:shinro_int2/screens/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'components/tab_search_view.dart';
import 'components/tab_view.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage> {
  SwiperController swiperController;
  TabController tabController;
  TabController tabControllerRank;
  TabController tabControllerSearch;
  TabController bottomTabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabControllerSearch = TabController(length: 1, vsync: this);
    tabControllerRank = TabController(length: 2, vsync: this);
    bottomTabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Widget tabBar = TabBar(
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
    );
       Widget tabBarSearch = TabBar(
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
              child: Text("EXample"),
            ),
          ),
        ),
      ],
      controller: tabControllerSearch,
    );
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
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
                  child: tabBar,
                ),
              ),
            ),
          ),
          body: TabView(
            tabController: tabController,
          ),
        ),
      ),
     // ExamplePage(),
     DefaultTabController(
        length: 1,
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
                  child: tabBarSearch,
                ),
              ),
            ),
          ),
          body: TabSearchView(
            tabController: tabControllerSearch,
          ),
        ),
      ),
      GameHomePage(tabController: tabControllerRank),
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
        fixedColor: COLORS.cyan700,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions[_selectedIndex],
    );
  }
}
