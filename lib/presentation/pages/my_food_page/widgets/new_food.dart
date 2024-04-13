import 'package:app1/internal/bloc/food_bloc/food_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/validation/food_validator.dart';
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child:
        Container(
          decoration: BoxDecoration(
              color: AppColors.elementColor,
              borderRadius: BorderRadius.circular(30)
          ),
          margin: const EdgeInsets.symmetric(horizontal: 12.5),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          height: 400,
          child:
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, false);
                      },
                      child: SvgPicture.asset(
                        'images/arrow.svg',
                        width: 32,
                        height: 32,
                        colorFilter: const ColorFilter.mode(AppColors.turquoise , BlendMode.srcIn),
                      ),
                    ),
                    const SizedBox(width: 20),
                    TextFormField(
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
                      style: Theme.of(context).textTheme.titleMedium,
                      decoration: InputDecoration(hoverColor: Colors.orange,
                        counterText: ' ',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: 'Название',
                        hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.lightGrey
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        //filled: true,
                        constraints: BoxConstraints(
                          maxHeight: 80,
                          maxWidth: screenWidth * 0.7
                        ),
                        contentPadding: const EdgeInsets.only(bottom: 0, top: 10),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                    )
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: 250,
                  child: Table(
                    border: TableBorder.all(
                        color: AppColors.turquoise
                    ),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(5),
                      1: FlexColumnWidth(3),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                          children: [
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Text(
                                  "Калории",
                                  style: Theme.of(context).textTheme.bodySmall,
                                  textAlign: TextAlign.center
                              ),
                            ),
                            TableCell(
                                verticalAlignment: TableCellVerticalAlignment.middle,
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
                                    constraints: BoxConstraints(maxHeight: 50),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                    ),
                                  ),
                                )
                            )
                          ]
                      ),
                      TableRow(
                          children: [
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Text(
                                  "Белки",
                                  style: Theme.of(context).textTheme.bodySmall,
                                  textAlign: TextAlign.center
                              ),
                            ),
                            TableCell(
                                verticalAlignment: TableCellVerticalAlignment.middle,
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
                                    constraints: BoxConstraints(maxHeight: 50),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none
                                    ),
                                  ),
                                )
                            )
                          ]
                      ),
                      TableRow(
                          children: [
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Text(
                                  "Жиры",
                                  style: Theme.of(context).textTheme.bodySmall,
                                  textAlign: TextAlign.center
                              ),
                            ),
                            TableCell(
                                verticalAlignment: TableCellVerticalAlignment.middle,
                                child: TextField(
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
                                    constraints: BoxConstraints(maxHeight: 50),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                    ),
                                  ),
                                )
                            )
                          ]
                      ),
                      TableRow(
                          children: [
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Text(
                                  "Углеводы",
                                  style: Theme.of(context).textTheme.bodySmall,
                                  textAlign: TextAlign.center
                              ),
                            ),
                            TableCell(
                                verticalAlignment: TableCellVerticalAlignment.middle,
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
                                    constraints: BoxConstraints(maxHeight: 50),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                    ),
                                  ),
                                )
                            )
                          ]
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: screenWidth/1.4,
                  child: Text(
                    notification,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.red
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      notification = foodValidator(
                          protein, fats, carbohydrates, calories);
                    });
                    if (_formKey.currentState != null && activeTap) {
                      if (_formKey.currentState!.validate() &&
                          notification == '') {
                        activeTap = false;
                          BlocProvider.of<FoodBloc>(context).add(
                              FoodEvent.createFood(
                                  title: title,
                                  protein: protein,
                                  fats: fats,
                                  carbohydrates: carbohydrates,
                                  calories: calories
                              ));
                          Navigator.pop(context);
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 2),
                    decoration: BoxDecoration(
                        color: AppColors.turquoise ,
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: Text(
                      "Добавить",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.white
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
