import 'package:app1/bloc/eating_food_bloc/eating_food_bloc.dart';import 'package:app1/bloc/food_bloc/food_bloc.dart';
import 'package:app1/constants.dart';
import 'package:app1/pages/my_food_page.dart';
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
            list = context.read<EatingFoodBloc>().breakfast;
            calories = context.read<EatingFoodBloc>().caloriesInBreakfast;
          }
          if(title == 'Ужин'){
            list = context.read<EatingFoodBloc>().breakfast;
            calories = context.read<EatingFoodBloc>().caloriesInBreakfast;
          }
          if(title == 'Другое'){
            list = context.read<EatingFoodBloc>().breakfast;
            calories = context.read<EatingFoodBloc>().caloriesInBreakfast;
          }
          heightWidget = screenHeight * list.length * 0.06 + screenHeight * 0.07;
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
                      Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.05),
                          child: SizedBox(
                            width: screenWidth/2.5,
                            height: screenHeight/35,
                            child: Text(
                              title,
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          )
                      ),
                      Padding(padding: EdgeInsets.only(left: screenWidth * 0.15),
                        child: SizedBox(
                          width: screenWidth * 0.2,
                          child: Text('$calories ккал',
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: screenWidth * 0.01),
                        child: GestureDetector(
                          onTap: () async {
                            BlocProvider.of<EatingFoodBloc>(context).add(GetIsFoodEvent(title));
                            BlocProvider.of<FoodBloc>(context).add(FoodInitialEvent());
                            await context.router.push(MyFoodRoute(isAddEatingFood: true));
                          },
                          child: SvgPicture.asset(
                            'images/plus2.svg',
                            width: screenHeight/40,
                            height: screenHeight/40,
                            colorFilter: const ColorFilter.mode(AppColors.turquoise , BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.95,
                  height: screenHeight * 0.06 * list.length,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),//Чтобы не скролился
                      addSemanticIndexes: false,
                      padding: EdgeInsets.zero,
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index){
                        return GestureDetector(
                          onTap: () {
                            BlocProvider.of<EatingFoodBloc>(context).add(
                                GetEatingFoodInfoEvent(list[index], index, title));
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) => const EatingFoodWrap()
                            );
                          },
                          child: Container(
                              width: screenWidth * 0.95,
                              height: screenHeight * 0.06,
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
                                  Padding(padding: EdgeInsets.only(left: screenWidth * 0.05),
                                    child:
                                    SizedBox(
                                      width: screenWidth * 0.55,
                                      child: Text(list[index].title,
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: screenWidth * 0.012),
                                    child:
                                    SizedBox(
                                      width: screenWidth * 0.288,
                                      child:
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: screenHeight/51,
                                              child: Text('${(list[index].calories / 100 * list[index].weight).toStringAsFixed(2)}ккал.',
                                                style: Theme.of(context).textTheme.bodyMedium,
                                                textAlign: TextAlign.right,
                                              )
                                          ),
                                          Padding(padding: EdgeInsets.only(top: screenHeight/100)),
                                          SizedBox(
                                            height: screenHeight/61,
                                            child:
                                            Text('${list[index].weight.toString()}г.',
                                              style: Theme.of(context).textTheme.bodyMedium,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                    ,)
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
