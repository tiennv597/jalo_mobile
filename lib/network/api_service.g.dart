// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiService implements ApiService {
  _ApiService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'http://192.168.1.28:3000';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getExample(keySearch) async {
    ArgumentError.checkNotNull(keySearch, 'keySearch');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'key_search': keySearch};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/search',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Example.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  loginUser(email, password) async {
    ArgumentError.checkNotNull(email, 'email');
    ArgumentError.checkNotNull(password, 'password');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'email': email, 'password': password};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/users/signin',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    final value = User.fromJson(_result.data);
    return value;
  }

  @override
  signUp(firstName, lastName, email, password) async {
    ArgumentError.checkNotNull(firstName, 'firstName');
    ArgumentError.checkNotNull(lastName, 'lastName');
    ArgumentError.checkNotNull(email, 'email');
    ArgumentError.checkNotNull(password, 'password');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password
    };
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/users/signup',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    final value = UserToken.fromJson(_result.data);
    final value2 = _result.headers.value('authorization');
    UserToken userToken = new UserToken();
    userToken.success = value.success;
    userToken.token = value2;
    return userToken;
  }

  @override
  checkToken(jwt) async {
    ArgumentError.checkNotNull(jwt, 'jwt');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/login-api',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': jwt},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = User.fromJson(_result.data);
    return value;
  }
}
