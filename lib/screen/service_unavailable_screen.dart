import 'package:aquatracking/component/action_button.dart';
import 'package:aquatracking/globals.dart';
import 'package:aquatracking/screen/home_screen.dart';
import 'package:aquatracking/screen/login_screen.dart';
import 'package:aquatracking/service/authentication_service.dart';
import 'package:flutter/material.dart';

class ServiceUnavailableScreen extends StatelessWidget {
  const ServiceUnavailableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationService authenticationService = AuthenticationService();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Service indisponible', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,)),
            const SizedBox(height: 20),
            ActionButton(
              text: "Réessayer",
              icon: Icons.refresh_rounded,
              width: 130,
              onPressed: () {
                String? refreshToken = prefs.getString('refresh_token');
                if(refreshToken != null) {
                  authenticationService.checkLogin(refreshToken).then((value) => {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => (!AuthenticationService.serviceAvailable) ? const ServiceUnavailableScreen() : (AuthenticationService.loggedIn) ? const HomeScreen() : const LoginScreen()))
                  });
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                }
              }
            )
          ],
        ),
      ),
    );
  }
}