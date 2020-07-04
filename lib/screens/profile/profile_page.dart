import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinro_int2/constant/app_properties.dart';
import 'package:shinro_int2/models/user/user_model.dart';
import 'package:shinro_int2/screens/auth/login/login_page.dart';
import 'package:shinro_int2/screens/faq_page.dart';
import 'package:shinro_int2/screens/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:shinro_int2/constant/shared_preferences.dart'
    as SHARED_PREFERNCES;
import 'package:shinro_int2/constant/app_colors.dart' as COLORS;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool logined;

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
                  padding: const EdgeInsets.only(left: 8,right: 8),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.blue,
                        backgroundImage: NetworkImage(
                            'https://images.pexels.com/photos/340152/pexels-photo-340152.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 0,bottom: 0,left: 8),
                            child: Text(
                              user.displayName,
                              style:
                                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0,bottom: 0,left: 8),
                            child: Text(
                              "id: 1232316",
                              style:
                                  TextStyle(fontSize: 16),
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
                            "Japanese",
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
                            "Rank",
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
                            "Level",
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
                            "Friends",
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
            return RaisedButton(
              child: Text("Sign in"),
              onPressed: goToLoginPage,
              color: COLORS.cyan700,
              textColor: COLORS.white,
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              splashColor: Colors.grey,
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
                  title: Text('Settings'),
                  subtitle: Text('Privacy and logout'),
                  leading: Image.asset(
                    'assets/icons/settings_icon.png',
                    fit: BoxFit.scaleDown,
                    width: 30,
                    height: 30,
                  ),
                  trailing: Icon(Icons.chevron_right, color: yellow),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SettingsPage())),
                ),
                Divider(),
                ListTile(
                  title: Text('Help & Support'),
                  subtitle: Text('Help center and legal support'),
                  leading: Image.asset('assets/icons/support.png'),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: yellow,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('FAQ'),
                  subtitle: Text('Questions and Answer'),
                  leading: Image.asset('assets/icons/faq.png'),
                  trailing: Icon(Icons.chevron_right, color: yellow),
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

  void goToLoginPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginPage()));
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

  @override
  void dispose() {
    super.dispose();
  }
}
