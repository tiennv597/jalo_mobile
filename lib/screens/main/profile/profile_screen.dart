import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinro_int2/models/user/user_model.dart';
import 'package:shinro_int2/screens/main/chat/global.dart';
import 'package:shinro_int2/screens/main/profile/auth/login/login_page.dart';
import 'package:shinro_int2/screens/main/profile/faq/faq_screen.dart';
import 'package:flutter/material.dart';
import 'package:shinro_int2/constant/shared_preferences.dart'
    as SHARED_PREFERNCES;
import 'package:shinro_int2/constant/app_colors.dart' as COLORS;
import 'package:shinro_int2/screens/main/profile/settings/friends_screen.dart';
import 'settings/settings_screen.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool logined;
  String userAvatar;
  // LoginController c = Get.find();
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Widget infoUser() {
    return FutureBuilder(
        future: checkLogin(),
        builder: (context, snapshot) {
          User user = snapshot.data;
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.blue,
                        backgroundImage: NetworkImage("userAvatar"),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 0, left: 8),
                            child: Text(
                              user.displayName,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 0, left: 8),
                            child: Text(
                              "id: ",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 18,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "N5",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Tiếng nhật",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 20,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "10K",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Xếp hạng",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 20,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "900",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Cấp độ",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 20,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "1",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Bạn bè",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Guest mode"),
                ),
                RaisedButton(
                  child: Text("Sign in"),
                  onPressed: () {
                    Get.to(LoginPage());
                  },
                  color: myGreen,
                  textColor: COLORS.white,
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  splashColor: Colors.grey,
                ),
              ],
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                    child: StreamBuilder(
                        stream: null,
                        builder: (context, snapshot) => Visibility(
                              visible: true,
                              child: infoUser(),
                              replacement: Column(
                                children: <Widget>[
                                  CircleAvatar(
                                    maxRadius: 48,
                                    backgroundImage:
                                        AssetImage('assets/background.jpg'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Rose Helbert',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ))),
                ListTile(
                  title: Text('Bạn bè'),
                  subtitle: Text('Danh sách bạn bè & tìm kiếm'),
                  leading: Icon(
                    Icons.people,
                    size: 36,
                  ),
                  trailing: Icon(Icons.chevron_right, color: myGreen),
                  onTap: () => Get.to(FriendsScreen()),
                ),
                ListTile(
                  title: Text('Settings'),
                  subtitle: Text('Privacy and logout'),
                  leading: Icon(
                    Icons.settings_applications,
                    size: 36,
                  ),
                  trailing: Icon(Icons.chevron_right, color: myGreen),
                  onTap: () => Get.to(SettingsPage()),
                ),
                Divider(),
                ListTile(
                  title: Text('Help & Support'),
                  subtitle: Text('Help center and legal support'),
                  leading: Icon(
                    Icons.email,
                    size: 32,
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: myGreen,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('FAQ'),
                  subtitle: Text('Questions and Answer'),
                  leading: Icon(
                    Icons.question_answer,
                    size: 32,
                  ),
                  trailing: Icon(Icons.chevron_right, color: myGreen),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => FaqPage())),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<User> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    logined = prefs.getBool(SHARED_PREFERNCES.logined);
    User user = new User();
    if (logined == true && logined != null) {
      user.displayName = prefs.getString(SHARED_PREFERNCES.fullName);
      userAvatar = prefs.getString(SHARED_PREFERNCES.userAvatar);
      return user;
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
