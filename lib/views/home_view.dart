import 'package:aquatracking/models/user/user_model.dart';
import 'package:aquatracking/repository/user_repository.dart';
import 'package:aquatracking/services/navigator_service.dart';
import 'package:aquatracking/views/auth/login_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  UserModel? user;
  UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      userRepository.getMe().then((value) {
        user = value;
        setState(() {});
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home ${user?.email ?? 'loading'}'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            NavigationService().replaceScreen(const LoginView());
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
