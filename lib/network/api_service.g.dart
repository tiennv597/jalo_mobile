// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiService implements ApiService {
  _ApiService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://jsonplaceholder.typicode.com/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getTasks() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('photos',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => TaskModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return Future.value(value);
  }
}
