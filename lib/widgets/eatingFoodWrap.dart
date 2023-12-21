import 'package:app1/bloc/eatingFood/eating_food_bloc.dart';
import 'package:app1/widgets/addFoodWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///Перед использованием кинуть [GetEatingFoodInfoEvent]
class EatingFoodWrap extends StatelessWidget {

  const EatingFoodWrap({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Wrap(
      children: [
        SizedBox(
          height: screenHeight/20,
          child: ListTile(
            title: const Text('Изменить', textAlign: TextAlign.center),
            onTap: (){
              Navigator.pop(context);
              showDialog(context: context, builder: (BuildContext context) =>
              AddEatingFood(bloc: BlocProvider.of<EatingFoodBloc>(context)));
            },
          ),
        ),
        SizedBox(
          height: screenHeight/20,
          child: ListTile(
            title: const Text('Удалить из списка', textAlign: TextAlign.center),
            onTap: (){
              Navigator.pop(context);
              BlocProvider.of<EatingFoodBloc>(context).add(DeleteEatingFoodEvent());
          },
          ),
        ),
        SizedBox(
          height: screenHeight/20,
          child: ListTile(
            title: const Text('Отмена', textAlign: TextAlign.center),
            onTap: (){
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }
}
