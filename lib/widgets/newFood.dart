import 'package:app1/bloc/foodBloc/food_bloc.dart';
import 'package:app1/validation/foodValidator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../service/foodService.dart';


class NewFood extends StatefulWidget {
  const NewFood({super.key});

  @override
  State<NewFood> createState() => _NewFoodState();
}

class _NewFoodState extends State<NewFood> {
  bool activeTap = true;
  String title = '';
  String calories = '';
  String protein = '';
  String fats = '';
  String carbohydrates = '';
  String notification = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


    Future<void> newFood() async
    {
      await createFood(title, protein, fats, carbohydrates, calories);
    }


    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child:
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30)
          ),
          width: screenWidth/1.1,
          height: screenHeight/3.1,
          child:
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(top: screenHeight/100)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.white,
                          shadowColor: Colors.transparent
                      ),
                      child: SvgPicture.asset(
                        'images/arrow.svg',
                        width: screenHeight/27,
                        height: screenHeight/27,
                        colorFilter: const ColorFilter.mode(Color.fromRGBO(16, 240, 12, 1.0), BlendMode.srcIn),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth/1.5,
                      height: screenHeight/14,
                      child: TextFormField(
                        maxLength: 20,
                        validator: (value) {
                          if (value == ''){
                            return 'Поле должно быть заполнено';
                          }
                          return null;
                        },
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я0-9.% ]'))],
                        onChanged: (String value){
                          title = value;
                        },
                        style: TextStyle(
                            fontSize: screenHeight/40,
                            fontFamily: 'Comfortaa',
                            color: Colors.black
                        ),
                        decoration: InputDecoration(   hoverColor: Colors.orange,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          hintText: 'Название',
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
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: screenHeight/60)),
                SizedBox(
                  width: screenWidth/1.2,
                  child:
                  Table(
                    border: TableBorder.all(
                        color: const Color.fromRGBO(16, 240, 12, 1.0),
                        //width: 1.3
                    ),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                          children: [
                            TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Белки",
                                    style: TextStyle(
                                        fontSize: screenHeight/70,
                                        fontFamily: 'Comfortaa',
                                        color: Colors.black
                                    ),
                                    textAlign: TextAlign.center,),
                                )
                            ),
                            TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                  Text("Жиры",
                                      style:
                                      TextStyle(
                                          fontSize: screenHeight/70,
                                          fontFamily: 'Comfortaa',
                                          color: Colors.black
                                      ),
                                      textAlign: TextAlign.center),
                                )
                            ),
                            TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Углеводы",
                                      style:
                                      TextStyle(
                                          fontSize: screenHeight/70,
                                          fontFamily: 'Comfortaa',
                                          color: Colors.black
                                      ),
                                      textAlign: TextAlign.center),
                                )
                            ),
                            TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("ккал",
                                      style:
                                      TextStyle(
                                          fontSize: screenHeight/70,
                                          fontFamily: 'Comfortaa',
                                          color: Colors.black
                                      ),
                                      textAlign: TextAlign.center),
                                )
                            ),
                          ]
                      ),
                      TableRow(
                          children: [
                            TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      height: screenHeight/30,
                                      child: Center(
                                        child: TextField(
                                          maxLength: 5,
                                          keyboardType: const TextInputType.numberWithOptions(decimal: true), // Разрешить ввод чисел с плавающей точкой
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')), // Разрешить только цифры и точку
                                          ],
                                          onChanged: (String value){
                                            protein = value;
                                          },
                                          style: TextStyle(
                                              fontSize: screenHeight/50,
                                              fontFamily: 'Comfortaa',
                                              color: Colors.black
                                          ),
                                          textAlign: TextAlign.center,
                                          decoration: const InputDecoration(hoverColor: Colors.orange,
                                            counterText: '',
                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black, width: 1),
                                            ),
                                            //contentPadding: EdgeInsets.only(bottom: -10),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black, width: 1),
                                            ),
                                          ),
                                        ),
                                      )
                                  ),
                                )
                            ),
                            TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      height: screenHeight/30,
                                      child: Center(
                                        child: TextField(
                                          /// TODO Дописать валидацию
                                          maxLength: 5,
                                          keyboardType: const TextInputType.numberWithOptions(decimal: true), // Разрешить ввод чисел с плавающей точкой
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')), // Разрешить только цифры и точку
                                          ],
                                          onChanged: (String value){
                                            fats = value;
                                          },
                                          style: TextStyle(
                                              fontSize: screenHeight/50,
                                              fontFamily: 'Comfortaa',
                                              color: Colors.black
                                          ),
                                          textAlign: TextAlign.center,
                                          decoration: const InputDecoration(hoverColor: Colors.orange,
                                            counterText: '',
                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black, width: 1),
                                            ),
                                            //contentPadding: EdgeInsets.only(bottom: -10),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black, width: 1),
                                            ),
                                          ),
                                        ),
                                      )
                                  ),
                                )
                            ),
                            TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      height: screenHeight/30,
                                      child: Center(
                                        child: TextField(
                                          maxLength: 5,
                                          keyboardType: const TextInputType.numberWithOptions(decimal: true), // Разрешить ввод чисел с плавающей точкой
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')), // Разрешить только цифры и точку
                                          ],
                                          onChanged: (String value){
                                            carbohydrates = value;
                                          },
                                          style: TextStyle(
                                              fontSize: screenHeight/50,
                                              fontFamily: 'Comfortaa',
                                              color: Colors.black
                                          ),
                                          textAlign: TextAlign.center,
                                          decoration: const InputDecoration(hoverColor: Colors.orange,
                                            counterText: '',
                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black, width: 1),
                                            ),
                                            //contentPadding: EdgeInsets.only(bottom: -10),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black, width: 1),
                                            ),
                                          ),
                                        ),
                                      )
                                  ),
                                )
                            ),
                            TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      height: screenHeight/30,
                                      child: Center(
                                        child: TextField(
                                          maxLength: 7,
                                          keyboardType: const TextInputType.numberWithOptions(decimal: true), // Разрешить ввод чисел с плавающей точкой
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')), // Разрешить только цифры и точку
                                          ],
                                          onChanged: (String value){
                                            calories = value;
                                          },
                                          style: TextStyle(
                                              fontSize: screenHeight/50,
                                              fontFamily: 'Comfortaa',
                                              color: Colors.black
                                          ),
                                          textAlign: TextAlign.center,
                                          decoration: const InputDecoration(hoverColor: Colors.orange,
                                            counterText: '',
                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black, width: 1),
                                            ),
                                            //contentPadding: EdgeInsets.only(bottom: -10),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black, width: 1),
                                            ),
                                          ),
                                        ),
                                      )
                                  ),
                                )
                            ),
                          ]
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: screenHeight/80)),
                SizedBox(
                  height: screenHeight/25,
                  width: screenWidth/1.4,
                  child: Text(
                    notification,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.red[900]
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: screenHeight/60)),
                SizedBox(
                  height: screenHeight/25,
                  width: screenWidth/2.5,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        notification = foodValidator(
                            protein, fats, carbohydrates, calories);
                      });
                      if (_formKey.currentState != null && activeTap) {
                        if (_formKey.currentState!.validate() &&
                            notification == '') {
                          activeTap = false;
                          BlocProvider.of<FoodBloc>(context).add(CreateFoodEvent(title, protein, fats, carbohydrates, calories));
                          Navigator.pop(context);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                        const Color.fromRGBO(16, 240, 12, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36))),
                    child: Text(
                      "Добавить",
                      style: TextStyle(
                          fontSize: screenHeight / 40,
                          fontFamily: 'Comfortaa',
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
