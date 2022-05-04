import 'package:aquatracking/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      title: 'AquaTracking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFFFFFFF),
        highlightColor: const Color(0xFF2ec1e2),
        backgroundColor: const Color(0xFF161616),

        fontFamily: 'Roboto'
      ),
      home: const LoginScreen(),
    );
  }
}
