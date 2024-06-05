import 'package:app1/internal/bloc/food_bloc/food_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/domain/model/food.dart';
import 'package:app1/presentation/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class CreateCollectionPage extends StatefulWidget {
  const CreateCollectionPage({super.key});

  @override
  State<CreateCollectionPage> createState() => _CreateCollectionPageState();
}

class _CreateCollectionPageState extends State<CreateCollectionPage> {

  final TextEditingController _searchTextController = TextEditingController();
  List<Food> _userFoodList = [];
  List<Food> _globalFoodList = [];
  final List<Food> _listSelectedFood = [];


  String _searchText = '';
  void _searchListener() {
    if(_searchTextController.text == ' '){
      _searchTextController.text = '';
      return;
    }
    _searchText = _searchTextController.text;
    BlocProvider.of<FoodBloc>(context)
        .add(FoodEvent.findFood(searchText: _searchText));
  }

  @override
  void initState() {
    super.initState();
    _searchTextController.addListener(_searchListener);
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  void _writeFoodInList(Food food) {
    setState(() {
      _listSelectedFood.contains(food)
          ? _listSelectedFood.remove(food)
          : _listSelectedFood.add(food);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          state.whenOrNull(
              listFood: (list) {
                _userFoodList = list;
                _globalFoodList = [];
              },
              findListFood: (userFoodList, globalFoodList) {
                _userFoodList = userFoodList;
                _globalFoodList = globalFoodList;
              }
          );
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    toolbarHeight: MediaQuery.of(context).padding.top + 20,
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
                          gradient: AppColors.greenGradient
                      ),),
                    title: const Text('Создать набор'),
                    centerTitle: true,
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        alignment: Alignment.center,
                        constraints: const BoxConstraints(
                          maxWidth: 33,
                          maxHeight: 33,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(
                            'images/arrow.svg',
                            width: 33,
                            height: 33,
                            colorFilter:
                            const ColorFilter.mode(AppColors.primaryButtonColor, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ),
                    actions: [
                      Padding(padding: const EdgeInsets.only(right: 20),
                        child: GestureDetector(
                          onTap: () {
                            if(_listSelectedFood.isNotEmpty){
                              context.router.push(SaveCollectionRoute(
                                  listFood: _listSelectedFood
                              ));
                            }
                          },
                          child: SvgPicture.asset(
                            'images/mark.svg',
                            width: 33,
                            height: 33,
                            colorFilter:
                            const ColorFilter.mode(AppColors.primaryButtonColor, BlendMode.srcIn),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: TextField(
                        controller: _searchTextController,
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () => _searchTextController.text = '',
                              child: const Icon(
                                Icons.close,
                                color: AppColors.colorForHintText,
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            constraints: BoxConstraints.tightFor(width: screenWidth - 300),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: AppColors.turquoise
                                ),
                                borderRadius: BorderRadius.circular(30)
                            ),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: AppColors.turquoise
                                ),
                                borderRadius: BorderRadius.circular(30)
                            ),
                            hintText: 'Поиск',
                            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppColors.colorForHintText
                            )
                        ),
                      ),
                    ),
                  ),
                  SliverList.builder(
                      itemCount: _userFoodList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final food = _userFoodList[_userFoodList.length - 1 - index];
                        final textColor = _listSelectedFood.contains(food)
                            ? AppColors.primaryButtonColor
                            : AppColors.secondaryTextColor;
                        return GestureDetector(
                          onTap: () => _writeFoodInList(food),
                          child: Container(
                            margin: const EdgeInsets.only(
                              top: 7,
                              left: 7,
                              right: 7,
                            ),
                            height: 77,
                            decoration: BoxDecoration(
                                color: _listSelectedFood.contains(food)
                                    ? null
                                    : AppColors.elementColor,
                                gradient: _listSelectedFood.contains(food)
                                    ? AppColors.greenGradient
                                    : null,
                                boxShadow: boxShadow,
                                borderRadius: BorderRadius.circular(25.0)),
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Spacer(),
                                Text(
                                  food.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: textColor
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 130,
                                      child: Text(
                                        '${food.calories.toString()}ккал.',
                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                            color: textColor
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 180,
                                      child: Text(
                                        '${food.protein.toStringAsFixed(2)}|'
                                            '${food.fats.toStringAsFixed(2)}|'
                                            '${food.carbohydrates.toStringAsFixed(2)}',
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                            color: textColor
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        );
                      }
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _globalFoodList.isNotEmpty ? const Align(
                        alignment: Alignment.center,
                        child: Text('Глобальный поиск')
                    ) : const SizedBox(),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  SliverList.builder(
                      itemCount: _globalFoodList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final food = _globalFoodList[_globalFoodList.length - 1 - index];
                        final textColor = _listSelectedFood.contains(food)
                            ? AppColors.primaryButtonColor
                            : AppColors.secondaryTextColor;
                        return GestureDetector(
                          onTap: () => _writeFoodInList(food),
                          child: Container(
                            margin: const EdgeInsets.only(
                              top: 7,
                              left: 7,
                              right: 7,
                            ),
                            height: 77,
                            decoration: BoxDecoration(
                                color: _listSelectedFood.contains(food)
                                    ? null
                                    : AppColors.elementColor,
                                gradient: _listSelectedFood.contains(food)
                                    ? AppColors.greenGradient
                                    : null,
                                boxShadow: boxShadow,
                                borderRadius: BorderRadius.circular(25.0)),
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Spacer(),
                                Text(
                                  food.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: textColor
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 130,
                                      child: Text(
                                        '${food.calories.toString()}ккал.',
                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                            color: textColor
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 180,
                                      child: Text(
                                        '${food.protein.toStringAsFixed(2)}|'
                                            '${food.fats.toStringAsFixed(2)}|'
                                            '${food.carbohydrates.toStringAsFixed(2)}',
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                            color: textColor
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        );
                      })
                ]
            ),
          );
        },
),
    );
  }
}
