import 'package:app1/internal/bloc/food_bloc/food_bloc.dart';
import 'package:app1/presentation/pages/my_calories/widgets/add_food_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionWrap extends StatelessWidget {
  const CollectionWrap({super.key});

  @override
  Widget build(BuildContext context) {

    void makeChoice(String nameEating){
      context.router.popForced();
      showDialog(
          context: context,
          builder: (BuildContext context) => AddEatingFood(
              bloc: BlocProvider.of<FoodBloc>(context)));
    }

    return Wrap(
      children: <Widget>[
        ListTile(
          title: const Text(
            'Добавить в завтрак',
            textAlign: TextAlign.center,
          ),
          onTap: () {
            makeChoice('Завтрак');
          },
        ),
        ListTile(
          title: const Text(
            'Добавить в обед',
            textAlign: TextAlign.center,
          ),
          onTap: () {
            makeChoice('Обед');
          },
        ),
        ListTile(
          title: const Text(
            'Добавить в ужин',
            textAlign: TextAlign.center,
          ),
          onTap: () {
            makeChoice('Ужин');
          },
        ),
        ListTile(
          title: const Text(
            'Добавить в дополнительый приём пищи',
            textAlign: TextAlign.center,
          ),
          onTap: () {
            makeChoice('Другое');
          },
        ),
      ],
    );
  }
}
