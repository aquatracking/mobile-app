import 'dart:async';

import 'package:aquatracking/errors/api_error.dart';
import 'package:aquatracking/repository/user_repository.dart';
import 'package:aquatracking/services/navigator_service.dart';
import 'package:aquatracking/styles.dart';
import 'package:aquatracking/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ValidateEmailView extends StatefulWidget {
  const ValidateEmailView({super.key});

  @override
  State<ValidateEmailView> createState() => _ValidateEmailViewState();
}

class _ValidateEmailViewState extends State<ValidateEmailView> {
  final userRepository = UserRepository();
  final textEditingController = TextEditingController();
  final errorController = StreamController<ErrorAnimationType>();

  @override
  void initState() {
    sendCode(context);
    super.initState();
  }

  void sendCode(BuildContext context) {
    userRepository.sendVerificationEmail().catchError(
      (error) {
        if (error is ApiError && error.code == "EMAIL_ALREADY_VERIFIED") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context)!.errorEmailAlreadyVerified,
              ),
            ),
          );
          NavigationService().replaceScreen(const MainView());
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

  void verifyCode(BuildContext context, String code) {
    userRepository.verifyEmail(code).then(
      (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.emailVerified),
          ),
        );
        NavigationService().replaceScreen(const MainView());
      },
    ).catchError(
      (error) {
        String errorMessage = AppLocalizations.of(context)!.errorUnknown;

        if (error is ApiError) {
          switch (error.code) {
            case "INVALID_EMAIL_VERIFICATION_CODE":
              errorMessage = AppLocalizations.of(context)!
                  .errorEmailVerificationCodeNotValid;
              break;
            case "EXPIRED_EMAIL_VERIFICATION_CODE":
              errorMessage = AppLocalizations.of(context)!
                  .errorEmailVerificationCodeExpired;
              sendCode(context);
              break;
            case "NO_EMAIL_VERIFICATION_CODE":
              errorMessage = AppLocalizations.of(context)!
                  .errorEmailVerificationCodeNotExists;
              sendCode(context);
              break;
            case "EMAIL_ALREADY_VERIFIED":
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppLocalizations.of(context)!.errorEmailAlreadyVerified,
                  ),
                ),
              );
              NavigationService().replaceScreen(const MainView());
              break;
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );

        errorController.add(ErrorAnimationType.shake);
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
                AppLocalizations.of(context)!.verifyEmail,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: AppSpacing.small,
              ),
              Text(
                AppLocalizations.of(context)!.verifyEmailSent,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      sendCode(context);
                    },
                    child: Text(AppLocalizations.of(context)!.resendEmail),
                  ),
                  const SizedBox(
                    width: AppSpacing.medium,
                  ),
                  FilledButton(
                    onPressed: () {
                      verifyCode(context, textEditingController.text);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.verifyCode,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
