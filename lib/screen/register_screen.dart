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
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text('Inscription',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  )),
              const Padding(padding: EdgeInsets.only(top: 50)),
              TextFormField(
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  registerModel.username = value;
                },
                cursorColor: Theme.of(context).primaryColor,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                decoration: InputDecoration(
                  labelText: 'Nom d\'utilisateur',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  icon: Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  registerModel.email = value;
                },
                cursorColor: Theme.of(context).primaryColor,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  icon: Icon(
                    Icons.email,
                    color: Theme.of(context).primaryColor,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  registerModel.password = value;
                },
                cursorColor: Theme.of(context).primaryColor,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  icon: Icon(
                    Icons.lock,
                    color: Theme.of(context).primaryColor,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  registerModel.passwordConfirmation = value;
                },
                cursorColor: Theme.of(context).primaryColor,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmation du mot de passe',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  icon: Icon(
                    Icons.lock,
                    color: Theme.of(context).primaryColor,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 50)),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color(0xFF0781d7);
                      }
                      return Theme.of(context)
                          .highlightColor; // Use the component's default.
                    },
                  ),
                ),
                onPressed: () {
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
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'S\'inscrire',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      Icon(
                        Icons.arrow_forward,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Déja inscrit ?',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  }, child: Text('Connectez-vous', style: TextStyle(color: Theme.of(context).highlightColor),)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}