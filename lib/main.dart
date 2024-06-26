import 'package:aquatracking/repository/repository.dart';
import 'package:aquatracking/services/navigator_service.dart';
import 'package:aquatracking/styles.dart';
import 'package:aquatracking/views/connecting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Repository.init();

  Bloc.observer = const AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AquaTracking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: AppTheme.colorSeed,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: AppTheme.colorSeed,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const ConnectingView(),
      navigatorKey: NavigationService().navigationKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
