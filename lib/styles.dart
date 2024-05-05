import 'package:flutter/material.dart';

class AppTheme {
  static const Color colorSeed = Colors.lime;
}

class AppSpacing {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
}

class AppText {
  static const TextStyle titleLarge = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle titleMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle titleSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subTitleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle subTitleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
}

class AppBreakpoints {
  static const double compact = 600;
  static const double medium = 840;
  static const double expanded = 1200;
}
