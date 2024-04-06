import 'package:aquatracking/errors/api_error.dart';
import 'package:aquatracking/models/user/user_login_model.dart';
import 'package:aquatracking/repository/auth_repository.dart';
import 'package:aquatracking/services/navigator_service.dart';
import 'package:aquatracking/styles.dart';
import 'package:aquatracking/views/auth/register_view.dart';
import 'package:aquatracking/views/home_view.dart';
import 'package:aquatracking/widgets/ui/inputs/password_input_widget.dart';
import 'package:aquatracking/widgets/ui/inputs/text_input_widget.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final userLoginModel = UserLoginModel();
  final authRepository = AuthRepository();
  ApiError? loginError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.large,
            vertical: AppSpacing.small,
          ),
          child: Center(
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    "Connexion",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(
                    height: AppSpacing.large,
                  ),
                  TextInputWidget(
                    label: "Email",
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre email';
                      }
                      final emailRegex =
                          RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Veuillez entrer un email valide';
                      }
                      if (loginError?.code == "USER_NOT_FOUND") {
                        return 'Aucun utilisateur trouvé avec cet email';
                      }
                      return null;
                    },
                    onSaved: (value) => {userLoginModel.email = value},
                  ),
                  const SizedBox(
                    height: AppSpacing.medium,
                  ),
                  PasswordInputWidget(
                    label: "Mot de passe",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre mot de passe';
                      }
                      if (loginError?.code == "WRONG_PASSWORD") {
                        return 'Mot de passe incorrect';
                      }
                      return null;
                    },
                    onSaved: (value) => {userLoginModel.password = value},
                  ),
                  const SizedBox(
                    height: AppSpacing.large,
                  ),
                  FilledButton(
                    child: const Text("Se connecter"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        authRepository.login(userLoginModel).then((user) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Bienvenue! ${user.username}'),
                            ),
                          );
                          NavigationService().replaceScreen(const HomeView());
                        }).catchError(
                          (error) {
                            if (error is ApiError &&
                                (error.code == "USER_NOT_FOUND" ||
                                    error.code == "WRONG_PASSWORD")) {
                              loginError = error;
                              _formKey.currentState!.validate();
                              loginError = null;
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Une erreur s'est produite"),
                                ),
                              );
                            }
                          },
                        );
                      }
                    },
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Pas encore de compte ?",
                      ),
                      TextButton(
                        onPressed: () {
                          NavigationService()
                              .replaceScreen(const RegisterView());
                        },
                        child: const Text("Inscrivez-vous"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
