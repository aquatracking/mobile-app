class AuthenticationModel {
  String email = "";
  String password = "";

  isValid() {
    return email.isNotEmpty && password.isNotEmpty;
  }
}