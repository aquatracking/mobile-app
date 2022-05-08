import 'dart:convert';
import 'package:aquatracking/globals.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

abstract class Service {
  late Dio dio;
  late Options options;
  static late CookieJar cookieJar= CookieJar();

  Service() {
    dio = Dio();
    dio.interceptors.add(CookieManager(cookieJar));
    options = Options(
        headers: { "Accept": "application/json" },
        responseType: ResponseType.json,
    );
  }

  Future<dynamic> get(String path) async {
    final result = await dio.get(
        apiBaseUrl + path,
        options: options
    );
    final body = result.data;
    return body;
  }

  Future<dynamic> post(String path, dynamic data) async {
    final result = await dio.post(
        apiBaseUrl + path,
        data: data,
        options: options
    );

    List<String>? cookies = result.headers['set-cookie'];
    if(cookies != null){
      String refreshToken = cookies.firstWhere((element) => element.contains('refresh_token'));
      if(refreshToken.isNotEmpty){
        prefs.setString('refresh_token', refreshToken);
      }
    }

    final body = result.data;
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

  Future<dynamic> checkLogin(String refreshToken) async {
    var options = Options(
      headers: {
        "Accept": "application/json",
        "cookie": refreshToken
      },
      responseType: ResponseType.json,
    );

    bool logged = false;

    try {
      var value = await dio.get(
          '$apiBaseUrl/',
          options: options
      );

      logged = (value.statusCode == 200);
    } catch (e) {
      logged = false;
    }

    return logged;
  }
}