import 'package:app1/bloc/eatingFood/eating_food_bloc.dart';
import 'package:app1/bloc/foodBloc/food_bloc.dart';
import 'package:app1/constants.dart';
import 'package:app1/objects/food.dart';
import 'package:app1/widgets/foodWrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodListView extends StatelessWidget {
  final List<Food> listFood;
  final bool isAddEatingFood;
  const FoodListView({super.key, required this.listFood, required this.isAddEatingFood});
  @override
  Widget build(BuildContext context) {
     
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: screenHeight / 300),
      itemCount: listFood.length,
      itemBuilder: (BuildContext context, int index) {
        int elementIndex = listFood.length - 1 - index;
        return Padding(
            padding: EdgeInsets.only(
                top: screenHeight / 200,
                left: screenWidth / 100,
                right: screenWidth / 100),
            child:
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                BlocProvider.of<FoodBloc>(context).add(GetFoodInfoEvent(listFood[elementIndex]));
                showModalBottomSheet(context: context, builder:
                    (BuildContext context) =>
                        FoodWrap(food: listFood[elementIndex], isAddEatingFood: isAddEatingFood));
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 13,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15.0)),
                  width: screenWidth,
                  height: screenHeight / 10,
                  child: Padding(
                    padding: EdgeInsets.only(left: screenWidth / 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth / 60)),
                        SizedBox(
                          height: screenHeight / 29,
                          child: Text(
                            listFood.elementAt(elementIndex).title,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.green
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: screenHeight / 100)),
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidth / 3,
                              child: Text(
                                '${listFood.elementAt(elementIndex).calories.toString()}ккал.',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: AppColors.green
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth / 2.5,
                              child: Text(
                                '${listFood.elementAt(elementIndex).protein.toStringAsFixed(2)}|'
                                    '${listFood.elementAt(elementIndex).fats.toStringAsFixed(2)}|'
                                    '${listFood.elementAt(elementIndex).carbohydrates.toStringAsFixed(2)}',
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: AppColors.green
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            )
        );
      },
    );
  }
}
