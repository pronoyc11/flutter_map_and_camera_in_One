import 'package:flutter/material.dart';
import 'package:map_integration_app1/tabs_screen.dart';

final kColorScheme = ColorScheme.fromSeed(seedColor: Colors.green.shade700);
void main() {
  runApp(MaterialApp(
    title: "Map_integration",
    theme:ThemeData().copyWith(
      colorScheme: kColorScheme,
      appBarTheme: AppBarTheme(
        foregroundColor: kColorScheme.onPrimary,
        backgroundColor: kColorScheme.primary,
      ),
      textTheme: ThemeData().textTheme.copyWith(
        titleLarge: const TextStyle(color: Colors.white),
        titleMedium: const TextStyle(color: Colors.white),
        titleSmall: const TextStyle(color: Colors.white),
      )
     
    ),
    home: const TabsScreen() ,
  ));
}

