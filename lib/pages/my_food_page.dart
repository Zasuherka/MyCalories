import 'package:app1/bloc/food_bloc/food_bloc.dart';
import 'package:app1/constants.dart';
import 'package:app1/models/food.dart';
import 'package:app1/widgets/food_list_view.dart';
import 'package:app1/widgets/new_food.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
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
    BlocProvider.of<FoodBloc>(context)
        .add(FoodEvent.findFood(searchText: searchText));
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
              decoration: const BoxDecoration(
                gradient: AppColors.greenGradient,
              ),
              height: screenHeight/10,
              //color: AppColors.turquoise ,
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    context.router.canPop() ? GestureDetector(
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
                    ) : const SizedBox(),
                    BlocBuilder<FoodBloc, FoodState>(
                        builder: (context, state) {
                          state.whenOrNull(
                              listFood: (_) {
                                searchText = '';
                                searchTextController.clear();
                                },
                              findListFood: (_, __) =>
                                  searchTextController.addListener(_searchListener)
                          );
                          return TextField(
                            maxLength: 20,
                            controller: searchTextController,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я0-9.% ]'))],
                            onChanged: (String value){
                            },
                            textAlignVertical: TextAlignVertical.bottom,
                            style: Theme.of(context).textTheme.titleMedium,
                            decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () => searchTextController.text = '',
                                  child: const Icon(
                                    Icons.close,
                                    color: AppColors.colorForHintText,
                                  ),
                                ),
                                filled: true,
                                fillColor: AppColors.white,
                                counterText: '',
                                hintText: 'Поиск',
                                hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.colorForHintText
                                ),
                                constraints: BoxConstraints(
                                  maxHeight: screenHeight/20,
                                  maxWidth: context.router.canPop()
                                      ? screenWidth/1.5
                                      : screenWidth/1.3
                                ),
                                contentPadding: EdgeInsets.only(
                                    left: screenWidth/20,
                                    right: screenWidth/20,
                                    top: 8,
                                    bottom: 8
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(30)
                                )
                            ),
                          );
                        }
                    ),
                    GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            //barrierColor: AppColors.barrierColor,
                            builder: (BuildContext context) => const NewFood());
                        setState(() {});
                      },
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
            child: BlocBuilder<FoodBloc, FoodState>(
              builder: (context, state) {
                state.whenOrNull(
                    listFood: (list) {
                      userFoodList = list;
                      globalFoodList = [];
                    },
                    findListFood: (userFoodList, globalFoodList) {
                      this.userFoodList = userFoodList;
                      this.globalFoodList = globalFoodList;
                    }
                );
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    userFoodList.isNotEmpty
                      ? SizedBox(
                          height: (screenHeight / 200 + screenHeight / 10) *
                                  userFoodList.length + screenHeight / 50,
                          width: screenWidth,
                          child: FoodListView(
                              listFood: userFoodList,
                              isAddEatingFood: isAddEatingFood))
                      : const SizedBox(),
                  globalFoodList.isNotEmpty
                      ? Container(
                          padding: EdgeInsets.only(top: screenHeight / 400),
                          height: screenHeight / 35,
                          width: screenWidth,
                          child: Text(
                            'Глобальный поиск',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: screenHeight / 100,
                  ),
                  globalFoodList.isNotEmpty
                      ? SizedBox(
                          height: (screenHeight / 200 + screenHeight / 10) *
                                  globalFoodList.length +
                              screenHeight / 8,
                          width: screenWidth,
                          child: FoodListView(
                              listFood: globalFoodList,
                              isAddEatingFood: isAddEatingFood))
                      : const SizedBox(),
                ],
                );
              },
            )
          )
      ),
    );
  }
}
