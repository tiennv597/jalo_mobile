import 'package:get/get.dart';

class UserController extends GetxController {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  var count = 0.obs;

  Future<dynamic> suggestions() async =>
      await Future.delayed(Duration(seconds: 1), () {
        return entries;
      });
}
