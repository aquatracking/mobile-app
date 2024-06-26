import 'package:aquatracking/models/user/user_model.dart';
import 'package:aquatracking/repository/repository.dart';
import 'package:dio/dio.dart';

class UserRepository extends Repository {
  static UserModel? currentUser;

  Future<UserModel> getMe() async {
    Response<dynamic> response = await Repository.dio.get('/users/me');

    return UserModel.fromJson(response.data);
  }

  Future<void> sendVerificationEmail() async {
    await Repository.dio.post('/users/me/verify-email/send-code');
  }

  Future<void> verifyEmail(String code) async {
    await Repository.dio.post(
      '/users/me/verify-email/verify-code',
      data: {
        'code': code,
      },
    );
  }
}
