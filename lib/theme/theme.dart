import 'package:app1/constants.dart';
import 'package:app1/theme/text_styles.dart';
import 'package:flutter/material.dart';


ThemeData createTheme() {
  return ThemeData(
    textTheme: TextTheme(
      ///screenHeight/8
      displayLarge: TextStyles.comfortaa(size: screenHeight/8).textStyle,
      ///screenHeight/13
      displayMedium: TextStyles.comfortaa(size: screenHeight/13).textStyle,
      ///screenHeight/14.5
      displaySmall: TextStyles.comfortaa(size: screenHeight/16).textStyle,
      ///screenHeight/20
      headlineLarge: TextStyles.comfortaa(size: screenHeight/20).textStyle,
      ///screenHeight/23
      headlineMedium: TextStyles.comfortaa(size: screenHeight/23).textStyle,
      ///screenHeight/23
      headlineSmall: TextStyles.comfortaa(size: screenHeight/27).textStyle,
      ///screenHeight/35
      titleLarge: TextStyles.comfortaa(size: 25).textStyle,
      ///screenHeight/40
      titleMedium: TextStyles.comfortaa(size: 22).textStyle,
      ///screenHeight/50
      titleSmall: TextStyles.comfortaa(size: 18).textStyle,
      ///screenHeight/49
      bodyLarge: TextStyles.comfortaa(size: 17).textStyle,
      ///screenHeight/56
      bodyMedium: TextStyles.comfortaa(size: 16).textStyle,
      ///screenHeight/60
      bodySmall: TextStyles.comfortaa(size: 15).textStyle,
      ///screenHeight/65
      labelLarge: TextStyles.comfortaa(size: 14).textStyle,
      ///screenHeight/71
      labelMedium: TextStyles.comfortaa(size: screenHeight/71).textStyle,
      ///(screenHeight/78
      labelSmall: TextStyles.comfortaa(size: screenHeight/78).textStyle,
    ),
    listTileTheme: ListTileThemeData(
      ///screenHeight/49
      titleTextStyle: TextStyles.comfortaa(size: screenHeight/49).textStyle,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyles.comfortaa(size: screenHeight/65).textStyle,
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
          size: screenHeight/40,
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