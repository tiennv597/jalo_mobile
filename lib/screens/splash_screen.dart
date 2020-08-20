import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinro_int2/constant/constant.dart';
import 'package:shinro_int2/network/api_service.dart';
import 'package:flutter/material.dart';
import 'package:shinro_int2/screens/main/main_screen.dart';
import 'package:shinro_int2/constant/shared_preferences.dart'
    as SHARED_PREFERNCES;
import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> opacity;
  AnimationController controller;
  bool firstLaunch = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 2500), vsync: this);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) {
      navigationPage();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool checkValue = prefs.containsKey(SHARED_PREFERNCES.first_launch);
    if (checkValue) {
      firstLaunch = prefs.getBool(SHARED_PREFERNCES.first_launch);
    }
    if (firstLaunch) {
      final api = Provider.of<ApiService>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jwt = prefs.getString(SHARED_PREFERNCES.token);
      print(jwt);
      if (jwt != null) {
        api.secret(jwt).then((it) async {
          if (it.resources) {
            prefs.setBool(SHARED_PREFERNCES.logined, true);
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (_) => MainPage()));
          } else {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (_) => MainPage()));
          }
        }).catchError((onError) {
          print("error" + onError.toString());
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => MainPage()));
        });
      } else {
        prefs.setBool(SHARED_PREFERNCES.logined, false);
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => MainPage()));
      }
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => IntroPage()));
      prefs.setBool(
          SHARED_PREFERNCES.first_launch, false); //set true login one time
    }
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background.jpg'), fit: BoxFit.cover)),
      child: Container(
        decoration: BoxDecoration(color: transparentWhite),
        child: SafeArea(
          child: new Scaffold(
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Opacity(
                      opacity: opacity.value,
                      child: new Image.asset('assets/good.png')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(text: 'Powered by '),
                          TextSpan(
                              text: 'JaloTeam',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
