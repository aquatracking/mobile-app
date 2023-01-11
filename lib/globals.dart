import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// add this '--dart-define="DEBUG=true"' in additional run args on flutter run for enable debug
bool debug = const bool.fromEnvironment('DEBUG');

String apiBaseUrl = (debug) ? 'http://localhost:3000' : 'https://aquatracking.bryanprolong.fr';
ImageProvider imagePlaceholder = Image.asset('assets/images/placeholder.jpg').image;
Color colorSeed = (debug) ? Colors.green : Colors.cyan;


late SharedPreferences prefs;