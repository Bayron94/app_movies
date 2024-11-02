import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.red,
  Colors.black,
  Colors.deepOrange,
  Colors.redAccent,
  Colors.brown,
  Colors.grey,
  Colors.deepPurple,
];

// Paleta de colores para un tema inspirado en películas
const Color customPrimaryColor = Color(0xFF1C1C1E);
const Color customSecondaryColor = Color(0xFFB71C1C);
const Color customAccentColor = Color(0xFFD32F2F);
const Color customBackground = Color(0xFF121212);
const Color customTextColor = Color(0xFFE0E0E0);
const Color customHintColor = Color(0xFF757575);

class AppTheme {
  final int selectedColor;
  final bool isDarkmode;

  AppTheme({
    this.selectedColor = 0,
    this.isDarkmode = false,
  })  : assert(selectedColor >= 0, 'Selected color must be greater than 0'),
        assert(
          selectedColor < colorList.length,
          'Selected color must be less than ${colorList.length}',
        );

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
        primaryColor: customPrimaryColor,
        colorScheme: ColorScheme(
          brightness: isDarkmode ? Brightness.dark : Brightness.light,
          primary: customPrimaryColor,
          onPrimary: Colors.white,
          secondary: customSecondaryColor,
          onSecondary: Colors.white,
          error: Colors.redAccent,
          onError: Colors.white,
          background: customBackground,
          onBackground: customTextColor,
          surface: customPrimaryColor,
          onSurface: customTextColor,
        ),

        //* AppBar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: customPrimaryColor,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),

        //* Filled Button Theme
        filledButtonTheme: FilledButtonThemeData(
          style: TextButton.styleFrom(
            fixedSize: const Size.fromHeight(70),
            foregroundColor: Colors.white,
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            backgroundColor: customSecondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),

        //* Text inputs
        inputDecorationTheme: _inputDecorations,

        //* Dropdown Menu Theme
        dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: _inputDecorations,
          textStyle: const TextStyle(color: customTextColor),
        ),
      );

  final _inputDecorations = InputDecorationTheme(
    fillColor: customBackground,
    filled: true,
    hintStyle: const TextStyle(color: customHintColor),
    labelStyle: const TextStyle(color: customTextColor),
    enabledBorder: buildBorderColor(customAccentColor),
    focusedBorder: buildBorderColor(customSecondaryColor),
    border: buildBorderColor(customAccentColor),
  );

  static OutlineInputBorder buildBorderColor(Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: BorderSide(
        color: borderColor,
        width: 1.5,
      ),
    );
  }
}
