import 'package:app1/presentation/constants.dart';
import 'package:app1/domain/model/food.dart';
import 'package:app1/presentation/pages/my_food_page/widgets/food_wrap.dart';
import 'package:flutter/material.dart';


class FoodListView extends StatelessWidget {
  final List<Food> listFood;
  final bool isAddEatingFood;
  const FoodListView({super.key, required this.listFood, required this.isAddEatingFood});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listFood.length,
      itemBuilder: (BuildContext context, int index) {
        int elementIndex = listFood.length - 1 - index;
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            showModalBottomSheet(context: context, builder:
                (BuildContext context) =>
                FoodWrap(food: listFood[elementIndex], isAddEatingFood: isAddEatingFood));
          },
          child: Container(
              margin: const EdgeInsets.only(
                  top: 7,
              ),
              decoration: BoxDecoration(
                  color: AppColors.elementColor,
                  boxShadow: boxShadow,
                  borderRadius: BorderRadius.circular(25.0)),
              //width: screenWidth,
              height: 77,
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    listFood.elementAt(elementIndex).title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.secondaryTextColor
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(
                          '${listFood.elementAt(elementIndex).calories.toString()}ккал.',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppColors.secondaryTextColor
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: Text(
                          '${listFood.elementAt(elementIndex).protein.toStringAsFixed(2)}|'
                              '${listFood.elementAt(elementIndex).fats.toStringAsFixed(2)}|'
                              '${listFood.elementAt(elementIndex).carbohydrates.toStringAsFixed(2)}',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppColors.secondaryTextColor
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
          ),
        );
      },
    );
  }
}
