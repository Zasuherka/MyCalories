import 'package:app1/internal/bloc/eating_food_bloc/eating_food_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/pages/my_calories/widgets/collection_or_food.dart';
import 'package:app1/presentation/pages/my_calories/widgets/eating_food_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app1/domain/model/eating_food.dart';

class EatingWidget extends StatelessWidget {
  final String title;
  const EatingWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    double heightWidget = 55;
    String calories = '0.00';
    List<EatingFood> list = [];
    return BlocBuilder<EatingFoodBloc, EatingFoodState>(
        builder: (context, state) {
          if(title == 'Завтрак'){
            list = context.read<EatingFoodBloc>().breakfast;
            calories = context.read<EatingFoodBloc>().caloriesInBreakfast;
          }
          if(title == 'Обед'){
            list = context.read<EatingFoodBloc>().lunch;
            calories = context.read<EatingFoodBloc>().caloriesInLunch;
          }
          if(title == 'Ужин'){
            list = context.read<EatingFoodBloc>().dinner;
            calories = context.read<EatingFoodBloc>().caloriesInDinner;
          }
          if(title == 'Другое'){
            list = context.read<EatingFoodBloc>().another;
            calories = context.read<EatingFoodBloc>().caloriesInAnother;
          }
          heightWidget = 55 * (list.length + 1);
          return Container(
            height: heightWidget,
            decoration: BoxDecoration(
                boxShadow: boxShadow,
                color: AppColors.elementColor,
                borderRadius: BorderRadius.circular(25)
            ),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 55,
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 160,
                        child: Text(
                          title,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.textColor
                          ),
                        ),
                      ),
                      const Spacer(flex: 6),
                      SizedBox(
                        width: 120,
                        child: Text('$calories ккал',
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textColor
                          ),
                        ),
                      ),
                      const Spacer(),
                      CollectionOrFoodDropDown(title: title),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 55.0 * list.length,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),//Чтобы не скролился
                      addSemanticIndexes: false,
                      padding: EdgeInsets.zero,
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index){
                        return GestureDetector(
                          onTap: () {
                            BlocProvider.of<EatingFoodBloc>(context).add(
                            EatingFoodEvent.getEatingFoodInfo(
                                eatingFood: list[index],
                                index: index,
                                nameEating: title));
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) => const EatingFoodWrap()
                            );
                          },
                          child: Container(
                              height: 55,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          width: 1.0,
                                          color: Color.fromRGBO(164, 164, 164, 1.0)
                                      )
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.5,
                                    child: Text(list[index].title,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          color: AppColors.textColor
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: 115,
                                    child:
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Spacer(),
                                        Text('${(list[index].calories / 100 * list[index].weight).toStringAsFixed(2)}ккал.',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: AppColors.textColor
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                        const Spacer(),
                                        Text('${list[index].weight.toString()}г.',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: AppColors.textColor
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ],
                              )
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
        }
    );
  }
}
