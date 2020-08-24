import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shinro_int2/network/api_service.dart';
import 'package:shinro_int2/network/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinro_int2/models/user/user_model.dart';
import 'package:shinro_int2/constant/shared_preferences.dart'
    as SHARED_PREFERNCES;
import 'package:shinro_int2/constant/network_constant.dart' as NETWORK_CONSTANT;
import 'package:shinro_int2/screens/main/main_screen.dart';

class UserController extends GetxController {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  User user;
  Map userProfile;
  final userService =
      UserService(Dio(BaseOptions(contentType: "application/json")));
  final apiService =
      ApiService(Dio(BaseOptions(contentType: "application/json")));
  Future<List<dynamic>> suggestions() async =>
      await Future.delayed(Duration(seconds: 1), () {
        return userService.suggestions("", "", "", "");
      });

  Future<List<dynamic>> search(String text) async {
    await Future.delayed(Duration(seconds: 0));

    if (text.length >= 2) {
      return userService.search(text);
    }
    return null;
  }

  signIn(String userName, String password) {
    apiService.signIn(userName, password).then((it) async {
      print(it.headers.value('authorization'));
      final user = User.fromJson(it.data);
      //c.updateUser(user);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(SHARED_PREFERNCES.logined, true);
      prefs.setString(SHARED_PREFERNCES.user_id, user.sId);
      prefs.setString(
          SHARED_PREFERNCES.fullName, user.firstName + " " + user.lastName);
      prefs.setString(SHARED_PREFERNCES.token,
          NETWORK_CONSTANT.bearer + ' ' + it.headers.value('authorization'));
      Get.to(MainPage());
    }).catchError((onError) {
      print("error" + onError.toString());
    });
  }

  signUp(String fullName, String email, String password) {
    List<String> text = fullName.split(" ");
    String firstName = text[0];
    String lastName = "";
    for (var i = 1; i < text.length; i++) {
      lastName += text[i] + " ";
    }
    apiService
        .signUp(firstName, lastName.trim(), email, password)
        .then((it) async {
      print(it.toString());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (it.token.toString() != null && it.success == true) {
        prefs.setString(SHARED_PREFERNCES.token, it.token.toString());
        print(it.token.toString());
        Get.to(MainPage());
      } else {}
    }).catchError((onError) {
      print("error" + onError.toString());
    });
  }

  authFacebook(String token) {
    apiService.authFacebook(token).then((it) async {
      print(it.headers.value('authorization'));
      final user = User.fromJson(it.data);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(SHARED_PREFERNCES.logined, true);
      prefs.setString(SHARED_PREFERNCES.user_id, user.sId);
      prefs.setString(
          SHARED_PREFERNCES.fullName, user.firstName + " " + user.lastName);
      // prefs.setString(
      //     SHARED_PREFERNCES.userAvatar, userProfile["picture"]["data"]["url"]);
      prefs.setString(SHARED_PREFERNCES.token,
          NETWORK_CONSTANT.bearer + ' ' + it.headers.value('authorization'));
      Get.to(MainPage());
    }).catchError((onError) {
      print("error" + onError.toString());
    });
  }

  updateUser(User u) {
    user = u;
  }
}
