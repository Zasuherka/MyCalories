import 'package:app1/internal/bloc/registration/registration_bloc.dart';
import 'package:app1/internal/bloc/registration/registration_event.dart';
import 'package:app1/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingUpForm extends StatelessWidget {
  const SingUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    String email = '';
    String name = '';
    String password1 = '';
    String password2 = '';
    bool buttonIsActive = true;
    String title = 'Для регистрации заполните все поля';
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.12
      ),
      child: Form(
          child: BlocBuilder<RegistrationBloc, RegistrationState>(
            builder: (context, state){
              state.whenOrNull(
                  initial: () => buttonIsActive = true,
                  successful: () {
                    title = 'Регистрация прошла успешно. Вам на почту отправлено письмо. Подтвердите почту.';
                    buttonIsActive = false;
                  },
                  loading: () {
                    title = '';
                    buttonIsActive = false;
                  },
                  error: (error) {
                    title = error;
                    buttonIsActive = true;
                  }
              );
              return Column(
                mainAxisAlignment: MainAxisAlignment.center ,
                children: [
                  SizedBox(
                    height: screenHeight / 8,
                    width: screenWidth,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.primaryButtonColor,
                          height: 1
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight / 200),
                  SizedBox(
                    width: screenWidth * 0.76,
                    child: TextField(
                      onChanged: (String value) {
                        email = value.toString();
                      },
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я0-9.@-]'))],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.primaryButtonColor
                      ),
                      decoration: InputDecoration(
                        hoverColor: Colors.orange,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: 'Почта',
                        hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.primaryButtonColor.withOpacity(0.8)
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
                      onChanged: (String value) {
                        name = value;
                      },
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я0-9. ]'))],
                      maxLength: 20,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.primaryButtonColor
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        hoverColor: Colors.orange,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: 'Имя',
                        hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.primaryButtonColor.withOpacity(0.8)
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
                        password1 = value;
                      },
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я0-9]'))],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.primaryButtonColor
                      ),
                      decoration: InputDecoration(
                        hoverColor: Colors.orange,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: 'Пароль',
                        hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.primaryButtonColor.withOpacity(0.8)
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
                        password2 = value;
                      },
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я0-9]'))],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.primaryButtonColor
                      ),
                      decoration: InputDecoration(
                        hoverColor: Colors.orange,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: 'Повторите пароль',
                        hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.primaryButtonColor.withOpacity(0.8)
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
                    onTap: () {
                      if (buttonIsActive){
                        context.read<RegistrationBloc>()
                            .add(RegistrationEvent(name,email,password1,password2));
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: screenHeight * 0.05,
                      width: screenWidth * 0.76,
                      decoration: BoxDecoration(
                          color: AppColors
                              .primaryButtonColor.withOpacity(buttonIsActive ? 1 : 0.65),
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
                          'Регистрация',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.dark
                          )
                      ),
                    )
                  ),
                ],
              );
            },
          ),
      ),
    );
  }
}
