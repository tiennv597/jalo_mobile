import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shinro_int2/models/grammar/example_model.dart';
import 'package:shinro_int2/network/api_service.dart';

class GrammarController extends GetxController {
  final apiService =
      ApiService(Dio(BaseOptions(contentType: "application/json")));

  Future<List<Example>> getExample(String text) async {
    await Future.delayed(Duration(seconds: 0));

    if (text.length >= 2) {
      return apiService.getExample(text);
    }
    return null;
  }
}
