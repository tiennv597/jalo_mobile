import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinro_int2/constant/app_properties.dart';
import 'package:shinro_int2/models/user/user_model.dart';
import 'package:shinro_int2/screens/auth/login/login_page.dart';
import 'package:shinro_int2/screens/faq_page.dart';
import 'package:shinro_int2/screens/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:shinro_int2/constant/shared_preferences.dart'
    as SHARED_PREFERNCES;

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
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue,
                  backgroundImage: NetworkImage(
                      'https://images.pexels.com/photos/340152/pexels-photo-340152.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                ),
                Container(
                  height: 8,
                ),
                Text(
                  user.displayName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                            "100K",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Following",
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
                            "Fans",
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
                            "Heats",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Container(
                //   height: 18,
                // ),
                // MaterialButton(
                //   color: Colors.redAccent,
                //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(5),
                //   ),
                //   child: Text(
                //     "Follow",
                //     style: TextStyle(fontSize: 20, color: Colors.white),
                //   ),
                //   onPressed: () {},
                // ),
                // Container(
                //   height: 18,
                // ),
                // Text(
                //   "I am lyrically criminal",
                //   style: TextStyle(color: Colors.grey),
                // ),
                // Container(
                //   height: 8,
                // ),
                // Text("SEE TRANSLATION"),
                // Container(
                //   height: 18,
                // ),
              ],
            );
          } else {
            return RaisedButton(
              child: Text("Sign in"),
              onPressed: goToLoginPage,
              color: Colors.red,
              textColor: Colors.yellow,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              splashColor: Colors.grey,
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(left: 16.0, right: 16.0, top: kToolbarHeight),
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
