import 'package:aquatracking/globals.dart';
import 'package:aquatracking/screen/main_screen.dart';
import 'package:aquatracking/screen/login_screen.dart';
import 'package:aquatracking/screen/service_unavailable_screen.dart';
import 'package:aquatracking/service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

initSharedPreferences() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  String? refreshToken = prefs.getString('refresh_token');

  if(refreshToken != null) {
    AuthenticationService authenticationService = AuthenticationService();
    await authenticationService.checkLogin(refreshToken);
  }
}

void main() async {
  await initSharedPreferences();
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
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale("en"),
        Locale("fr"),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: Colors.cyan,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.cyan,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: (!AuthenticationService.serviceAvailable) ? const ServiceUnavailableScreen() : (AuthenticationService.loggedIn) ? const MainScreen() : const LoginScreen(),
    );
  }
}
