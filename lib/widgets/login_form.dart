import 'package:app1/bloc/authorization/authorization_bloc.dart';
import 'package:app1/pages/startPage.dart';
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
     
    return BlocListener<AuthorizationBloc, AuthorizationState>(
      listener: (context,state){
        if(state is AuthorizationSuccessful){
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const StartPage()));
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.12),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<AuthorizationBloc, AuthorizationState>(
                builder: (context, state) {
                  if (state is AuthorizationLoading) {
                    title = '';
                  } else if (state is AuthorizationError) {
                    title = state.error;
                  } else if(state is AuthorizationSuccessful){
                    title = 'Вход выполнен';
                  }
                  return SizedBox(
                    height: screenHeight / 10,
                    width: screenWidth,
                    child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge
                    ),
                  );
                },
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
                        RegExp(r'[a-zA-Zа-яА-Я0-9.@]'))
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
              Padding(padding: EdgeInsets.only(top: screenHeight / 60)),
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
              Padding(padding: EdgeInsets.only(top: screenHeight / 30)),
              BlocBuilder<AuthorizationBloc, AuthorizationState>(
                bloc: BlocProvider.of<AuthorizationBloc>(context),
                builder: (context, state) {
                  late Color color;
                  if (state is AuthorizationInitial) {
                    color = const Color.fromRGBO(0, 0, 0, 0.85);
                  } else if (state is AuthorizationLoading) {
                    color = const Color.fromRGBO(0, 0, 0, 0.55);
                  } else if (state is AuthorizationError) {
                    color = const Color.fromRGBO(0, 0, 0, 0.85);
                  } else {
                    color = const Color.fromRGBO(0, 0, 0, 0.55);
                  }
                  return ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (!(state is AuthorizationLoading ||
                            state is AuthorizationSuccessful)) {
                          BlocProvider.of<AuthorizationBloc>(context).add(AuthorizationEvent(email, password));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          foregroundColor: color,
                          fixedSize:
                          Size(screenWidth * 0.76, screenHeight * 0.06),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36),
                          )),
                      child: Container(
                        alignment: Alignment.center,
                        height: screenHeight * 0.06,
                        width: screenWidth * 0.76,
                        child: Text(
                            'Войти',
                            textAlign: TextAlign.justify,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppColors.white
                            )
                        ),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
