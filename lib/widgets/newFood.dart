import 'package:app1/bloc/foodBloc/food_bloc.dart';
import 'package:app1/constants.dart';
import 'package:app1/validation/foodValidator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';


class NewFood extends StatefulWidget {
  const NewFood({super.key});

  @override
  State<NewFood> createState() => _NewFoodState();
}

class _NewFoodState extends State<NewFood> with FoodValidationMixin{
  bool activeTap = true;
  String title = '';
  String calories = '';
  String protein = '';
  String fats = '';
  String carbohydrates = '';
  String notification = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


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
          width: screenWidth/1.05,
          height: screenHeight/3,
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
                    SizedBox(width: screenWidth/25),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, false);
                      },
                      child: SvgPicture.asset(
                        'images/arrow.svg',
                        width: screenHeight/27,
                        height: screenHeight/27,
                        colorFilter: const ColorFilter.mode(AppColors.green, BlendMode.srcIn),
                      ),
                    ),
                    SizedBox(width: screenWidth/25),
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
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[ёЁa-zA-Zа-яА-Я0-9.% ]'))],
                        onChanged: (String value){
                          title = value;
                        },
                        style: Theme.of(context).textTheme.titleLarge,
                        decoration: InputDecoration(hoverColor: Colors.orange,
                          counterText: '',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          hintText: 'Название',
                          hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.colorForHintText
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1),
                          ),
                          contentPadding: EdgeInsets.only(top: screenHeight/200),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: screenHeight/100)),
                SizedBox(
                  width: screenWidth/1.1,
                  child:
                  Table(
                    border: TableBorder.all(
                        color: AppColors.green,
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
                                    style: Theme.of(context).textTheme.bodySmall,
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
                                      style: Theme.of(context).textTheme.bodySmall,
                                      textAlign: TextAlign.center),
                                )
                            ),
                            TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Углеводы",
                                      style: Theme.of(context).textTheme.bodySmall,
                                      textAlign: TextAlign.center),
                                )
                            ),
                            TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("ккал",
                                      style: Theme.of(context).textTheme.bodySmall,
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
                                          style: Theme.of(context).textTheme.bodyLarge,
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
                                          style: Theme.of(context).textTheme.bodyLarge,
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
                                          style: Theme.of(context).textTheme.bodyLarge,
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
                                          style: Theme.of(context).textTheme.bodyLarge,
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
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.red
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: screenHeight/60)),
                ElevatedButton(
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
                      fixedSize: Size(screenWidth / 2, screenHeight / 23),
                      alignment: Alignment.center,
                      backgroundColor:
                      AppColors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36))),
                  child: Text(
                    "Добавить",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.white
                    ),
                    textAlign: TextAlign.center,
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
