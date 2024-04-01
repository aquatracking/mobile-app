import 'package:aquatracking/globals.dart';

import '../model/user_model.dart';

class AuthenticationService {
  Future<UserModel> login(
      {required String email, required String password}) async {
    final result = await dioService.post<UserModel>("auth/login", data: {
      "email": email,
      "password": password,
    }).catchError((e) {
      throw e;
    });

    return result.data!;
  }

  Future<UserModel> register(
      String username, String email, String password) async {
    final result = await dioService.post("/auth/register", data: {
      "username": username,
      "email": email,
      "password": password,
    }).catchError((e) {
      print(e.response?.data);
    });

    return UserModel.fromJson(result.data);
  }

  Future<void> checkLogin() async {
    // todo
  }

  Future<void> setLocalUsername() async {
    // todo
  }

  Future<void> logout(context) async {
    persistCookieJar.deleteAll();
  }
}
