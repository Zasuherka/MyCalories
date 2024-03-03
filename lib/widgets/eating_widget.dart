import 'package:app1/bloc/eating_food_bloc/eating_food_bloc.dart';
import 'package:app1/bloc/food_bloc/food_bloc.dart';
import 'package:app1/constants.dart';
import 'package:app1/router/router.dart';
import 'package:app1/widgets/eating_food_wrap.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app1/models/eating_food.dart';

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
                      GestureDetector(
                        onTap: () async {
                      BlocProvider.of<EatingFoodBloc>(context).add(
                          EatingFoodEvent.getNameEating(nameEating: title));
                      BlocProvider.of<FoodBloc>(context).add(const FoodEvent.getFoodList());
                          await context.router.push(MyFoodRoute(isAddEatingFood: true));
                        },
                        child: SvgPicture.asset(
                          'images/plus2.svg',
                          width: 20,
                          height: 20,
                          colorFilter: const ColorFilter.mode(AppColors.turquoise , BlendMode.srcIn),
                        ),
                      ),
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
                                    width: 220,
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
