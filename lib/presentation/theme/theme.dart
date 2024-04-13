import '../constants.dart';
import '../theme/text_styles.dart';
import 'package:flutter/material.dart';


ThemeData createTheme() {
  return ThemeData(
    textTheme: TextTheme(
      ///120
      displayLarge: TextStyles.comfortaa(size: 120).textStyle,
      ///74
      displayMedium: TextStyles.comfortaa(size: 74).textStyle,
      ///60
      displaySmall: TextStyles.comfortaa(size: 60).textStyle,
      ///48
      headlineLarge: TextStyles.comfortaa(size: 48).textStyle,
      ///41
      headlineMedium: TextStyles.comfortaa(size: 41).textStyle,
      ///35
      headlineSmall: TextStyles.comfortaa(size: 35).textStyle,
      ///25
      titleLarge: TextStyles.comfortaa(size: 25).textStyle,
      ///22
      titleMedium: TextStyles.comfortaa(size: 22).textStyle,
      ///18
      titleSmall: TextStyles.comfortaa(size: 18).textStyle,
      ///17
      bodyLarge: TextStyles.comfortaa(size: 17).textStyle,
      ///16
      bodyMedium: TextStyles.comfortaa(size: 16).textStyle,
      ///15
      bodySmall: TextStyles.comfortaa(size: 15).textStyle,
      ///14
      labelLarge: TextStyles.comfortaa(size: 14).textStyle,
      ///13
      labelMedium: TextStyles.comfortaa(size: 13).textStyle,
      ///12
      labelSmall: TextStyles.comfortaa(size: 12).textStyle,
    ),
    listTileTheme: ListTileThemeData(
      ///17
      titleTextStyle: TextStyles.comfortaa(size: 17).textStyle,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyles.comfortaa(size: 14).textStyle,
    ),
    // inputDecorationTheme: InputDecorationTheme(
    //   ///bodyLarge
    //   //labelStyle: TextStyles.comfortaa(size: 17).textStyle,
    //   floatingLabelStyle: TextStyles.comfortaa(size:20).textStyle
    // ),
    scaffoldBackgroundColor: AppColors.backGroundColor,
    appBarTheme: AppBarTheme(
      shadowColor: Colors.black.withOpacity(0.2),
      backgroundColor: AppColors.elementColor,
      titleTextStyle: TextStyles.comfortaa(
          size: 22,
          color: AppColors.textAdditionalColor
      ).textStyle,
    ),
    menuTheme: const MenuThemeData(
      style: MenuStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(AppColors.white),
          shape: MaterialStatePropertyAll<OutlinedBorder?>(RoundedRectangleBorder ()),
          side: MaterialStatePropertyAll<BorderSide?>(BorderSide(
              width: 2
          ))
      )
    )
  );
}