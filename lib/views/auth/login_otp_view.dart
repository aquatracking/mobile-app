import 'dart:async';

import 'package:aquatracking/errors/api_error.dart';
import 'package:aquatracking/models/user/user_login_model.dart';
import 'package:aquatracking/models/user/user_login_with_otp.dart';
import 'package:aquatracking/repository/auth_repository.dart';
import 'package:aquatracking/repository/user_repository.dart';
import 'package:aquatracking/services/navigator_service.dart';
import 'package:aquatracking/styles.dart';
import 'package:aquatracking/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginOtpView extends StatefulWidget {
  final UserLoginWithOtpModel userLoginWithOtpModel;

  LoginOtpView({
    super.key,
    required UserLoginModel userLoginModel,
  }) : userLoginWithOtpModel = UserLoginWithOtpModel(
          email: userLoginModel.email,
          password: userLoginModel.password,
        );

  @override
  State<LoginOtpView> createState() => _LoginOtpViewState();
}

class _LoginOtpViewState extends State<LoginOtpView> {
  final userRepository = UserRepository();
  final authRepository = AuthRepository();
  final textEditingController = TextEditingController();
  final errorController = StreamController<ErrorAnimationType>();

  void login(BuildContext context) {
    authRepository.login(widget.userLoginWithOtpModel).then(
      (value) {
        NavigationService().replaceScreen(const MainView());
      },
    ).catchError(
      (error) {
        if (error is ApiError && error.code == "WRONG_OTP") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.errorWrongOTP),
            ),
          );
          errorController.add(ErrorAnimationType.shake);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.errorUnknown),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.large,
          vertical: AppSpacing.small,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.verifyOTP,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: AppSpacing.small,
              ),
              Text(
                AppLocalizations.of(context)!.verifyOTPDescription,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppSpacing.large,
              ),
              SizedBox(
                width: 400,
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  errorAnimationController: errorController,
                  controller: textEditingController,
                  pinTheme: PinTheme(
                    activeColor: Theme.of(context).colorScheme.primary,
                    inactiveColor: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              const SizedBox(
                height: AppSpacing.medium,
              ),
              FilledButton(
                onPressed: () {
                  widget.userLoginWithOtpModel.otp = textEditingController.text;
                  login(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.login,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
