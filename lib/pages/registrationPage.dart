import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app1/pages/authorizationPage.dart';
// import 'package:app1/controllers/auth.dart' as auth;

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String myString = "Регистрация";
  String email = '';
  String name = '';
  String country = '';
  String password1 = '';
  String password2 = '';
  // void registration(String email, String name, String country, String password1, String password2) async
  // {
  //   print(email);
  //   final response = await auth.register(email, name, country, password1, password2);
  //   setState(() {
  //     my_string = response;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold (
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: screenHeight/22)),
            Container(
                alignment: Alignment.center,
                child:
                SvgPicture.asset(
                  'images/icon.svg',
                  colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.color), // Применение прозрачного фильтра
                  height: screenHeight/3.36,
                )
            ),
            Padding(padding: EdgeInsets.only(top: screenHeight/27)),
            Text(myString,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenHeight/29,
                fontFamily: 'Comfortaa',
                color: Colors.black,
              ),),
            Padding(padding: EdgeInsets.only(top: screenHeight/30)),
            SizedBox(
              width: screenWidth * 0.76,
              child: TextFormField(
                onChanged: (String value){
                  email = value;
                },
                style: TextStyle(
                    fontSize: screenHeight/40,
                    fontFamily: 'Comfortaa',
                    color: Colors.black
                ),
                decoration: InputDecoration(   hoverColor: Colors.orange,

                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: 'Почта',
                  hintStyle: TextStyle(
                      fontSize: screenHeight/40,
                      fontFamily: 'Comfortaa',
                      color: const Color.fromRGBO(0, 0, 0, 0.1)
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
            Padding(padding: EdgeInsets.only(top: screenHeight/60)),
            SizedBox(
              width: screenWidth * 0.76,
              child: TextFormField(

                onChanged: (String value){
                  name = value;
                },
                style: TextStyle(
                    fontSize: screenHeight/40,
                    fontFamily: 'Comfortaa',
                    color: Colors.black
                ),
                decoration: InputDecoration(   hoverColor: Colors.orange,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: 'Имя',
                  hintStyle: TextStyle(
                      fontSize: screenHeight/40,
                      fontFamily: 'Comfortaa',
                      color: const Color.fromRGBO(0, 0, 0, 0.1)
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
            Padding(padding: EdgeInsets.only(top: screenHeight/60)),
            SizedBox(
              width: screenWidth * 0.76,
              child: TextFormField(

                onChanged: (String value){
                  country = value;
                },
                style: TextStyle(
                    fontSize: screenHeight/40,
                    fontFamily: 'Comfortaa',
                    color: Colors.black
                ),
                decoration: InputDecoration(   hoverColor: Colors.orange,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: 'Страна',
                  hintStyle: TextStyle(
                      fontSize: screenHeight/40,
                      fontFamily: 'Comfortaa',
                      color: const Color.fromRGBO(0, 0, 0, 0.1)
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
            Padding(padding: EdgeInsets.only(top: screenHeight/60)),
            SizedBox(
              width: screenWidth * 0.76,
              child: TextFormField(

                onChanged: (String value){
                  password1 = value;
                },
                style: TextStyle(
                    fontSize: screenHeight/40,
                    fontFamily: 'Comfortaa',
                    color: Colors.black
                ),
                decoration: InputDecoration(   hoverColor: Colors.orange,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: 'Пароль',
                  hintStyle: TextStyle(
                      fontSize: screenHeight/40,
                      fontFamily: 'Comfortaa',
                      color: const Color.fromRGBO(0, 0, 0, 0.1)
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  contentPadding: EdgeInsets.only(bottom: -10),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: screenHeight/60)),
            SizedBox(
              width: screenWidth * 0.76,
              child: TextFormField(

                onChanged: (String value){
                  password2 = value;
                },
                style: TextStyle(
                    fontSize: screenHeight/40,
                    fontFamily: 'Comfortaa',
                    color: Colors.black
                ),
                decoration: InputDecoration(   hoverColor: Colors.orange,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: 'Подтвержение пароля',
                  hintStyle: TextStyle(
                      fontSize: screenHeight/40,
                      fontFamily: 'Comfortaa',
                      color: const Color.fromRGBO(0, 0, 0, 0.1)
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
            Padding(padding: EdgeInsets.only(top: screenHeight/30)),
            ElevatedButton(
                onPressed:
                    () {
                  // registration(email, name, country, password1, password2);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 0, 0, 0.85),
                    foregroundColor: const Color.fromRGBO(0, 0, 0, 0.85),
                    fixedSize: Size(screenWidth * 0.76, screenHeight * 0.055),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36),
                    )
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: screenHeight * 0.06,
                  width: screenWidth * 0.76,
                  child: Text('Регистрация',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: screenHeight/25,
                        fontFamily: 'Comfortaa',
                        color: Colors.white
                    ),
                  ),
                )
            ),
            Padding(padding: EdgeInsets.only(top: screenHeight/90)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center ,
              children: [
                Text('Уже зарегестрированы?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: screenHeight/70,
                      fontFamily: 'Comfortaa',
                      color: Colors.black
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: screenWidth/350)),
                GestureDetector(
                  onTap: () {
                    // Действия при нажатии на гипертекст
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthorizationPage()));
                  },
                  child: Text('Войдите в профиль',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: screenHeight/70,
                        fontFamily: 'Comfortaa',
                        color: Colors.black
                    ),
                  ),
                )

              ],
            ),

          ],
        )
    );
  }
}
