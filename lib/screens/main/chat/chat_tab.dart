import 'package:flutter/material.dart';
import 'package:shinro_int2/screens/main/chat/global.dart';

import 'chat.dart';
import 'components/favorite_contacts.dart';

class Chat extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 95 / 100,
                  height: 36,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200]),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "Search",
                    ),
                  ),
                ),
                FavoriteContacts()
              ],
            ),
          ),
        ];
      },
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
