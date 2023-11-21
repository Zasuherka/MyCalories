import 'package:app1/bloc/foodBloc/food_bloc.dart';
import 'package:app1/objects/food.dart';
import 'package:app1/widgets/addFoodWidget.dart';
import 'package:app1/widgets/updateFood.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodWrap extends StatelessWidget {
  final Food food;
  final bool isUpdatePage;
  const FoodWrap({super.key, required this.food, required this.isUpdatePage});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    print(food.title);
    final String userTitle = food.isThisFoodOnTheMyFoodList
        ? 'Удалить из моей еды'
        : 'Добавить в мою еду';
    return Wrap(
      children: [
        ///Добавить в съеденное
        !isUpdatePage ? SizedBox(
          height: screenHeight/20,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Добвить в приём пищи',
                  style: TextStyle(
                    fontSize: screenHeight/55,
                    fontFamily: 'Comfortaa',
                    color: Colors.black,
                  ),
                )
              ],
            ),
            onTap: () async{
              bool response = await showDialog(
                  context: context,
                  builder: (BuildContext context) => AddFood(food: food));
              if (response) {
                Navigator.pop(context);
              }
            },
          ),
        ) : Container(),
        ///Удалить из своей/добавить в свою
        SizedBox(
          height: screenHeight/20,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(userTitle,
                  style: TextStyle(
                    fontSize: screenHeight/55,
                    fontFamily: 'Comfortaa',
                    color: Colors.black,
                  ),
                )
              ],
            ),
            onTap: (){
              food.isThisFoodOnTheMyFoodList
                  ? BlocProvider.of<FoodBloc>(context).add(DeleteFoodEvent(food))
                  : BlocProvider.of<FoodBloc>(context).add(AddingFoodEvent(food));
              Navigator.pop(context);
            },
          ),
        ),
        ///Редактировать
        food.isUserFood ? SizedBox(
          height: screenHeight/20,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Редактировать еду',
                  style: TextStyle(
                    fontSize: screenHeight/55,
                    fontFamily: 'Comfortaa',
                    color: Colors.black,
                  ),
                )
              ],
            ),
            onTap: (){
              showDialog(
                  context: context,
                  builder: (BuildContext context) => UpdateFood(
                      food: food));
              Navigator.pop(context);
            },
          ),
        )
        : Container(),
        SizedBox(
          height: screenHeight/20,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Отмена',
                  style: TextStyle(
                    fontSize: screenHeight/55,
                    fontFamily: 'Comfortaa',
                    color: Colors.black,
                  ),
                )
              ],
            ),
            onTap: (){
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }
}
