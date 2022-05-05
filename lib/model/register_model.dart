class RegisterModel {
  String username = "";
  String email = "";
  String password = "";
  String passwordConfirmation = "";

  isValid() {
    return username.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        passwordConfirmation.isNotEmpty &&
        password == passwordConfirmation;
  }
}