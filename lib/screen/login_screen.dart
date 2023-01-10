import 'package:aquatracking/errors/bad_login_error.dart';
import 'package:aquatracking/model/authentication_model.dart';
import 'package:aquatracking/screen/main_screen.dart';
import 'package:aquatracking/screen/register_screen.dart';
import 'package:aquatracking/service/authentication_service.dart';
import 'package:aquatracking/utils/popup_utils.dart';
import 'package:flutter/material.dart';

AuthenticationModel authModel = AuthenticationModel();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    AuthenticationService authenticationService = AuthenticationService();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              const Text('Connexion',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  )),
              const Padding(padding: EdgeInsets.only(top: 50)),
              TextFormField(
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  setState(() {
                    authModel.email = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_rounded),
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    authModel.password = value;
                  });
                },
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  prefixIcon: Icon(Icons.lock_rounded),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 50)),
              ElevatedButton(
                onPressed: !isFormValid() ? null : () {
                  if(authModel.email.isEmpty) {
                    PopupUtils.showError(context, 'Email maquant', 'Veuillez saisir votre email');
                  } else if(authModel.password.isEmpty) {
                    PopupUtils.showError(context, 'Mot de passe manquant', 'Veuillez saisir votre mot de passe');
                  } else {
                    authenticationService.login(authModel.email, authModel.password).then((value) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()));
                    }).catchError((e) {
                      if(e is BadLoginError) {
                        PopupUtils.showError(context, 'Connexion impossible', "email ou mot de passe incorrect");
                      } else {
                        PopupUtils.showError(context, 'Erreur de connexion', "Une erreur est survenue");
                      }
                    });
                  }
                },
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Connexion',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Icon(
                        Icons.arrow_forward_rounded,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Pas encore inscrit ?',
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.secondary,
                      ),
                      child: const Text('Inscrivez-vous')
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  isFormValid() {
    return authModel.email.isNotEmpty && authModel.password.isNotEmpty;
  }
}