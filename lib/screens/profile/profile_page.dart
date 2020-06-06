import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinro_int2/constant/app_properties.dart';
import 'package:shinro_int2/network/api_service.dart';
import 'package:shinro_int2/screens/auth/login/login_page.dart';
import 'package:shinro_int2/screens/faq_page.dart';
import 'package:shinro_int2/screens/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:shinro_int2/constant/shared_preferences.dart' as SHARED_PREFERNCES;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool logined;
  @override
  void initState() {
    super.initState();
    logined = false;
    checkToken();
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
                              child: logined
                                  ? Text("data")
                                  : RaisedButton(
                                      child: Text("Sign in"),
                                      onPressed: goToLoginPage,
                                      color: Colors.red,
                                      textColor: Colors.yellow,
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      splashColor: Colors.grey,
                                    ),
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

  Future<void> checkToken() async {
    final api = Provider.of<ApiService>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString(SHARED_PREFERNCES.token);
    print(jwt);
    if (jwt != null) {
      api.checkToken(jwt).then((it) async {
        if (it.success) {
          setState(() {
            logined = true;
            print(logined);
          });
          prefs.setBool(SHARED_PREFERNCES.logined, true);
          prefs.setString(SHARED_PREFERNCES.user_id, it.id);
          prefs.setString(SHARED_PREFERNCES.display_name, it.displayName);
        }
      }).catchError((onError) {
        print("error" + onError.toString());
      });
    } else {
      logined = false;
       prefs.setBool(SHARED_PREFERNCES.logined, false);
    }
  }
}
