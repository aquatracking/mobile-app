import 'package:aquatracking/errors/bad_login_error.dart';
import 'package:aquatracking/globals.dart';
import 'package:aquatracking/service/service.dart';
import 'package:dio/dio.dart';

import '../model/user_model.dart';

class AuthenticationService extends Service {
  static bool loggedIn = false;
  static bool serviceAvailable = true;

  Future<UserModel> login(String email, String password) async {
    var value =  await post('/users/login', {
      'email': email,
      'password': password
    }).catchError((e) {
      if(e.response?.statusCode == 401 || e.response?.statusCode == 404) {
        throw BadLoginError();
      } else {
        throw e;
      }
    });

    loggedIn = true;
    return UserModel.fromJson(value);
  }

  Future<void> checkLogin(String refreshToken) async {
    var options = Options(
      headers: {
        "Accept": "application/json",
        "cookie": refreshToken
      },
      responseType: ResponseType.json,
    );

    loggedIn = false;
    serviceAvailable = true;

    try {
      var value = await dio.get(
          '$apiBaseUrl/',
          options: options
      );

      loggedIn = (value.statusCode == 200);
    } catch (e) {
      loggedIn = false;
      if(e.toString().contains('Connection closed')) {
        serviceAvailable = false;
      }
    }
  }
}