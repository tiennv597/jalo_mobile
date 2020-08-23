import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shinro_int2/models/user/user_model.dart';
import 'package:shinro_int2/models/user/users.dart';
import 'package:shinro_int2/network/user_service.dart';

class UserController extends GetxController {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  var count = 0.obs;
  
  //final userService = Provider.of<UserService>(Get.context, listen: false);
  final userService =
      UserService(Dio(BaseOptions(contentType: "application/json")));
  Future<List<dynamic>> suggestions() async =>
      await Future.delayed(Duration(seconds: 1), () {
        userService.suggestions("", "", "", "");
        //print(users[0].firstName);
        //     .then((it) async {

        //    //Users users = Users.fromJson(json.decode(it.data.toString()));
        //   // print(users.users[0].firstName);

        // }).catchError((onError) {
        //   print("error" + onError.toString());
        // });

        return userService.suggestions("", "", "", "");
      });
      
}
