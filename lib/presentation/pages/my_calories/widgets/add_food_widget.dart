import 'package:app1/internal/bloc/eating_food_bloc/eating_food_bloc.dart';
import 'package:app1/internal/bloc/food_bloc/food_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/domain/model/food.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddEatingFood extends StatefulWidget {
  final Bloc bloc;
  const AddEatingFood({super.key, required this.bloc});

  @override
  State<AddEatingFood> createState() => _AddEatingFoodState();
}

class _AddEatingFoodState extends State<AddEatingFood> {
  final _formKey = GlobalKey<FormState>();
  String buttonTitle = 'Добавить';
  int? index;
  Food? food;
  String? weight;

  final TextEditingController _weightController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _weightController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    if (widget.bloc is FoodBloc) {
      context.read<FoodBloc>().state.whenOrNull(
          getFoodInfo: (foodState) {
            food = foodState;
            buttonTitle = 'Добавить';
          }
      );
    }
    if(widget.bloc is EatingFoodBloc){
      context.read<EatingFoodBloc>().state.whenOrNull(
          eatingFoodInfo: (indexState, nameEating, eatingFood) {
            food = eatingFood;
            weight = eatingFood?.weight.toString() ?? '';
            _weightController.text = weight!;
            index = indexState;
            buttonTitle = 'Изменить';
          }
      );
    }
    if (food == null) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child:
          Container(
              decoration: BoxDecoration(
                  color: AppColors.elementColor,
                  borderRadius: BorderRadius.circular(30)
              ),
              margin: const EdgeInsets.symmetric(horizontal: 12.5),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              height: 450,
              child:
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                        SizedBox(
                            width: screenWidth * 0.7,
                            child: Text(
                              food?.title ?? '',
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.left,
                            )
                        ),

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
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      child: Text(
                                        food?.calories.toStringAsFixed(2) ?? '',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.titleSmall,
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
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      child: Text(
                                        food?.protein.toStringAsFixed(2) ?? '',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.titleSmall,
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
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      child: Text(
                                        food?.fats.toStringAsFixed(2) ?? '',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.titleSmall,
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
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      child: Text(
                                        food?.carbohydrates.toStringAsFixed(2) ?? '',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.titleSmall,
                                      ),
                                    )
                                )
                              ]
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        controller: _weightController,
                        validator: (value) {
                          if (value == ''){
                            return '';
                          }
                          return null;
                        },
                        maxLength: 5,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true), // Разрешить ввод чисел с плавающей точкой
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                        onChanged: (String value){
                          weight = value;
                        },
                        style: Theme.of(context).textTheme.titleMedium,
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: 'грамм',
                          hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.colorForHintText
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1),
                          ),
                          prefixIcon: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SvgPicture.asset(
                              'images/weight2.svg',
                              width: 32,
                              height: 32,
                              colorFilter: const ColorFilter.mode(AppColors.dark, BlendMode.srcIn),
                            ),
                          ),
                          constraints: BoxConstraints.tightFor(
                              width: screenWidth * 0.4,
                              height: 85
                          ),
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState != null)
                        {
                          if (_formKey.currentState!.validate() && food != null) {
                            widget.bloc is FoodBloc
                                ? BlocProvider.of<EatingFoodBloc>(context).add(EatingFoodEvent.addEatingFood(
                                idFood: food!.idFood,
                                title: food!.title,
                                protein: food!.protein,
                                fats: food!.fats,
                                carbohydrates: food!.carbohydrates,
                                calories: food!.calories,
                                weight: int.parse(weight!)
                            ))
                                : BlocProvider.of<EatingFoodBloc>(context).add(
                                EatingFoodEvent.updateEatingFood(
                                    index: index!,
                                    weight: int.parse(weight!)
                                )
                            );
                            Navigator.pop(context, true);
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
                          buttonTitle,
                          style:
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.white
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                )
              )
          ),
        ),
      )
    );
  }
}
