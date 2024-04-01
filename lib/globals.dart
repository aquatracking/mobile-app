import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// add this '--dart-define="DEBUG=true"' in additional run args on flutter run for enable debug
bool debug = const bool.fromEnvironment('DEBUG');
String apiBaseUrlEnv = const String.fromEnvironment('API_BASE_URL');

String apiBaseUrl = (apiBaseUrlEnv.isNotEmpty)
    ? apiBaseUrlEnv
    : 'https://aquatracking.bryanprolong.fr/';
ImageProvider imagePlaceholder =
    Image.asset('assets/images/placeholder.jpg').image;
Color colorSeed = (debug) ? Colors.green : Colors.cyan;

late SharedPreferences prefs;
String username = '';

late PersistCookieJar persistCookieJar;

late Dio dioService;
