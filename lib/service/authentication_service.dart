import 'dart:developer';

import 'package:aquatracking/errors/bad_login_error.dart';
import 'package:aquatracking/globals.dart';
import 'package:aquatracking/service/service.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import '../model/user_model.dart';

class AuthenticationService extends Service {
  Future<UserModel> login(String email, String password) async {
    var value =  await post('$apiBaseUrl/users/login', {
      'email': email,
      'password': password
    }).catchError((e) {
      if(e.response?.statusCode == 401 || e.response?.statusCode == 404) {
        throw BadLoginError();
      } else {
        throw e;
      }
    });

    return UserModel.fromJson(value);
  }
}