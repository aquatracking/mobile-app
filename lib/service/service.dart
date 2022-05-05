import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

abstract class Service{
  late Dio dio;
  late Options options;
  static late CookieJar cookieJar = CookieJar();

  Service() {
    dio = Dio();
    dio.interceptors.add(CookieManager(cookieJar));
    options = Options(
        headers: { "Accept": "application/json" },
        responseType: ResponseType.plain
    );
  }

  Future<dynamic> get(String urlString) async {
    final result = await dio.get(
        urlString,
        options: options
    );
    final body = json.decode(json.encode(result.data));
    return body;
  }

  Future<dynamic> getList(String urlString) async {
    //print(urlString);
    final result = await dio.get(
        urlString,
        options: options
    );
    final body = json.decode(result.data);
    return body;
  }

  Future<dynamic> post(String urlString, dynamic data) async {
    final result = await dio.post(
        urlString,
        data: data,
        options: options
    );
    final body = json.decode(json.encode(result.data));
    return body;
  }

  Future<dynamic> put(String urlString, dynamic data) async {
    final result = await dio.put(
        urlString,
        data: data,
        options: options
    );
    final body = json.decode(json.encode(result.data));
    return body;
  }

  Future<bool> delete(String urlString) async {
    final result = await dio.delete(
        urlString,
        options: options
    );
    return result.statusCode == 200;
  }
}