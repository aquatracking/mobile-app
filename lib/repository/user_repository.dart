import 'package:aquatracking/models/user/user_model.dart';
import 'package:aquatracking/repository/repository.dart';
import 'package:dio/dio.dart';

class UserRepository extends Repository {
  Future<UserModel> getMe() async {
    Response<dynamic> response = await Repository.dio.get('/users/me');

    return UserModel.fromJson(response.data);
  }
}
