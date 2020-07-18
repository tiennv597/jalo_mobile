import 'package:shinro_int2/models/grammar/example_model.dart';
import 'package:shinro_int2/models/user/resources.dart';
import 'package:shinro_int2/models/user/user_token.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shinro_int2/constant/network_constant.dart' as NETWORK_CONSTANT;

part 'api_service.g.dart';

@RestApi(baseUrl: NETWORK_CONSTANT.basURL)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return ApiService(dio);
  }

  //get search example grammar
  @GET("/search")
  Future<List<Example>> getExample(@Query("key_search") String keySearch);
  //post login user
  @FormUrlEncoded()
  @POST("/users/signin")
  Future<Response<Map<String, dynamic>>> signIn(
      @Field("email") String email, @Field("password") String password);
  //signup user
  @FormUrlEncoded()
  @POST("/users/signup")
  Future<UserToken> signUp(
      @Field("firstName") String firstName,
      @Field("lastName") String lastName,
      @Field("email") String email,
      @Field("password") String password);
  //get login user
  @GET("/users/secret")
  Future<Resources> secret(@Header("Authorization") String jwt);
}
