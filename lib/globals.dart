import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String apiBaseUrl = 'http://192.168.1.252:3001';
ImageProvider imagePlaceholder = Image.asset('assets/images/placeholder.jpg').image;


late SharedPreferences prefs;