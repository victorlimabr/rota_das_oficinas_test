import 'package:flutter/material.dart';

final _colorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
final challengesTheme = ThemeData(
  colorScheme: _colorScheme,
  useMaterial3: true,
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: _colorScheme.secondaryContainer),
    ),
    filled: true,
    fillColor: Colors.white.withOpacity(0.4),
    hoverColor: _colorScheme.onSecondary,
  ),
);
