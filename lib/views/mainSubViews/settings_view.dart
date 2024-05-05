import 'package:aquatracking/services/navigator_service.dart';
import 'package:aquatracking/views/auth/login_view.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          NavigationService().replaceScreen(const LoginView());
        },
        child: const Text('Logout'),
      ),
    );
  }
}
