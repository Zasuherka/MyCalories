import 'package:app1/bloc/eatingFood/eating_food_bloc.dart';
import 'package:app1/bloc/foodBloc/food_bloc.dart';
import 'package:app1/constants.dart';
import 'package:app1/objects/food.dart';
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
  late Food food;
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
  }

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
            height: screenHeight/2.9,
            child:
            Form(
              key: _formKey,
              child: BlocBuilder(
                bloc: widget.bloc,
                builder: (context, state) {
                  if(state is GetFoodInfoState){
                    if(state.food != null){
                      food = state.food!;
                      buttonTitle = 'Добавить';
                    }
                  }
                  else if(state is GetEatingFoodInfoState){
                    if(state.eatingFood != null){
                      food = state.eatingFood!;
                      weight = state.eatingFood!.weight.toString();
                      _weightController.text = weight!;
                      index = state.index;
                      buttonTitle = 'Изменить';
                    }
                    else{
                      Navigator.pop(context);
                    }
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight/50),
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
                              //height: screenHeight/,
                              child:
                              Text(
                                food.title,
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.left,
                              )
                          ),

                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: screenHeight/60)),
                      SizedBox(
                        width: screenWidth/1.1,
                        height: screenHeight/12,
                        child:
                        Table(
                          border: TableBorder.all(
                            color: AppColors.green,
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
                                            style:
                                            Theme.of(context).textTheme.bodySmall,
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
                                            Theme.of(context).textTheme.bodySmall,
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
                                            Theme.of(context).textTheme.bodySmall,
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
                                                child: Text(
                                                  food.protein.toStringAsFixed(2),
                                                  style: Theme.of(context).textTheme.titleSmall,
                                                )
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
                                                child: Text(
                                                  food.fats.toStringAsFixed(2),
                                                  style: Theme.of(context).textTheme.titleSmall,
                                                )
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
                                                child: Text(
                                                  food.carbohydrates.toStringAsFixed(2),
                                                  style: Theme.of(context).textTheme.titleSmall,
                                                )
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
                                                child:
                                                Text(
                                                  food.calories.toStringAsFixed(2),
                                                  style: Theme.of(context).textTheme.titleSmall,
                                                )
                                            )
                                        ),
                                      )
                                  ),
                                ]
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight/100),
                      SizedBox(
                          width: screenWidth * 0.9,
                          height: screenHeight/11,
                          child:
                          Row(
                            children: [
                              Container(
                                height: screenHeight/20,
                                alignment: Alignment.topCenter,
                                padding: EdgeInsets.only(bottom: screenHeight/200),
                                child: SvgPicture.asset(
                                  'images/weight.svg',
                                  width: screenHeight/27,
                                  height: screenHeight/27,
                                  colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.4,
                                child:
                                Padding(padding: EdgeInsets.only(left: screenWidth/100),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        TextFormField(
                                          controller: _weightController,
                                          validator: (value) {
                                            if (value == ''){
                                              return 'Поле не заполнено';
                                            }
                                            return null;
                                          },
                                          keyboardType: const TextInputType.numberWithOptions(decimal: true), // Разрешить ввод чисел с плавающей точкой
                                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                                          onChanged: (String value){
                                            weight = value;
                                          },
                                          style: Theme.of(context).textTheme.titleMedium,
                                          decoration: InputDecoration(
                                            hintText: 'гр/мл',
                                            hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                                              color: AppColors.colorForHintText
                                            ),
                                            hoverColor: Colors.orange,
                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                            focusedBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black, width: 1),
                                            ),
                                            contentPadding: const EdgeInsets.only(bottom: -10),
                                            border: const UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black, width: 1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              ),
                            ],
                          )
                      ),
                      Padding(padding: EdgeInsets.only(top: screenHeight/40)),
                      SizedBox(
                        height: screenHeight/25,
                        width: screenWidth/2.5,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState != null)
                            {
                              if (_formKey.currentState!.validate()) {
                                state is FoodState
                                    ? BlocProvider.of<EatingFoodBloc>(context).add(AddEatingFoodEvent(food.idFood, food.title, food.protein, food.fats, food.carbohydrates, food.calories, int.parse(weight!)))
                                    : BlocProvider.of<EatingFoodBloc>(context).add(UpdateEatingFoodEvent(index!, int.parse(weight!)));
                                Navigator.pop(context, true);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(36)
                              )
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
                    ],
                  );
                },
              )
            )
        ),
      )
    );
  }
}
