import 'package:app1/bloc/foodBloc/food_bloc.dart';
import 'package:app1/colors/colors.dart';
import 'package:app1/objects/food.dart';
import 'package:app1/widgets/foodListView.dart';
import 'package:app1/widgets/newFood.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyFoodPage extends StatefulWidget {
  final bool isUpdatePage;
  const MyFoodPage({super.key, required this.isUpdatePage});

  @override
  State<MyFoodPage> createState() => _MyFoodPageState();
}

class _MyFoodPageState extends State<MyFoodPage> {
  late bool isUpdatePage;
  List<Food> userFoodList = [];
  List<Food> globalFoodList = [];
  TextEditingController searchTextController = TextEditingController();
  String searchText = '';
  void _searchListener() {
    searchText = searchTextController.text;
    BlocProvider.of<FoodBloc>(context).add(FindFoodEvent(searchText));
  }
  @override
  void initState() {
    super.initState();
    isUpdatePage = widget.isUpdatePage;
    searchTextController.addListener(_searchListener);
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: AppColors.backGroundColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight/17),
            child: Container(
              height: screenHeight/10,
              color: AppColors.green,
              child: Padding(
                padding: EdgeInsets.only(bottom: screenHeight/200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          backgroundColor: AppColors.green,
                          foregroundColor: AppColors.green,
                          shadowColor: Colors.transparent),
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
                            style: TextStyle(
                                fontSize: screenHeight/40,
                                fontFamily: 'Comfortaa',
                                color: Colors.black
                            ),
                            decoration: InputDecoration(
                                counterText: '',
                                hoverColor: Colors.orange,
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                hintText: 'Поиск',
                                hintStyle: TextStyle(
                                    fontSize: screenHeight/40,
                                    fontFamily: 'Comfortaa',
                                    color: const Color.fromRGBO(0, 0, 0, 0.2)
                                ),
                                contentPadding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.025),
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
                          child: FoodListView(listFood: userFoodList, isUpdatePage: isUpdatePage)
                        ) : Container(),
                        globalFoodList.isNotEmpty ? SizedBox(
                            height: screenHeight / 45,
                            width: screenWidth,
                            child: Padding(
                              padding: EdgeInsets.only(top: screenHeight/400),
                              child: Text(
                                'Глобальный поиск',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: screenHeight / 50,
                                  fontFamily: 'Comfortaa',
                                  color: const Color(0xff2D2D2D),
                                ),
                              ),
                            )
                        ) : Container(),
                        globalFoodList.isNotEmpty ? SizedBox(
                            height: (screenHeight / 200 + screenHeight/10) * globalFoodList.length + screenHeight/8,
                            width: screenWidth,
                            child: FoodListView(listFood: globalFoodList, isUpdatePage: isUpdatePage)
                        ) : Container(),
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
