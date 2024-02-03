import 'dart:math';
import 'package:app1/constants.dart';
import 'package:app1/widgets/login_form.dart';
import 'package:app1/widgets/sing_up_form.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with SingleTickerProviderStateMixin {
  bool _isShowSingUp = false;

  late AnimationController _animationController;
  final Cubic curve = Curves.easeOutBack;
  late Animation<double> _animationTextRotate;

  void setUpAnimation(){
    _animationController = AnimationController(vsync: this, duration:  animationDurationMedium);
    _animationTextRotate = Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  void updateView(){
    setState(() {
      _isShowSingUp = !_isShowSingUp;
    });
    _isShowSingUp
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setUpAnimation();
  }
  @override
  Widget build(BuildContext context) {
    final bool isShowLogo = MediaQuery.of(context).viewInsets.bottom > 0
        ? false
        : true;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: AnimatedBuilder(
        animation: _animationController,
        //child: _isShowSingUp? const LoginForm() : const SingUpForm(),
        builder: (context, _){
          return Stack(
            children: [
              AnimatedPositioned(
                  duration:  animationDurationMedium,
                  width: screenWidth  * 0.88,
                  height: screenHeight,
                  bottom: 0,
                  left: _isShowSingUp ?  -screenWidth * 0.76 : 0,
                  child: GestureDetector(
                    onTap: () => setState(() {
                      FocusScope.of(context).unfocus();
                      if (!_isShowSingUp){
                        _isShowSingUp = !_isShowSingUp;
                      }
                      updateView();
                    }),
                    child: Container(
                      color: AppColors.white,
                      child: const LoginForm(),
                    ),
                  )
              ),
              AnimatedPositioned(
                  duration:  animationDurationMedium,
                  width: screenWidth  * 0.88,
                  height: screenHeight,
                  bottom: 0,
                  left: _isShowSingUp ? screenWidth * 0.12 : screenWidth * 0.88,
                  child: GestureDetector(
                    onTap: () => setState(() {
                      FocusScope.of(context).unfocus();
                      if (_isShowSingUp){
                        _isShowSingUp = !_isShowSingUp;
                      }
                      updateView();
                    }),
                    child: Container(
                      //color: AppColors.dark,
                      decoration: const BoxDecoration(
                        gradient: AppColors.greenGradient
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: screenHeight/13),
                        child: const SingUpForm(),
                      ),
                    ),
                  )
              ),
              AnimatedPositioned(
                duration: animationDurationMedium,
                left: !_isShowSingUp ? screenWidth*0.19 : screenWidth*0.31,
                right: _isShowSingUp ? screenWidth*0.19 : screenWidth*0.31,
                top: screenHeight * 0.05,
                child: isShowLogo ? SvgPicture.asset(
                  'images/icon.svg',
                  colorFilter: const ColorFilter.mode(
                      Colors.transparent, BlendMode.color),
                  // Применение прозрачного фильтра
                  width: screenWidth * 0.5,
                ) : const SizedBox(),
              ),
              AnimatedPositioned(
                curve: curve,
                duration:  animationDurationMedium,
                bottom: _isShowSingUp ? screenHeight/2 - screenWidth/5 : screenHeight * 0.15,
                left: _isShowSingUp ? 0 : screenWidth * 0.44 - screenWidth / 5,
                child: AnimatedDefaultTextStyle(
                  duration:  animationDurationMedium,
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: _isShowSingUp ? screenHeight/27 : screenHeight/23,
                      color: _isShowSingUp ? AppColors.dark : Colors.transparent
                  ),
                  textAlign: TextAlign.center,
                  child: Transform.rotate(
                    alignment: Alignment.topLeft,
                    angle: -_animationTextRotate.value * pi / 180,
                    child: GestureDetector(
                      onTap: (){
                        FocusScope.of(context).unfocus();
                        if (_isShowSingUp){
                          FocusScope.of(context).unfocus();
                          updateView();
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.only(
                              top: _isShowSingUp ? screenHeight/100 : 0
                          ),
                          width: screenWidth/2.5,
                          child: Text('Вход'.toUpperCase()),
                        ),
                    ),

                  ),
                ),
              ),
              AnimatedPositioned(
                curve: curve,
                duration:  animationDurationMedium,
                bottom: _isShowSingUp ? screenHeight * 0.1 : screenHeight/2 - screenWidth/2.8,
                right: _isShowSingUp ? screenWidth * 0.44 - screenWidth / 2.8 : 0,
                child: AnimatedDefaultTextStyle(
                  duration:  animationDurationMedium,
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: _isShowSingUp ? screenHeight/23 : screenHeight/27,
                      color:  _isShowSingUp ? Colors.transparent : AppColors.white
                  ),
                  textAlign: TextAlign.center,
                  child: Transform.rotate(
                    alignment: Alignment.topRight,
                    angle: (90-_animationTextRotate.value) * pi / 180,
                    child: GestureDetector(
                      onTap: (){
                        FocusScope.of(context).unfocus();
                        if (!_isShowSingUp){
                          updateView();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: _isShowSingUp ? 0 : screenHeight/100
                        ),
                        width: screenWidth/1.4,
                        child: Text('Регистрация'.toUpperCase()),
                      ),
                    ),

                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
