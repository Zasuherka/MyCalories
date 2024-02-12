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
      ///screenHeight/1648
      headlineLarge: TextStyles.comfortaa(size: screenHeight/20).textStyle,
      ///screenHeight/1648
      headlineMedium: TextStyles.comfortaa(size: screenHeight/23).textStyle,
      ///screenHeight/23
      headlineSmall: TextStyles.comfortaa(size: screenHeight/27).textStyle,
      ///screenHeight/35
      titleLarge: TextStyles.comfortaa(size: screenHeight/35).textStyle,
      ///screenHeight/40
      titleMedium: TextStyles.comfortaa(size: screenHeight/40).textStyle,
      ///screenHeight/50
      titleSmall: TextStyles.comfortaa(size: screenHeight/45).textStyle,
      ///screenHeight/49
      bodyLarge: TextStyles.comfortaa(size: screenHeight/49).textStyle,
      ///screenHeight/56
      bodyMedium: TextStyles.comfortaa(size: screenHeight/56).textStyle,
      ///screenHeight/65
      bodySmall: TextStyles.comfortaa(size: screenHeight/65).textStyle,
      ///screenHeight/65
      labelLarge: TextStyles.comfortaa(size: screenHeight/65).textStyle,
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
    scaffoldBackgroundColor: AppColors.backGroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.turquoise ,
      titleTextStyle: TextStyles.comfortaa(size: screenHeight/40, color: AppColors.white).textStyle,
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