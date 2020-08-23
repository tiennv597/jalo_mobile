import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shinro_int2/constant/network_constant.dart' as NETWORK_CONSTANT;
import 'package:shinro_int2/models/user/user_model.dart';
part 'user_service.g.dart';

@RestApi(baseUrl: NETWORK_CONSTANT.basURL)
abstract class UserService {
  factory UserService(Dio dio, {String baseUrl}) = _UserService;

  static _UserService create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return _UserService(dio);
  }

  @FormUrlEncoded()
  @GET("/users/suggestions")
  Future<List<User>> suggestions(
      @Field("level") String level,
      @Field("type") String type,
      @Field("subType") String subType,
      @Field("quantity") String quantity);
}
