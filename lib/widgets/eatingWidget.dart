import 'package:app1/pages/myFoodPage.dart';
import 'package:app1/service/UserSirvice.dart';
import 'package:app1/widgets/newFood.dart';
import 'package:app1/widgets/wrap1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../objects/eatingFood.dart';
import '../service/foodService.dart';

class EatingWidget extends StatefulWidget {
  final List<EatingFood> list;
  final String title;
  final int calories;
  const EatingWidget({super.key, required this.title, required this.calories, required this.list});

  @override
  State<EatingWidget> createState() => _EatingWidgetState();
}

class _EatingWidgetState extends State<EatingWidget> {
  late double heightWidget;
  late String title;
  late String calories;
  late List<EatingFood> eating;
  late List<EatingFood> list;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = widget.list;
    title = widget.title;
    if (widget.calories > 9999){
      calories = '9999';
    }
    else{
      calories = widget.calories.toString();
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    heightWidget = screenHeight * (list.length + 1) * 0.07;
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
        color: Colors.white,
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
                        style: TextStyle(
                          fontSize: screenHeight/40,
                          fontFamily: 'Comfortaa',
                          color: Colors.black,
                        ),
                      ),
                    )
                ),
                Padding(padding: EdgeInsets.only(left: screenWidth * 0.15),
                  child: SizedBox(
                    width: screenWidth * 0.2,
                    child: Text('$calories ккал',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: screenHeight/60,
                        fontFamily: 'Comfortaa',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: screenWidth * 0.01),
                  child: GestureDetector(
                    onTap: () async {
                      isFood = title;
                      await Navigator.push(context, MaterialPageRoute(builder: (context) => const MyFoodPage(isUpdatePage: false)));
                      setState(() {
                        if(title == 'Завтрак'){
                          list = localUser!.eatingBreakfast;
                        }
                        if(title == 'Обед'){
                          list = localUser!.eatingBreakfast;
                        }
                        if(title == 'Ужин'){
                          list = localUser!.eatingBreakfast;
                        }
                        if(title == 'Другое'){
                          list = localUser!.eatingBreakfast;
                        }
                      });
                    },
                    child: SvgPicture.asset(
                      'images/plus2.svg',
                      width: screenHeight/27,
                      height: screenHeight/27,
                      colorFilter: const ColorFilter.mode(Color.fromRGBO(16, 240, 12, 1.0), BlendMode.srcIn),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
              width: screenWidth * 0.95,
              height: screenHeight * 0.07 * list.length,
              child:
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),//Чтобы не скролился
                  addSemanticIndexes: false,
                  padding: EdgeInsets.zero,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index){
                return Container(
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
                        Padding(padding: EdgeInsets.only(left: screenWidth * 0.05),
                        child:
                          SizedBox(
                            width: screenWidth * 0.55,
                            child: Text(list[index].title,
                              style: TextStyle(
                                fontSize: screenHeight/40,
                                fontFamily: 'Comfortaa',
                                color: Colors.black,
                              ),
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
                                    child: Text('${list[index].calories}ккал.',
                                      style: TextStyle(
                                        fontSize: screenHeight/50,
                                        fontFamily: 'Comfortaa',
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.right,
                                    )
                                ),
                                Padding(padding: EdgeInsets.only(top: screenHeight/100)),
                                SizedBox(
                                  height: screenHeight/61,
                                  child:
                                  Text('${list[index].weight.toString()}г.',
                                    style: TextStyle(
                                      fontSize: screenHeight/60,
                                      fontFamily: 'Comfortaa',
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                          ,)
                      ],
                    )
                );
              })
          )
        ],
      ),
    );
  }
}
