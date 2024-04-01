import 'package:aquatracking/globals.dart';
import 'package:aquatracking/navigator_service.dart';
import 'package:aquatracking/screen/login_screen.dart';
import 'package:aquatracking/screen/main_screen.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

initSharedPreferences() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
}

initDioService() async {
  dioService = Dio();

  persistCookieJar = PersistCookieJar(
      storage: FileStorage(
          (await getApplicationDocumentsDirectory()).path + "/.cookies/"));
  dioService.interceptors.add(CookieManager(persistCookieJar));

  dioService.options = BaseOptions(
    baseUrl: apiBaseUrl,
    headers: {
      "Accept": "application/json",
      "user-agent":
          "AquaTracking/1.0.0 (Android; 11) dart/2.12.0 (dart:io)", // TODO: Change user-agent with correct values
    },
    responseType: ResponseType.json,
  );

  dioService.interceptors.add(InterceptorsWrapper(
    onError: (error, handler) async {
      if (error.response?.statusCode == 401 &&
          error.response?.data["code"] == "NOT_LOGGED") {
        persistCookieJar.deleteAll();
        NavigationService().replaceScreen(const LoginScreen());
      } else {
        print("Error DIO: ");
        print(error.response?.data);
        handler.next(error);
      }
    },
  ));
}

void main() async {
  await initSharedPreferences();
  await initDioService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
        colorSchemeSeed: colorSeed,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: colorSeed,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const MainScreen(),
      navigatorKey: NavigationService().navigationKey,
      // home: (!AuthenticationService.serviceAvailable)
      //     ? const ServiceUnavailableScreen()
      //     : (AuthenticationService.loggedIn)
      //         ? const MainScreen()
      //         : const LoginScreen(),
    );
  }
}
