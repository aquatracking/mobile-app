import 'package:aquatracking/errors/api_error.dart';
import 'package:aquatracking/models/user/user_login_model.dart';
import 'package:aquatracking/repository/auth_repository.dart';
import 'package:aquatracking/repository/user_repository.dart';
import 'package:aquatracking/services/navigator_service.dart';
import 'package:aquatracking/styles.dart';
import 'package:aquatracking/views/auth/login_otp_view.dart';
import 'package:aquatracking/views/auth/register_view.dart';
import 'package:aquatracking/views/main_view.dart';
import 'package:aquatracking/widgets/ui/inputs/password_input_widget.dart';
import 'package:aquatracking/widgets/ui/inputs/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  void setState(VoidCallback fn) {
    UserRepository.currentUser = null;
    super.setState(fn);
  }

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
                    AppLocalizations.of(context)!.login,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(
                    height: AppSpacing.large,
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
                      if (loginError?.code == "USER_NOT_FOUND") {
                        return AppLocalizations.of(context)!
                            .errorNoUserWithEmail;
                      }
                      return null;
                    },
                    onSaved: (value) => {userLoginModel.email = value},
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
                      if (loginError?.code == "WRONG_PASSWORD") {
                        return AppLocalizations.of(context)!.errorWrongPassword;
                      }
                      return null;
                    },
                    onSaved: (value) => {userLoginModel.password = value},
                  ),
                  const SizedBox(
                    height: AppSpacing.large,
                  ),
                  FilledButton(
                    child: Text(AppLocalizations.of(context)!.signIn),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        authRepository.login(userLoginModel).then(
                          (user) {
                            NavigationService().replaceScreen(const MainView());
                          },
                        ).catchError(
                          (error) {
                            if (error is ApiError &&
                                (error.code == "USER_NOT_FOUND" ||
                                    error.code == "WRONG_PASSWORD")) {
                              loginError = error;
                              _formKey.currentState!.validate();
                              loginError = null;
                            } else if (error is ApiError &&
                                error.code == "OTP_REQUIRED") {
                              NavigationService().replaceScreen(
                                LoginOtpView(userLoginModel: userLoginModel),
                              );
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
                        AppLocalizations.of(context)!.noAccount,
                      ),
                      TextButton(
                        onPressed: () {
                          NavigationService()
                              .replaceScreen(const RegisterView());
                        },
                        child:
                            Text(AppLocalizations.of(context)!.createAccount),
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
