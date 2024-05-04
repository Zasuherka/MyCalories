import '../constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class TextStyles {
  final TextStyle textStyle;

  TextStyles.comfortaa({required double size, Color? color}) : textStyle = TextStyle(
    //fontWeight: FontWeight.w100,
    fontSize: size,
    fontFamily: 'Comfortaa',
    color: color ?? AppColors.secondaryTextColor
  );

  TextStyle updateColor(Color color){
    return textStyle.copyWith(
      color: color
    );
  }

  // TextStyle changeColorAndColor({Color? color, double? fontSize}){
  //   color = color ?? textStyle.color;
  //   fontSize = fontSize ?? textStyle.fontSize;
  //   return textStyle.copyWith(
  //       fontSize: fontSize,
  //       color: color
  //   );
  // }
}