import 'package:aquatracking/service/service.dart';

import '../model/user_model.dart';

class AuthenticationService extends Service {
  Future<UserModel> login(String email, String password) async {
    return UserModel(id: "1", username: "Bob", email: "bob@exemple.fr"); // todo
  }
}