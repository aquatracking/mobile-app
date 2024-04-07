import 'package:aquatracking/errors/api_error.dart';
import 'package:aquatracking/models/user/user_create_model.dart';
import 'package:aquatracking/repository/auth_repository.dart';
import 'package:aquatracking/services/navigator_service.dart';
import 'package:aquatracking/styles.dart';
import 'package:aquatracking/views/auth/login_view.dart';
import 'package:aquatracking/widgets/ui/inputs/password_input_widget.dart';
import 'package:aquatracking/widgets/ui/inputs/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final userCreateModel = UserCreateModel();
  final authRepository = AuthRepository();
  final passwordController = TextEditingController();
  ApiError? registerError;

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
                    AppLocalizations.of(context)!.register,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(
                    height: AppSpacing.large,
                  ),
                  TextInputWidget(
                    label: AppLocalizations.of(context)!.labelUsername,
                    prefixIcon: Icons.person,
                    autofillHints: const [AutofillHints.newUsername],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.errorEnterUsername;
                      }
                      if (value.length < 3) {
                        return AppLocalizations.of(context)!
                            .errorUsernameShort(3);
                      }
                      if (value.length > 50) {
                        return AppLocalizations.of(context)!
                            .errorUsernameLong(50);
                      }
                      if (registerError?.code == "USERNAME_ALREADY_EXIST") {
                        return AppLocalizations.of(context)!.errorUsernameExist;
                      }
                      return null;
                    },
                    onSaved: (value) => {userCreateModel.username = value},
                  ),
                  const SizedBox(
                    height: AppSpacing.medium,
                  ),
                  TextInputWidget(
                    label: AppLocalizations.of(context)!.labelEmail,
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.errorEnterEmail;
                      }
                      final emailRegex =
                          RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$');
                      if (!emailRegex.hasMatch(value)) {
                        return AppLocalizations.of(context)!.errorInvalidEmail;
                      }
                      if (registerError?.code == "EMAIL_ALREADY_EXIST") {
                        return AppLocalizations.of(context)!.errorEmailExist;
                      }
                      return null;
                    },
                    onSaved: (value) => {userCreateModel.email = value},
                  ),
                  const SizedBox(
                    height: AppSpacing.medium,
                  ),
                  PasswordInputWidget(
                    label: AppLocalizations.of(context)!.labelPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.errorEnterPassword;
                      }
                      if (value.length < 8) {
                        return AppLocalizations.of(context)!
                            .errorPasswordShort(8);
                      }
                      if (value.length > 100) {
                        return AppLocalizations.of(context)!
                            .errorPasswordLong(100);
                      }
                      return null;
                    },
                    controller: passwordController,
                    onSaved: (value) => {userCreateModel.password = value},
                  ),
                  const SizedBox(
                    height: AppSpacing.medium,
                  ),
                  PasswordInputWidget(
                    label: AppLocalizations.of(context)!.labelPasswordConfirm,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.errorEnterPassword;
                      }
                      if (value != passwordController.text) {
                        return AppLocalizations.of(context)!
                            .errorPasswordMismatch;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: AppSpacing.large,
                  ),
                  FilledButton(
                    child: Text(AppLocalizations.of(context)!.signUp),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        authRepository.register(userCreateModel).then(
                          (user) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(context)!
                                      .wellcomeUser(user.username),
                                ),
                              ),
                            );
                            NavigationService()
                                .replaceScreen(const LoginView());
                          },
                        ).catchError(
                          (error) {
                            if (error is ApiError &&
                                (error.code == "USERNAME_ALREADY_EXIST" ||
                                    error.code == "EMAIL_ALREADY_EXIST")) {
                              registerError = error;
                              _formKey.currentState!.validate();
                              registerError = null;
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    AppLocalizations.of(context)!.errorUnknown,
                                  ),
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
                      Text(
                        AppLocalizations.of(context)!.haveAccount,
                      ),
                      TextButton(
                        onPressed: () {
                          NavigationService().replaceScreen(const LoginView());
                        },
                        child: Text(AppLocalizations.of(context)!.signIn),
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
