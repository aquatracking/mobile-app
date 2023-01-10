import 'package:aquatracking/model/register_model.dart';
import 'package:aquatracking/utils/popup_utils.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

RegisterModel registerModel = RegisterModel();

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              const Text('Inscription',
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
                    registerModel.username = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Nom d\'utilisateur',
                  prefixIcon: Icon(Icons.person_rounded),
                ),
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  setState(() {
                    registerModel.email = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_rounded),
                ),
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  setState(() {
                    registerModel.password = value;
                  });
                },
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  prefixIcon: Icon(Icons.lock_rounded),
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    registerModel.passwordConfirmation = value;
                  });
                },
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirmation du mot de passe',
                  prefixIcon: Icon(Icons.lock_rounded),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 50)),
              ElevatedButton(
                onPressed: !isFormValid() ? null : () {
                  if(registerModel.username.isEmpty) {
                    PopupUtils.showError(context, 'Nom d\'utilisateur manquant', 'Veuillez entrer un nom d\'utilisateur');
                  } else if(registerModel.email.isEmpty) {
                    PopupUtils.showError(context, 'Email manquant', 'Veuillez entrer un email');
                  } else if(registerModel.password.isEmpty) {
                    PopupUtils.showError(context, 'Mot de passe manquant', 'Veuillez entrer un mot de passe');
                  } else if(registerModel.passwordConfirmation != registerModel.password) {
                    PopupUtils.showError(context, 'Confirmation du mot de passe incorrecte', 'Le mot de passe et la confirmation du mot de passe ne sont pas identiques');
                  } else {
                    PopupUtils.showError(context, "Impossible de communiquer avec le serveur", "Veuillez réessayer plus tard");
                  }
                },
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'S\'inscrire',
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
                    'Déja inscrit ?'
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.secondary,
                      ),
                      child: const Text('Connectez-vous')
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
    return registerModel.username.isNotEmpty && registerModel.email.isNotEmpty && registerModel.password.isNotEmpty && registerModel.passwordConfirmation.isNotEmpty;
  }
}