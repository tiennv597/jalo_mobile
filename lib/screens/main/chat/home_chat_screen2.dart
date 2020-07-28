import 'package:flutter/material.dart';
import 'package:shinro_int2/screens/main/chat/chat_tab_home.dart';

class HomeChatScreen extends StatefulWidget {
  @override
  _HomeChatScreenState createState() => _HomeChatScreenState();
}

class _HomeChatScreenState extends State<HomeChatScreen>
    with TickerProviderStateMixin<HomeChatScreen> {
  TabController tabControllerHome;
  @override
  void initState() {
    tabControllerHome = TabController(length: 2, vsync: this);
    super.initState();
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
              child: Text("Chat"),
            ),
          ),
        ),
        Tab(
          child: Container(
            height: 32,
            child: Align(
              alignment: Alignment.center,
              child: Text("People"),
            ),
          ),
        ),
      ],
      controller: tabControllerHome,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(-16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 32,
                child: tabBar,
              ),
              //_buildNotifIcon()
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   elevation: 5,
      //   backgroundColor: myGreen,
      //   child: Icon(Icons.camera),
      //   onPressed: () {},
      // ),
      // bottomNavigationBar: BottomAppBar(
      //   shape: CircularNotchedRectangle(),
      //   notchMargin: 7.0,
      //   child: Row(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: <Widget>[
      //       IconButton(
      //         icon: Icon(Icons.message, color: Colors.black45),
      //         onPressed: () {},
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.view_list, color: Colors.black45),
      //         onPressed: () {},
      //       ),
      //       SizedBox(width: 25),
      //       IconButton(
      //         icon: Icon(Icons.call, color: Colors.black45),
      //         onPressed: () {},
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.person_outline, color: Colors.black45),
      //         onPressed: () {},
      //       ),
      //     ],
      //   ),
      // ),
      body: ChatTab(
            tabController: tabControllerHome,
          ),
    );
  }
}
