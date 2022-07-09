import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String apiBaseUrl = 'https://aquatracking.bryanprolong.fr';
ImageProvider imagePlaceholder = Image.asset('assets/images/placeholder.jpg').image;


late SharedPreferences prefs;