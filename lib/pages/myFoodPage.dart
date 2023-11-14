import 'package:app1/bloc/foodBloc/food_bloc.dart';
import 'package:app1/objects/food.dart';
import 'package:app1/widgets/addFoodWidget.dart';
import 'package:app1/widgets/newFood.dart';
import 'package:app1/widgets/updateFood.dart';
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
  List<Food> foodList = [];
  TextEditingController searchTextController = TextEditingController();
  String searchText = '';
  Future _searchListener() async {
    searchText = searchTextController.text;
    print(searchText);
    searchText == ''
        ? BlocProvider.of<FoodBloc>(context).add(FoodInitialEvent())
        : BlocProvider.of<FoodBloc>(context).add(FindFoodEvent(searchText));
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
    return Scaffold(
        backgroundColor: const Color.fromRGBO(238, 238, 238, 1.0),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight/17),
          child: Container(
            height: screenHeight/10,
            color: const Color.fromRGBO(16, 240, 12, 1.0),
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
                        backgroundColor: const Color.fromRGBO(16, 240, 12, 1.0),
                        foregroundColor: const Color.fromRGBO(16, 240, 12, 1.0),
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
                      color: const Color.fromRGBO(238, 238, 238, 1.0),
                    ),
                    child: TextField(
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
                        backgroundColor: const Color.fromRGBO(16, 240, 12, 1.0),
                        foregroundColor: const Color.fromRGBO(16, 240, 12, 1.0),
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
                    foodList = state.list;
                  }
                  return SizedBox(
                    height: (screenHeight / 200 + screenHeight/10) * foodList.length + screenHeight/10,
                    width: screenWidth,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: screenHeight / 300),
                      itemCount: foodList.length,
                      itemBuilder: (BuildContext context, int index) {
                        int elementIndex = foodList.length - 1 - index;
                        return Padding(
                            padding: EdgeInsets.only(
                                top: screenHeight / 200,
                                left: screenWidth / 100,
                                right: screenWidth / 100),
                            child:
                            GestureDetector(
                              onTap: () async {
                                if (isUpdatePage) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) => UpdateFood(
                                          food: foodList[elementIndex]));
                                  setState(() {});
                                } else {
                                  bool response = await showDialog(
                                      context: context,
                                      builder: (BuildContext context) => AddFood(food: foodList[elementIndex]));
                                  if (response) {
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 13,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(15.0)),
                                  width: screenWidth,
                                  height: screenHeight / 10,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: screenWidth / 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: screenWidth / 60)),
                                        SizedBox(
                                          height: screenHeight / 29,
                                          child: Text(
                                            foodList.elementAt(elementIndex).title,
                                            style: TextStyle(
                                              fontSize: screenHeight / 32,
                                              fontFamily: 'Comfortaa',
                                              color: const Color.fromRGBO(
                                                  16, 240, 12, 1.0),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: screenHeight / 100)),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: screenWidth / 3,
                                              child: Text(
                                                '${foodList.elementAt(elementIndex).calories.toString()}ккал.',
                                                style: TextStyle(
                                                  fontSize: screenHeight / 50,
                                                  fontFamily: 'Comfortaa',
                                                  color: const Color.fromRGBO(
                                                      16, 240, 12, 1.0),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth / 2.5,
                                              child: Text(
                                                '${foodList.elementAt(elementIndex).protein.toStringAsFixed(2)}|'
                                                    '${foodList.elementAt(elementIndex).fats.toStringAsFixed(2)}|'
                                                    '${foodList.elementAt(elementIndex).carbohydrates.toStringAsFixed(2)}',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: screenHeight / 50,
                                                  fontFamily: 'Comfortaa',
                                                  color: const Color.fromRGBO(
                                                      16, 240, 12, 1.0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            )
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        )
    );
  }
}
