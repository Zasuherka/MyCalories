import 'package:app1/internal/bloc/food_bloc/food_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/domain/model/food.dart';
import 'package:app1/presentation/pages/my_food_page/widgets/food_list_view.dart';
import 'package:app1/presentation/pages/my_food_page/widgets/new_food.dart';
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
  final TextEditingController _searchTextController = TextEditingController();
  String _searchText = '';
  _searchListener() {
    _searchText = _searchTextController.text;
    BlocProvider.of<FoodBloc>(context)
        .add(FoodEvent.findFood(searchText: _searchText));
  }
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FoodBloc>(context)
        .add(const FoodEvent.getFoodList());
    isAddEatingFood = widget.isAddEatingFood;
    _searchTextController.addListener(_searchListener);
  }

  @override
  void dispose() {
    _searchTextController.dispose();
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
            preferredSize: Size.fromHeight(MediaQuery.of(context).padding.top + 20),
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.greenGradient,
              ),
              padding: const EdgeInsets.only(bottom: 5),
              alignment: Alignment.bottomCenter,
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
                      width: 33,
                      height: 33,
                      colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ) : const SizedBox(),
                  BlocBuilder<FoodBloc, FoodState>(
                      builder: (context, state) {
                        state.whenOrNull(
                            listFood: (_) {
                              _searchText = '';
                              _searchTextController.clear();
                            },
                            findListFood: (_, __) =>
                                _searchTextController.addListener(_searchListener)
                        );
                        return TextField(
                          maxLength: 20,
                          controller: _searchTextController,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я0-9.% ]'))],
                          onChanged: (String value){
                          },
                          textAlignVertical: TextAlignVertical.bottom,
                          style: Theme.of(context).textTheme.titleMedium,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () => _searchTextController.text = '',
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
                              contentPadding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
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
                      width: 33,
                      height: 33,
                      colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                ],
              )
            ),
            ),
          body: SingleChildScrollView(
            child: BlocBuilder<FoodBloc, FoodState>(
              builder: (context, state) {
                bool stateIsNotLoading = true;
                state.whenOrNull(
                    loading: () {
                      stateIsNotLoading = false;
                    },
                    listFood: (list) {
                      userFoodList = list;
                      globalFoodList = [];
                    },
                    findListFood: (userFoodList, globalFoodList) {
                      this.userFoodList = userFoodList;
                      this.globalFoodList = globalFoodList;
                    }
                );
                return stateIsNotLoading ? Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    userFoodList.isNotEmpty
                      ? SizedBox(
                          height: 84 * userFoodList.length + 10,
                          width: screenWidth,
                          child: FoodListView(
                              listFood: userFoodList,
                              isAddEatingFood: isAddEatingFood))
                      : const SizedBox(),
                    globalFoodList.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.only(top: 3),
                          height: 30,
                          width: screenWidth,
                          child: Text(
                            'Глобальный поиск',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  globalFoodList.isNotEmpty
                      ? SizedBox(
                          height: 84 * globalFoodList.length +
                              screenHeight / 8,
                          width: screenWidth,
                          child: FoodListView(
                              listFood: globalFoodList,
                              isAddEatingFood: isAddEatingFood))
                      : const SizedBox(),
                ],
                ) : Center(
                  child: Image.asset('images/bouncing-circles.gif',
                    height: 100,
                    alignment: Alignment.topCenter,
                  ),
                );
              },
            )
          )
      ),
    );
  }
}
