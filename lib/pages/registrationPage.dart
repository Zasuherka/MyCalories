import 'package:app1/bloc/registration/registration_bloc.dart';
import 'package:app1/bloc/registration/registration_event.dart';
import 'package:app1/bloc/registration/registration_state.dart';
import 'package:app1/pages/authorizationPage.dart';
import 'package:app1/service/UserSirvice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String email = '';
  String name = '';
  String password1 = '';
  String password2 = '';

  // Future<void> registration(String email, String name, String password1, String password2) async
  // {
  //   final response = await register(email, name,  password1, password2);
  //   setState(() {
  //     this.response = response;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final RegistrationBloc registrationBloc = RegistrationBloc();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider<RegistrationBloc>(
      create: (context) => registrationBloc,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(top: screenHeight / 22)),
              Container(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'images/icon.svg',
                    colorFilter: const ColorFilter.mode(
                        Colors.transparent, BlendMode.color),
                    // Применение прозрачного фильтра
                    height: screenHeight / 3.36,
                  )),
              Padding(padding: EdgeInsets.only(top: screenHeight / 27)),
              BlocBuilder(bloc: registrationBloc,
                  builder: (context, state) {
                late String title;
                if (state is RegistrationInitial){
                  title = 'Для регистрации заполните все поля';
                } else
                if (state is RegistrationLoading){
                  title = '';
                } else if(state is RegistrationError){
                  title = state.error;
                } else{
                  title = 'Регистрация прошла успешно.\nВам на почту отправлено письмо.\nПодтвердите почту.';
                }
                return SizedBox(
                  height: screenHeight / 15,
                  width: screenWidth,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenHeight / 50,
                      fontFamily: 'Comfortaa',
                      color: Colors.black,
                    ),
                  ),
                );
              }),
              Padding(padding: EdgeInsets.only(top: screenHeight / 30)),
              SizedBox(
                width: screenWidth * 0.76,
                child: TextField(
                  onChanged: (String value) {
                    email = value.toString();
                  },
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я0-9.@]'))],
                  style: TextStyle(
                      fontSize: screenHeight / 40,
                      fontFamily: 'Comfortaa',
                      color: Colors.black),
                  decoration: InputDecoration(
                    hoverColor: Colors.orange,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: 'Почта',
                    hintStyle: TextStyle(
                        fontSize: screenHeight / 40,
                        fontFamily: 'Comfortaa',
                        color: const Color.fromRGBO(0, 0, 0, 0.1)),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                    contentPadding: const EdgeInsets.only(bottom: -10),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: screenHeight / 60)),
              SizedBox(
                width: screenWidth * 0.76,
                child: TextField(
                  onChanged: (String value) {
                    name = value;
                  },
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я0-9. ]'))],

                  style: TextStyle(
                      fontSize: screenHeight / 40,
                      fontFamily: 'Comfortaa',
                      color: Colors.black),
                  decoration: InputDecoration(
                    hoverColor: Colors.orange,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: 'Имя',
                    hintStyle: TextStyle(
                        fontSize: screenHeight / 40,
                        fontFamily: 'Comfortaa',
                        color: const Color.fromRGBO(0, 0, 0, 0.1)),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                    contentPadding: const EdgeInsets.only(bottom: -10),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: screenHeight / 60)),
              SizedBox(
                width: screenWidth * 0.76,
                child: TextField(
                  onChanged: (String value) {
                    password1 = value;
                  },
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я0-9]'))],
                  style: TextStyle(
                      fontSize: screenHeight / 40,
                      fontFamily: 'Comfortaa',
                      color: Colors.black),
                  decoration: InputDecoration(
                    hoverColor: Colors.orange,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: 'Пароль',
                    hintStyle: TextStyle(
                        fontSize: screenHeight / 40,
                        fontFamily: 'Comfortaa',
                        color: const Color.fromRGBO(0, 0, 0, 0.1)),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                    contentPadding: const EdgeInsets.only(bottom: -10),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: screenHeight / 60)),
              SizedBox(
                width: screenWidth * 0.76,
                child: TextField(
                  onChanged: (String value) {
                    password2 = value;
                  },
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я0-9]'))],
                  style: TextStyle(
                      fontSize: screenHeight / 40,
                      fontFamily: 'Comfortaa',
                      color: Colors.black),
                  decoration: InputDecoration(
                    hoverColor: Colors.orange,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: 'Подтвержение пароля',
                    hintStyle: TextStyle(
                        fontSize: screenHeight / 40,
                        fontFamily: 'Comfortaa',
                        color: const Color.fromRGBO(0, 0, 0, 0.1)),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                    contentPadding: const EdgeInsets.only(bottom: -10),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: screenHeight / 30)),
              BlocBuilder(bloc: registrationBloc,
                  builder: (context, state) {
                late Color color;
                if (state is RegistrationInitial){
                  color = const Color.fromRGBO(0, 0, 0, 0.85);
                } else
                if (state is RegistrationLoading){
                  color = const Color.fromRGBO(0, 0, 0, 0.55);
                } else if(state is RegistrationError){
                  color = const Color.fromRGBO(0, 0, 0, 0.85);
                } else{
                  color = const Color.fromRGBO(0, 0, 0, 0.55);
                }
                return ElevatedButton(
                    onPressed: () {
                      registrationBloc.add(RegistrationEvent(name,email,password1,password2));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        foregroundColor: color,
                        fixedSize: Size(screenWidth * 0.76, screenHeight * 0.055),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        )),
                    child: Container(
                      alignment: Alignment.center,
                      height: screenHeight * 0.06,
                      width: screenWidth * 0.76,
                      child: Text(
                        'Регистрация',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: screenHeight / 25,
                            fontFamily: 'Comfortaa',
                            color: Colors.white),
                      ),
                    ));
              }),
              Padding(padding: EdgeInsets.only(top: screenHeight / 90)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Уже зарегестрированы?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: screenHeight / 70,
                        fontFamily: 'Comfortaa',
                        color: Colors.black),
                  ),
                  Padding(padding: EdgeInsets.only(right: screenWidth / 350)),
                  GestureDetector(
                    onTap: () {
                      // Действия при нажатии на гипертекст
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AuthorizationPage()));
                    },
                    child: Text(
                      'Войдите в профиль',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: screenHeight / 70,
                          fontFamily: 'Comfortaa',
                          color: Colors.black),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
