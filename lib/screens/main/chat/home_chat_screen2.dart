import 'package:flutter/material.dart';
import 'package:shinro_int2/screens/main/chat/global.dart';

import 'chat.dart';

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
      body: ListView.builder(
        itemCount: friendsList.length,
        itemBuilder: (ctx, i) {
          return Column(
            children: <Widget>[
              ListTile(
                isThreeLine: true,
                onLongPress: () {},
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatScreen())),
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          offset: Offset(0, 5),
                          blurRadius: 25)
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(friendsList[i]['imgUrl']),
                        ),
                      ),
                      friendsList[i]['isOnline']
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                title: Text(
                  "${friendsList[i]['username']}",
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  "${friendsList[i]['lastMsg']}",
                  style: !friendsList[i]['seen']
                      ? Theme.of(context)
                          .textTheme
                          .subtitle
                          .apply(color: Colors.black87)
                      : Theme.of(context)
                          .textTheme
                          .subtitle
                          .apply(color: Colors.black54),
                ),
                trailing: Container(
                  width: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          friendsList[i]['seen']
                              ? Icon(
                                  Icons.check,
                                  size: 15,
                                )
                              : Container(height: 15, width: 15),
                          Text("${friendsList[i]['lastMsgTime']}")
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      friendsList[i]['hasUnSeenMsgs']
                          ? Container(
                              alignment: Alignment.center,
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: myGreen,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                "${friendsList[i]['unseenCount']}",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : Container(
                              height: 25,
                              width: 25,
                            ),
                    ],
                  ),
                ),
              ),
              Divider()
            ],
          );
        },
      ),
    );
  }
}
