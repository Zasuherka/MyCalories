import 'package:app1/bloc/food_bloc/food_bloc.dart';
import 'package:app1/constants.dart';
import 'package:app1/models/food.dart';
import 'package:app1/widgets/add_food_widget.dart';
import 'package:app1/widgets/update_food.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodWrap extends StatelessWidget {
  final Food food;
  final bool isAddEatingFood;
  const FoodWrap({super.key, required this.food, required this.isAddEatingFood});

  @override
  Widget build(BuildContext context) {
    
    
    final String userTitle = food.isThisFoodOnTheMyFoodList
        ? 'Удалить из моей еды'
        : 'Добавить в мою еду';
    return Wrap(
      children: [
        ///Добавить в съеденное
        isAddEatingFood ? SizedBox(
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
            onTap: (){
              Navigator.pop(context);
                    BlocProvider.of<FoodBloc>(context)
                        .add(FoodEvent.infoAboutFood(food: food));
                    showDialog(
                  context: context,
                  builder: (BuildContext context) => AddEatingFood(
                      bloc: BlocProvider.of<FoodBloc>(context)));
            },
          ),
        ) : const SizedBox(),
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
                  ? BlocProvider.of<FoodBloc>(context)
                      .add(FoodEvent.deleteFood(food: food))
                  : BlocProvider.of<FoodBloc>(context)
                      .add(FoodEvent.addingFood(food: food));
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
            onTap: () async {
              Navigator.pop(context);
              await showDialog(
                  context: context,
                  builder: (BuildContext context) => UpdateFood(food: food));
              },
          ),
        )
        : const SizedBox(),
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
