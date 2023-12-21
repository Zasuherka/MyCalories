import 'package:app1/bloc/registration/registration_bloc.dart';
import 'package:app1/bloc/registration/registration_event.dart';
import 'package:app1/bloc/registration/registration_state.dart';
import 'package:app1/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingUpForm extends StatefulWidget {
  const SingUpForm({super.key});

  @override
  State<SingUpForm> createState() => _SingUpFormState();
}

class _SingUpFormState extends State<SingUpForm> {
  String email = '';
  String name = '';
  String password1 = '';
  String password2 = '';
  @override
  Widget build(BuildContext context) {
    String title = 'Добро пожаловать';

     
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.12
      ),
      child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center ,
            children: [
              BlocBuilder<RegistrationBloc, RegistrationState>(
                builder: (context, state){
                  if (state is RegistrationInitial){
                    title = 'Для регистрации заполните все поля';
                  } else
                  if (state is RegistrationLoading){
                    title = '';
                  } else if(state is RegistrationError){
                    title = state.error;
                  } else if (state is RegistrationSuccessful){
                    title = 'Регистрация прошла успешно.\nВам на почту отправлено письмо.\nПодтвердите почту.';
                  }
                  return SizedBox(
                    height: screenHeight / 12,
                    width: screenWidth,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.backGroundColor
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: screenHeight / 30),
              SizedBox(
                width: screenWidth * 0.76,
                child: TextField(
                  onChanged: (String value) {
                    email = value.toString();
                  },
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я0-9.@]'))],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.backGroundColor
                  ),
                  decoration: InputDecoration(
                    hoverColor: Colors.orange,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: 'Почта',
                    hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.backGroundColor.withOpacity(0.3)
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
                  onChanged: (String value) {
                    name = value;
                  },
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я0-9. ]'))],
                  maxLength: 20,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.backGroundColor
                  ),
                  decoration: InputDecoration(
                    hoverColor: Colors.orange,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: 'Имя',
                    hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.backGroundColor.withOpacity(0.3)
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
                    password1 = value;
                  },
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я0-9]'))],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.backGroundColor
                  ),
                  decoration: InputDecoration(
                    hoverColor: Colors.orange,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: 'Пароль',
                    hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.backGroundColor.withOpacity(0.3)
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
                    password2 = value;
                  },
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я0-9]'))],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.backGroundColor
                  ),
                  decoration: InputDecoration(
                    hoverColor: Colors.orange,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: 'Повторите пароль',
                    hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.backGroundColor.withOpacity(0.3)
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
              BlocBuilder(bloc: BlocProvider.of<RegistrationBloc>(context),
                  builder: (context, state) {
                    late Color color;
                    if (state is RegistrationLoading || state is RegistrationSuccessful){
                      color = AppColors.backGroundColor.withOpacity(0.65);
                    }
                    else {
                      color = AppColors.backGroundColor;
                    }
                    return ElevatedButton(
                        onPressed: () {
                          if (!(state is RegistrationLoading ||
                              state is RegistrationSuccessful)){
                            BlocProvider.of<RegistrationBloc>(context).add(RegistrationEvent(name,email,password1,password2));
                          }
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
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppColors.dark
                            ),
                          ),
                        ));
                  }),
            ],
          )),
    );
  }
}
