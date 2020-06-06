import 'package:shinro_int2/models/grammar/example_model.dart';
import 'package:shinro_int2/models/user/user_model.dart';
import 'package:shinro_int2/models/user/user_token.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://192.168.1.28:3000/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return ApiService(dio);
  }

  //get search example grammar
  @GET("search")
  Future<List<Example>> getExample(@Query("key_search") String keySearch);
  //post login user
  @FormUrlEncoded()
  @POST("login-api")
  Future<UserToken> loginUser(@Field("login_username") String loginUsername,
      @Field("login_password") String loginPassword);
  //get login user
  @GET("login-api")
  Future<User> checkToken(@Header("Authorization") String jwt);
}
