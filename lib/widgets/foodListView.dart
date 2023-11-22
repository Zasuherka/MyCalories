import 'package:app1/colors/colors.dart';
import 'package:app1/objects/food.dart';
import 'package:app1/widgets/foodWrap.dart';
import 'package:flutter/material.dart';

class FoodListView extends StatelessWidget {
  final List<Food> listFood;
  final bool isUpdatePage;
  const FoodListView({super.key, required this.listFood, required this.isUpdatePage});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
                showModalBottomSheet(context: context, builder:
                    (BuildContext context) =>
                        FoodWrap(food: listFood[elementIndex], isUpdatePage: isUpdatePage));
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
                            style: TextStyle(
                              fontSize: screenHeight / 32,
                              fontFamily: 'Comfortaa',
                              color: AppColors.green,
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
                                style: TextStyle(
                                  fontSize: screenHeight / 50,
                                  fontFamily: 'Comfortaa',
                                  color: AppColors.green,
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
                                style: TextStyle(
                                  fontSize: screenHeight / 50,
                                  fontFamily: 'Comfortaa',
                                  color: AppColors.green,
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
