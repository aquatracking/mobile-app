import 'package:aquatracking/models/user/user_create_model.dart';
import 'package:aquatracking/models/user/user_login_model.dart';
import 'package:aquatracking/models/user/user_model.dart';
import 'package:aquatracking/repository/repository.dart';
import 'package:aquatracking/repository/user_repository.dart';
import 'package:dio/dio.dart';

class AuthRepository extends Repository {
  Future<UserModel> login(UserLoginModel userLoginModel) async {
    Response<dynamic> response = await Repository.dio.post(
      '/auth/login',
      data: userLoginModel.toJson(),
    );

    UserModel user = UserModel.fromJson(response.data);

    UserRepository.currentUser = user;

    return user;
  }

  Future<UserModel> register(UserCreateModel userCreateModel) async {
    Response<dynamic> response = await Repository.dio.post(
      '/auth/register',
      data: userCreateModel.toJson(),
    );

    return UserModel.fromJson(response.data);
  }
}
