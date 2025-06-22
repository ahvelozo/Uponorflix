import 'package:flutter/material.dart';
import 'package:uponorflix/theme/color_schemes.dart';
import 'package:uponorflix/theme/text_theme.dart';

class FlutterTagTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      fontFamily: 'Roboto',
      textTheme: textTheme,
      popupMenuTheme: const PopupMenuThemeData(
        position: PopupMenuPosition.under,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      fontFamily: 'Roboto',
      textTheme: textTheme,
      popupMenuTheme: const PopupMenuThemeData(
        position: PopupMenuPosition.under,
      ),
    );
  }
}
