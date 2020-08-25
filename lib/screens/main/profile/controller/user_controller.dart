import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constant/network_constant.dart' as NETWORK_CONSTANT;
import '../../../../constant/shared_preferences.dart'
    as SHARED_PREFERNCES;
import '../../../../models/user/user_model.dart';
import '../../../../network/api_service.dart';
import '../../../../network/user_service.dart';
import '../../main_screen.dart';

class UserController extends GetxController {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  User userG = User();
  bool createdSocket = false;
  Map userProfile;
  final userService =
      UserService(Dio(BaseOptions(contentType: 'application/json')));
  final apiService =
      ApiService(Dio(BaseOptions(contentType: 'application/json')));
  Future<List<dynamic>> suggestions() async =>
      Future.delayed(const Duration(seconds: 1), () {
        return userService.suggestions('', '', '', '');
      });

  Future<List<dynamic>> search(String text) async {
    await Future.delayed(const Duration(seconds: 0));

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
      prefs.setString(SHARED_PREFERNCES.firstName, user.firstName);
      prefs.setString(SHARED_PREFERNCES.lastName, user.lastName);
      prefs.setString(
          SHARED_PREFERNCES.fullName, user.firstName + " " + user.lastName);
      prefs.setString(SHARED_PREFERNCES.token,
          NETWORK_CONSTANT.bearer + ' ' + it.headers.value('authorization'));
      userG = user;
      createdSocket = true;
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (it.token.toString() != null && it.success == true) {
        prefs.setString(SHARED_PREFERNCES.token, it.token.toString());
        print(it.token.toString());
        Get.to(MainPage());
      } else {}
    }).catchError((onError) {});
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
    }).catchError((onError) {});
  }

  dynamic getUserFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey(SHARED_PREFERNCES.logined);
    if (checkValue) {
      String id = prefs.getString(SHARED_PREFERNCES.user_id);
      String firstName = prefs.getString(SHARED_PREFERNCES.firstName);
      String lastName = prefs.getString(SHARED_PREFERNCES.lastName);
      userG.sId = id;
      userG.lastName = lastName;
      userG.firstName = firstName;
    }
  }

  updateUser(User u) {
    userG = u;
  }
}
