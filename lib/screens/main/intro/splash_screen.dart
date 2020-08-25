import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../profile/controller/user_controller.dart';
import 'controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> opacity;
  AnimationController controller;
  bool firstLaunch = false;
  UserController userController = Get.put(UserController());
  SplashController splashController = Get.put(SplashController());
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2500), vsync: this);
    opacity = Tween<double>(begin: 1, end: 0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) {
      // navigationPage();
      splashController.startApp();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // void navigationPage() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //Return bool
  //   bool checkValue = prefs.containsKey(SHARED_PREFERNCES.first_launch);
  //   if (checkValue) {
  //     firstLaunch = prefs.getBool(SHARED_PREFERNCES.first_launch);
  //   }
  //   if (firstLaunch) {
  //     final api = Provider.of<ApiService>(context, listen: false);
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String jwt = prefs.getString(SHARED_PREFERNCES.token);
  //     print(jwt);
  //     if (jwt != null) {
  //       api.secret(jwt).then((it) async {
  //         if (it.resources) {
  //           prefs.setBool(SHARED_PREFERNCES.logined, true);
  //           Navigator.of(context)
  //               .pushReplacement(MaterialPageRoute(builder: (_) => MainPage()));
  //         } else {
  //           Navigator.of(context)
  //               .pushReplacement(MaterialPageRoute(builder: (_) => MainPage()));
  //         }
  //       }).catchError((onError) {
  //         print("error" + onError.toString());
  //         Navigator.of(context)
  //             .pushReplacement(MaterialPageRoute(builder: (_) => MainPage()));
  //       });
  //     } else {
  //       prefs.setBool(SHARED_PREFERNCES.logined, false);
  //       Navigator.of(context)
  //           .pushReplacement(MaterialPageRoute(builder: (_) => MainPage()));
  //     }
  //   } else {
  //     Navigator.of(context)
  //         .pushReplacement(MaterialPageRoute(builder: (_) => IntroPage()));
  //     prefs.setBool(
  //         SHARED_PREFERNCES.first_launch, true); //set true login one time
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (userController.userG.sId == null) {
      userController.getUserFromSP();
    }
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background.jpg'), fit: BoxFit.cover)),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Opacity(
                      opacity: opacity.value,
                      child: Image.asset('assets/good.png')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: RichText(
                    text: const TextSpan(
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
