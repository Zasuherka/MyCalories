import 'package:app1/internal/bloc/food_bloc/food_bloc.dart';
import 'package:app1/domain/model/food.dart';
import 'package:app1/presentation/pages/my_calories/widgets/add_food_widget.dart';
import 'package:app1/presentation/pages/my_food_page/widgets/update_food.dart';
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
          height: 45,
          child: ListTile(
            title: const Text('Добвить в приём пищи',
              textAlign: TextAlign.center,
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
          height: 45,
          child: ListTile(
            title: Text(userTitle,
              textAlign: TextAlign.center,
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
          height: 45,
          child: ListTile(
            title: const  Text('Редактировать еду',
                textAlign: TextAlign.center,
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
          height: 45,
          child: ListTile(
            title: const Text(
              'Отмена',
              textAlign: TextAlign.center,
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
