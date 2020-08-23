import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shinro_int2/network/user_service.dart';

class UserController extends GetxController {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  var count = 0.obs;

  final userService =
      UserService(Dio(BaseOptions(contentType: "application/json")));

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
}
