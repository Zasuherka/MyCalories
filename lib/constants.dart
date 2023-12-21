import 'package:flutter/material.dart';

part 'package:app1/theme/colors.dart';

const Duration animationDurationFast = Duration(milliseconds: 300);
const Duration animationDurationMedium = Duration(milliseconds: 400);
const Duration animationDurationLong = Duration(milliseconds: 600);

double? _screenWidth;
double? _screenHeight;

double get screenHeight {
  if(_screenHeight == null){
    throw '_screenHeight = null. Возможно вы не использовали обязательный метод addScreenSize\n'
        'Перед использованием размеров экрана, нужно обратиться к методу addScreenSize';
  }
  return _screenHeight!;
}

double get screenWidth {
  if(_screenWidth == null){
    throw '_screenWidth = null. Возможно вы не использовали обязательный метод addScreenSize\n'
        'Перед использованием размеров экрана, нужно обратиться к методу addScreenSize';
  }
  return _screenWidth!;
}

///Обязателен для использования размеров экрана
void addScreenSize(BuildContext context){
  _screenWidth = MediaQuery.of(context).size.width;
  _screenHeight = MediaQuery.of(context).size.height;
}