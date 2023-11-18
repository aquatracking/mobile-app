import 'package:aquatracking/errors/bad_login_error.dart';
import 'package:aquatracking/errors/email_already_exists_error.dart';
import 'package:aquatracking/errors/register_disabled_error.dart';
import 'package:aquatracking/errors/user_already_exists_error.dart';
import 'package:aquatracking/globals.dart';
import 'package:aquatracking/screen/login_screen.dart';
import 'package:aquatracking/service/service.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class AuthenticationService extends Service {
  static bool loggedIn = false;
  static bool serviceAvailable = true;

  Future<UserModel> login(String email, String password) async {
    var value = await post('/users/login', {
      'email': email,
      'password': password
    }).catchError((e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 404) {
        throw BadLoginError();
      } else {
        throw e;
      }
    });

    loggedIn = true;
    setLocalUsername();
    return UserModel.fromJson(value);
  }

  Future<UserModel> register(String username, String email, String password) async {
    var value = await post('/users', {
      'username': username,
      'email': email,
      'password': password
    }).catchError((e) {
      if(e.response?.statusCode == 403) {
        throw RegisterDisabledError();
      } else if(e.response?.statusCode == 409 && e.response?.data == "USER ALREADY EXISTS") {
        throw UserAlreadyExistsError();
      } else if(e.response?.statusCode == 409 && e.response?.data == "EMAIL ALREADY EXISTS") {
        throw EmailAlreadyExistsError();
      } else {
        throw e;
      }
    });

    return UserModel.fromJson(value);
  }

  Future<void> checkLogin() async {
    loggedIn = false;
    serviceAvailable = true;

    try {
      var value = await dio.get('$apiBaseUrl/');

      loggedIn = (value.statusCode == 200);
      if (loggedIn) {
        setLocalUsername();
      }
    } catch (e) {
      loggedIn = false;
      if (e.toString().contains('Connection closed') || e.toString().contains('Connection refused')) {
        serviceAvailable = false;
      }
    }
  }

  Future<void> setLocalUsername() async {
    prefs = await SharedPreferences.getInstance();

    String? refreshToken = prefs.getString('refresh_token');
    if (refreshToken != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(refreshToken);
      username = decodedToken['username'];
    }
  }

  Future<void> logout(context) async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove('refresh_token');

    persistCookieJar.deleteAll();

    loggedIn = false;
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
