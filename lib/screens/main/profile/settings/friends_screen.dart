import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:shinro_int2/constant/shared_preferences.dart'
    as SHARED_PREFERNCES;
import 'package:flutter/material.dart';
import 'package:shinro_int2/screens/main/profile/settings/search_screen.dart';

import 'friends_tab_view.dart';

class FriendsScreen extends StatefulWidget {
  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen>
    with TickerProviderStateMixin<FriendsScreen> {
  final facebookLogin = FacebookLogin();

  TabController tabController;
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Widget tabBar = TabBar(
      isScrollable: true,
      indicatorColor: Colors.black,
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
              child: Text("Đề xuất"),
            ),
          ),
        ),
        Tab(
          child: Container(
            height: 32,
            child: Align(
              alignment: Alignment.center,
              child: Text("Tất cả bạn bè"),
            ),
          ),
        ),
      ],
      controller: tabController,
    );
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            brightness: Brightness.light,
            backgroundColor: Colors.transparent,
            title: Text(
              'Bạn bè',
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 32,
                    child: tabBar,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              // action button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Get.to(SearchScreen());
                  },
                ),
              ),
            ]),
        body: FriendsTabView(tabController: tabController));
  }
}
