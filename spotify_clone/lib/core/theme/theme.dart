import 'package:flutter/material.dart';
import 'package:spotify_clone/core/theme/app_pallet.dart';

class AppTheme {
  static OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 3),
      borderRadius: BorderRadius.circular(10),
    );
  }

  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Pallete.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(27),
        enabledBorder: _border(Pallete.backgroundColor),
        focusedBorder: _border(Pallete.gradient2),
      ));
}
