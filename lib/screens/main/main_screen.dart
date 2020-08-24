import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:shinro_int2/screens/main/chat/global.dart';
import 'package:shinro_int2/screens/main/profile/controller/user_controller.dart';
import 'package:shinro_int2/screens/main/search/grammar/example_screen.dart';
import 'package:shinro_int2/socket/user_socket.dart';
import 'learning/learing_screen.dart';
import 'notification/notifications_screen.dart';
import 'profile/profile_screen.dart';
import 'home/home_tab_view.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage> {
  SwiperController swiperController;
  TabController tabControllerHome;
  TabController tabControllerRank;
  TabController tabControllerSearch;
  TabController bottomTabController;
  UserSocket socket = Get.put(UserSocket());
  UserController c = Get.put(UserController());
  int _selectedIndex = 0;
  int _counter = 2;
  @override
  void initState() {
    super.initState();
    tabControllerHome = TabController(length: 2, vsync: this);
    tabControllerSearch = TabController(length: 1, vsync: this);
    tabControllerRank = TabController(length: 2, vsync: this);
    bottomTabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    if (c.userG != null) {
      socket.onListenSocketEvent();
    }
    Widget tabBar = TabBar(
      isScrollable: true,
      indicatorColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Colors.black,
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      tabs: <Widget>[
        // Tab(
        //   child: Container(
        //     height: 32,
        //     child: Align(
        //       alignment: Alignment.center,
        //       child: Text("Home"),
        //     ),
        //   ),
        // ),
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
      controller: tabControllerHome,
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

    // void _incrementCounter() {
    //   setState(() {
    //     _counter++;
    //   });
    // }

    void _openNotification() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NotificationsSreen()));
    }

    Widget _buildNotifIcon() {
      return GestureDetector(
        onTap: _openNotification,
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Stack(
            children: [
              Icon(
                Icons.notifications_none,
                color: Colors.grey,
                size: 30,
              ),
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 5),
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                      border: Border.all(color: Colors.white, width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                      child: Text(
                        _counter.toString(),
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    List<Widget> _widgetOptions = <Widget>[
      DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(-20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 32,
                    child: tabBar,
                  ),
                  //_buildNotifIcon()
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(Icons.search),
                  ),
                ],
              ),
            ),
          ),
          body: HomeTabView(
            tabController: tabControllerHome,
          ),
        ),
      ),
      // DefaultTabController(
      //   length: 1,
      //   child: Scaffold(
      //     backgroundColor: Colors.white,
      //     appBar: AppBar(
      //       backgroundColor: Colors.white,
      //       elevation: 0.0,
      //       bottom: PreferredSize(
      //         preferredSize: Size.fromHeight(-20),
      //         child: Align(
      //           alignment: Alignment.centerLeft,
      //           child: Container(
      //             height: 32,
      //             child: tabBarSearch,
      //           ),
      //         ),
      //       ),
      //     ),
      //     body: TabSearchView(
      //       tabController: tabControllerSearch,
      //     ),
      //   ),
      // ),
      ExamplePage(),
      LearingPage(tabController: tabControllerRank),

      // NotificationsSreen(),
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
            icon: Icon(Icons.public),
            title: Text('Home'),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.message),
          //   title: Text('Message'),
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Grammar'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.import_contacts),
            title: Text('Game'),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.notifications),
          //   title: Text('Profile'),
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            title: Text('menu'),
          ),
        ],
        iconSize: 28,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        fixedColor: myGreen,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions[_selectedIndex],
    );
  }
}
