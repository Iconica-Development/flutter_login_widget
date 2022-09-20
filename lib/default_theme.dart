import 'package:flutter/material.dart';

const textColor = const Color(0xFF3F413C);

ThemeData defaultTheme = ThemeData(
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 50,
      fontWeight: FontWeight.bold,
      color: textColor,
    ),
    headline2: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: textColor,
    ),
    headline3: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: textColor,
    ),
    headline4: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: textColor,
    ),
    headline5: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: textColor,
    ),
    headline6: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: textColor,
    ),
    bodyText1: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    caption: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: textColor,
    ),
    button: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: textColor,
    ),
    subtitle2: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: textColor,
    ),
  ),
  primaryColor: const Color(0xFF422F59),
  backgroundColor: const Color(0xFFF0F0F9),
  errorColor: Colors.red.shade500,
  cardColor: const Color(0xFFFFFFFF),
  colorScheme: ThemeData().colorScheme.copyWith(
        primary: const Color(0xFF422F59),
        secondary: const Color(0xFF07A2AD),
      ),
  buttonTheme: ButtonThemeData(
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: const Color(0xFF1C0C1C),
        ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xFF422F59),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 1.0,
        color: Color(0xFF422F59),
      ),
    ),
    focusColor: const Color(0xFF422F59),
    fillColor: const Color(0xFFFFFFFF),
  ),
);

bool isFlutterDefaultTheme(BuildContext buildContext) {
  var localizations = Localizations.of<MaterialLocalizations>(
    buildContext,
    MaterialLocalizations,
  );

  var category = localizations?.scriptCategory ?? ScriptCategory.englishLike;

  return Theme.of(buildContext) ==
      ThemeData.localize(
        ThemeData.fallback(),
        ThemeData.fallback().typography.geometryThemeFor(category),
      );
}
