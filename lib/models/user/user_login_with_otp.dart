import 'package:aquatracking/models/user/user_login_model.dart';

class UserLoginWithOtpModel extends UserLoginModel {
  String? otp;

  UserLoginWithOtpModel({
    super.email,
    super.password,
    this.otp,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'otp': otp,
    };
  }
}
