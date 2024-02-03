import 'package:app1/bloc/food_bloc/food_bloc.dart';
import 'package:app1/constants.dart';
import 'package:app1/validation/food_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

///Перел открытием нужно кинуть [GetFoodInfoEvent]
class UpdateFood extends StatefulWidget {
  const UpdateFood({super.key});

  @override
  State<UpdateFood> createState() => _UpdateFoodState();
}

class _UpdateFoodState extends State<UpdateFood> with FoodValidationMixin{
  String title = '';
  String calories = '';
  String protein = '';
  String fats = '';
  String carbohydrates = '';
  String notification = '';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerProtein = TextEditingController();
  final TextEditingController _controllerFats = TextEditingController();
  final TextEditingController _controllerCarbohydrates = TextEditingController();
  final TextEditingController _controllerCalories = TextEditingController();

  @override
  void dispose() {
    _controllerTitle.dispose();
    _controllerProtein.dispose();
    _controllerFats.dispose();
    _controllerCarbohydrates.dispose();
    _controllerCalories.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<FoodBloc,FoodState>(
        builder: (context, state) {
          if (state is GetFoodInfoState && state.food != null){
            title = state.food!.title;
            _controllerTitle.text = title;
            protein = state.food!.protein.toString();
            _controllerProtein.text = protein;
            fats = state.food!.fats.toString();
            _controllerFats.text = fats;
            carbohydrates = state.food!.carbohydrates.toString();
            _controllerCarbohydrates.text = carbohydrates;
            calories = state.food!.calories.toString();
            _controllerCalories.text = calories;
          }
          return Center(
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
                      SizedBox(height: screenHeight/100),
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
                              colorFilter: const ColorFilter.mode(AppColors.turquoise , BlendMode.srcIn),
                            ),
                          ),
                          SizedBox(width: screenWidth/25),
                          SizedBox(
                            width: screenWidth/1.5,
                            height: screenHeight/14,
                            child: TextFormField(
                              maxLength: 20,
                              controller: _controllerTitle,
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
                              style: TextStyle(
                                  fontSize: screenHeight/40,
                                  fontFamily: 'Comfortaa',
                                  color: Colors.black
                              ),
                              decoration: InputDecoration(
                                counterText: '',
                                hoverColor: Colors.orange,
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
                                contentPadding: EdgeInsets.only(bottom: screenHeight/200),
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
                        width: screenWidth/1.1,
                        child:
                        Table(
                          border: TableBorder.all(
                            color: AppColors.turquoise ,
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
                                                controller: _controllerProtein,
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
                                                controller: _controllerFats,
                                                ///TODO Дописать валидацию
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
                                                controller: _controllerCarbohydrates,
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
                                                controller: _controllerCalories,
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
                        width: screenWidth/1.5,
                        child: Text(
                          notification,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.red
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: screenHeight/100)),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            notification = foodValidator(
                                protein, fats, carbohydrates, calories);
                          });
                          if (_formKey.currentState != null) {
                            if (_formKey.currentState!.validate() &&
                                notification == '') {
                              if (state.food != null){
                                BlocProvider.of<FoodBloc>(context).add(UpdateFoodEvent(state.food!, title, protein, fats, carbohydrates, calories));
                              }
                              Navigator.pop(context);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(screenWidth / 2, screenHeight / 23),
                            backgroundColor:
                            AppColors.turquoise ,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36))),
                        child: Text(
                          "Изменить",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
          );
        }
      ),
    );
  }
}
