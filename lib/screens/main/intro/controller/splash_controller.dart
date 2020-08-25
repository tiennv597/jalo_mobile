import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinro_int2/screens/main/intro/intro_screen.dart';
import '../../../../constant/network_constant.dart' as NETWORK_CONSTANT;
import '../../../../constant/shared_preferences.dart' as SHARED_PREFERNCES;

import '../../../../network/api_service.dart';

import '../../main_screen.dart';

class SplashController extends GetxController {
  bool firstLaunch = false;
  final apiService =
      ApiService(Dio(BaseOptions(contentType: 'application/json')));

  void startApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool checkValue = prefs.containsKey(SHARED_PREFERNCES.first_launch);
    if (checkValue) {
      firstLaunch = prefs.getBool(SHARED_PREFERNCES.first_launch);
    }
    if (firstLaunch) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jwt = prefs.getString(SHARED_PREFERNCES.token);
      print(jwt);
      if (jwt != null) {
        await apiService.secret(jwt).then((it) async {
          if (it.resources) {
            await prefs.setBool(SHARED_PREFERNCES.logined, true);
            await Get.to(MainPage());
          } else {
            await Get.to(MainPage());
          }
        }).catchError((onError) {
          Get.to(MainPage());
        });
      } else {
        prefs.setBool(SHARED_PREFERNCES.logined, false);
        Get.to(MainPage());
      }
    } else {
      await Get.to(IntroPage());

      prefs.setBool(
          SHARED_PREFERNCES.first_launch, true); //set true login one time
    }
  }
}
