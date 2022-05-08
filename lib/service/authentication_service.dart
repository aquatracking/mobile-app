import 'package:aquatracking/errors/bad_login_error.dart';
import 'package:aquatracking/service/service.dart';

import '../model/user_model.dart';

class AuthenticationService extends Service {
  static bool loggedIn = false;

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
}