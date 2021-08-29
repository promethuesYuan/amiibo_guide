import 'package:dio/dio.dart';

class DioUtil {
  String baseUrl = "https://www.amiiboapi.com/api";

  late Dio _dio;

  DioUtil._internal() {
    var options = BaseOptions(baseUrl: baseUrl);
    _dio = Dio(options);
  }

  factory DioUtil() => _instance;

  static late final DioUtil _instance = DioUtil._internal();

  Future<Map<String, dynamic>> invoke(String route, {Map<String, dynamic>? data}) async {
    Response response = await _dio.get(route, queryParameters: data);
    return response.data;
  }
}
