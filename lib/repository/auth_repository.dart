import 'package:aquatracking/models/user/user_login_model.dart';
import 'package:aquatracking/models/user/user_model.dart';
import 'package:aquatracking/repository/repository.dart';
import 'package:dio/dio.dart';

class AuthRepository extends Repository {
  Future<UserModel> login(UserLoginModel userLoginModel) async {
    Response<dynamic> response = await Repository.dio.post(
      '/auth/login',
      data: userLoginModel.toJson(),
    );

    return UserModel.fromJson(response.data);
  }
}
