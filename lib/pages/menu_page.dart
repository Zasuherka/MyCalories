import 'package:app1/bloc/food_bloc/food_bloc.dart';
import 'package:app1/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:app1/pages/collections_page.dart';
import 'package:app1/pages/goal_page.dart';
import 'package:app1/pages/my_food_page.dart';
import 'package:app1/constants.dart';
import 'package:app1/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    
   
    final double widthHeightImage = screenWidth/2.1;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + screenHeight/200)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    BlocProvider.of<FoodBloc>(context).add(const FoodEvent.getFoodList());
                    context.router.push(MyFoodRoute(isAddEatingFood: false));
                  },
                  child: Container(
                    height: widthHeightImage,
                    width:  widthHeightImage,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.asset('images/foodImage.jpg').image
                      )
                    ),
                    child: Center(
                      child:
                      Text(
                          'Моя еда',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.white
                          )
                      ),
                    )
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    context.router.push(const CollectionsRoute());
                  },
                  child: Container(
                    height: widthHeightImage,
                    width:  widthHeightImage,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.asset('images/collectionFood.jpg').image
                        )
                    ),
                    child: Center(
                      child:
                      Text(
                          'Колекции еды',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.white
                          )
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(top: screenWidth/63)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    //BlocProvider.of<UserInfoBloc>(context).add(LocalUserInfoEvent());
                    context.router.push(const GoalRoute());
                  },
                  child: Container(
                    height: widthHeightImage,
                    width:  widthHeightImage,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.asset('images/PFCC.jpg').image
                        )
                    ),
                    child: Center(
                      child:
                      Text(
                          'Мои КБЖУ',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.white
                          )
                      ),
                    ),
                  ),
                ),
                Container(
                  height: widthHeightImage,
                  width:  widthHeightImage,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.asset('images/recipes.jpg').image
                      )
                  ),
                  child: Center(
                    child:
                    Text(
                        'Рецепты',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.white
                        )
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
