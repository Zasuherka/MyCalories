import 'package:app1/bloc/foodBloc/food_bloc.dart';
import 'package:app1/constants.dart';
import 'package:app1/objects/food.dart';
import 'package:app1/widgets/foodListView.dart';
import 'package:app1/widgets/newFood.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyFoodPage extends StatefulWidget {
  final bool isAddEatingFood;
  const MyFoodPage({super.key, required this.isAddEatingFood});

  @override
  State<MyFoodPage> createState() => _MyFoodPageState();
}

class _MyFoodPageState extends State<MyFoodPage> {
  late bool isAddEatingFood;
  List<Food> userFoodList = [];
  List<Food> globalFoodList = [];
  TextEditingController searchTextController = TextEditingController();
  String searchText = '';
  _searchListener() {
    searchText = searchTextController.text;
    BlocProvider.of<FoodBloc>(context).add(FindFoodEvent(searchText));
  }
  @override
  void initState() {
    super.initState();
    isAddEatingFood = widget.isAddEatingFood;
    searchTextController.addListener(_searchListener);
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight/17),
            child: Container(
              height: screenHeight/10,
              color: AppColors.green,
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        'images/arrow.svg',
                        width: screenHeight / 27,
                        height: screenHeight / 27,
                        colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                    ),
                    Container(
                      width: screenWidth/1.5,
                      height: screenHeight/20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.backGroundColor,
                      ),
                      child: BlocBuilder<FoodBloc, FoodState>(
                        builder: (context, state) {
                          if(state is GetFoodListState){
                            searchText = '';
                            searchTextController.clear();
                          }
                          if(state is FindFoodListState){
                            //searchTextController.addListener(_searchListener);
                          }
                          return TextField(
                            maxLength: 20,
                            controller: searchTextController,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я0-9.% ]'))],
                            onChanged: (String value){
                            },
                            style: Theme.of(context).textTheme.titleMedium,
                            decoration: InputDecoration(
                                counterText: '',
                                hoverColor: Colors.orange,
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                hintText: 'Поиск',
                                hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.colorForHintText
                                ),
                                contentPadding: EdgeInsets.only(
                                    left: screenWidth * 0.05, right: screenWidth * 0.025,
                                    bottom: screenHeight/200),
                                border: InputBorder.none
                            ),
                          );
                        }
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) => const NewFood());
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          backgroundColor: AppColors.green,
                          foregroundColor: AppColors.green,
                          shadowColor: Colors.transparent),
                      child: SvgPicture.asset(
                        'images/plus.svg',
                        width: screenHeight / 27,
                        height: screenHeight / 27,
                        colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<FoodBloc, FoodState>(
                  builder: (context, state) {
                    if(state is GetFoodListState){
                      userFoodList = state.list;
                      globalFoodList = [];
                    }
                    if(state is FindFoodListState){
                      userFoodList = state.userFoodList;
                      globalFoodList = state.globalFoodList;
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        userFoodList.isNotEmpty ? SizedBox(
                          height: (screenHeight / 200 + screenHeight/10) * userFoodList.length + screenHeight/50,
                          width: screenWidth,
                          child: FoodListView(listFood: userFoodList, isAddEatingFood: isAddEatingFood)
                        ) : const SizedBox(),
                        globalFoodList.isNotEmpty ? SizedBox(
                            height: screenHeight / 45,
                            width: screenWidth,
                            child: Padding(
                              padding: EdgeInsets.only(top: screenHeight/400),
                              child: Text(
                                'Глобальный поиск',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            )
                        ) : const SizedBox(),
                        globalFoodList.isNotEmpty ? SizedBox(
                            height: (screenHeight / 200 + screenHeight/10) * globalFoodList.length + screenHeight/8,
                            width: screenWidth,
                            child: FoodListView(listFood: globalFoodList, isAddEatingFood: isAddEatingFood)
                        ) : const SizedBox(),
                      ],
                    );
                  },
                )
              ],
            ),
          )
      ),
    );
  }
}
