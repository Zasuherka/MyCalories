import 'package:app1/bloc/authorization/authorization_bloc.dart';
import 'package:app1/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});
  @override
  Widget build(BuildContext context) {
    String title = 'Добро пожаловать';
    String email = '';
    String password = '';
    bool buttonIsActive = true;
     
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.12),
      child: Form(
        child: BlocBuilder<AuthorizationBloc, AuthorizationState>(
          builder: (context, state) {
            state.when(
                initial: () => buttonIsActive = true,
                loading: () => buttonIsActive = false,
                error: (error) {
                  title = error;
                  buttonIsActive = true;
                },
                successful: () {
                  title = 'Вход выполнен';
                  buttonIsActive = false;
                }
            );
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  height: screenHeight / 10,
                  width: screenWidth,
                  child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        height: 1
                      )
                  ),
                ),
                SizedBox(height: screenHeight/30),
                SizedBox(
                  width: screenWidth * 0.76,
                  child: TextField(
                    onChanged: (String value) {
                      email = value;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Zа-яА-Я0-9.@-]'))
                    ],
                    style: Theme.of(context).textTheme.titleMedium,
                    decoration: InputDecoration(
                      hoverColor: Colors.orange,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: 'Почта',
                      hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.colorForHintText
                      ),
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
                SizedBox(
                  height: screenHeight / 60,
                ),
                SizedBox(
                  width: screenWidth * 0.76,
                  child: TextField(
                    obscureText: true,
                    onChanged: (String value) {
                      password = value;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Zа-яА-Я0-9]'))
                    ],
                    style: Theme.of(context).textTheme.titleMedium,
                    decoration: InputDecoration(
                      hoverColor: Colors.orange,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: 'Пароль',
                      hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.colorForHintText
                      ),
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
                SizedBox(
                  height: screenHeight / 50,
                ),
                GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      if (buttonIsActive) {
                        BlocProvider.of<AuthorizationBloc>(context).add(
                            AuthorizationEvent.auth(
                                email: email, password: password));
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: screenHeight * 0.05,
                      width: screenWidth * 0.76,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xff21e9ce),
                                Color(0xff01c57c),
                              ]
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: AppColors.dark.withOpacity(0.3),
                                offset: const Offset(0,10),
                                blurRadius: 10,
                                blurStyle: BlurStyle.normal
                            )
                          ]
                      ),
                      child: Text(
                          'Войти',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.white
                          )
                      ),
                    )
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
