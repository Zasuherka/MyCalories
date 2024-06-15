import 'package:app1/internal/bloc/food_bloc/food_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/domain/model/food.dart';
import 'package:app1/presentation/validation/food_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui' as ui show ImageFilter;

class UpdateFood extends StatefulWidget {
  final Food food;
  const UpdateFood({super.key, required this.food});

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
  Food? food;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _fatsController = TextEditingController();
  final TextEditingController _carbohydratesController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    food = widget.food;
    if(food != null){
      title = food!.title;
      _titleController.text = title;
      protein = food!.protein.toString();
      _proteinController.text = protein;
      fats = food!.fats.toString();
      _fatsController.text = fats;
      carbohydrates = food!.carbohydrates.toString();
      _carbohydratesController.text = carbohydrates;
      calories = food!.calories.toString();
      _caloriesController.text = calories;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _proteinController.dispose();
    _fatsController.dispose();
    _carbohydratesController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child:
        BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: Dialog(
              backgroundColor: AppColors.elementColor,
              //shape: CircleBorder(eccentricity: 30),
              insetPadding: const EdgeInsets.symmetric(horizontal: 12.5),
              child:
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 10),
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
                          controller: _titleController,
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
                    const SizedBox(height: 10),
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
                                      controller: _caloriesController,
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
                                        focusedBorder: InputBorder.none,
                                        border: InputBorder.none,
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
                                      controller: _proteinController,
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
                                        focusedBorder: InputBorder.none,
                                        border: InputBorder.none,
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
                                      controller: _fatsController,
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
                                        focusedBorder: InputBorder.none,
                                        border: InputBorder.none,
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
                                      controller: _carbohydratesController,
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
                                        focusedBorder: InputBorder.none,
                                        border: InputBorder.none,
                                      ),
                                    )
                                )
                              ]
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          notification = foodValidator(
                              protein, fats, carbohydrates, calories);
                        });
                        if (_formKey.currentState != null) {
                          if (_formKey.currentState!.validate() &&
                              notification == '') {
                            if (food != null){
                              BlocProvider.of<FoodBloc>(context).add(
                                  FoodEvent.updateFood(
                                      food: food!,
                                      title: title,
                                      protein: protein,
                                      fats: fats,
                                      carbohydrates: carbohydrates,
                                      calories: calories));
                            }
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
                          "Изменить",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.primaryButtonColor
                          ),
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
      )
    );
  }
}
