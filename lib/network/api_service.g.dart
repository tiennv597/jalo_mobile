// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiService implements ApiService {
  _ApiService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'http://192.168.1.28:3000/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getExample(keySearch) async {
    ArgumentError.checkNotNull(keySearch, 'keySearch');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'key_search': keySearch};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('search',
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
    return Future.value(value);
  }
}