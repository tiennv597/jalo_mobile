part of 'user_service.dart';

class _UserService implements UserService {
  _UserService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'http://192.168.1.28:3000/';
  }
  final Dio _dio;
  String baseUrl;
  @override
  suggestions(level, type, subType, quantity) async {
    ArgumentError.checkNotNull(level, 'level');
    ArgumentError.checkNotNull(type, 'type');
    ArgumentError.checkNotNull(subType, 'subType');
    ArgumentError.checkNotNull(quantity, 'quantity');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'level': level,
      'type': type,
      'subType': subType,
      'quantity': quantity
    };
    final Response<List<dynamic>> _result = await _dio.request(
        '/users/suggestions',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => User.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  // @override
  // search(key) async {
  //   ArgumentError.checkNotNull(key, 'key');
  //   const _extra = <String, dynamic>{};
  //   final queryParameters = <String, dynamic>{};
  //   final _data = {
  //     'key': key,
  //   };
  //   final Response<List<dynamic>> _result = await _dio.request('/users/search',
  //       queryParameters: queryParameters,
  //       options: RequestOptions(
  //           method: 'POST',
  //           headers: <String, dynamic>{},
  //           extra: _extra,
  //           contentType: 'application/json',
  //           baseUrl: baseUrl),
  //       data: _data);
  //   var value = _result.data
  //       .map((dynamic i) => User.fromJson(i as Map<String, dynamic>))
  //       .toList();
  //   return value;
  // }

  @override
  search(key) async {
    ArgumentError.checkNotNull(key, 'key');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'key': key};
    final Response<List<dynamic>> _result = await _dio.request('/users/search',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => User.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
