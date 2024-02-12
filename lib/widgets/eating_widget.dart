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

class EatingWidget extends StatefulWidget {
  final String title;
  const EatingWidget({super.key, required this.title});

  @override
  State<EatingWidget> createState() => _EatingWidgetState();
}

class _EatingWidgetState extends State<EatingWidget> {
  late double heightWidget;
  late String title;
  String calories = '0.00';
  late List<EatingFood> list = [];

  @override
  void initState() {
    super.initState();
    title = widget.title;
  }
  @override
  Widget build(BuildContext context) {
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
          heightWidget = screenHeight * list.length * 0.07 + screenHeight * 0.07;
          return Container(
            width: screenWidth * 0.95,
            height: heightWidget,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 13,
                    offset: const Offset(10, 10),
                  ),
                ],
                color: AppColors.white,
                borderRadius: BorderRadius.circular(25)
            ),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.07,
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      SizedBox(
                        width: screenWidth/2.5,
                        child: Text(
                          title,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const Spacer(flex: 5),
                      SizedBox(
                        width: screenWidth * 0.25,
                        child: Text('$calories ккал',
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.bodyMedium,
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
                          width: screenHeight/40,
                          height: screenHeight/40,
                          colorFilter: const ColorFilter.mode(AppColors.turquoise , BlendMode.srcIn),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.95,
                  height: screenHeight * 0.07 * list.length,
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
                              width: screenWidth * 0.95,
                              height: screenHeight * 0.07,
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
                                  SizedBox(
                                    width: screenWidth * 0.05,
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.55,
                                    child: Text(list[index].title,
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: screenWidth * 0.288,
                                    child:
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Spacer(),
                                        Text('${(list[index].calories / 100 * list[index].weight).toStringAsFixed(2)}ккал.',
                                          style: Theme.of(context).textTheme.bodyMedium,
                                          textAlign: TextAlign.right,
                                        ),
                                        const Spacer(),
                                        Text('${list[index].weight.toString()}г.',
                                          style: Theme.of(context).textTheme.bodyMedium,
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.05,
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
