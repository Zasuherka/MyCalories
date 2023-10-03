import 'package:app1/objects/food.dart';
import 'package:app1/service/foodService.dart';
import 'package:app1/widgets/newFood.dart';
import 'package:app1/widgets/updateFood.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MyFoodPage extends StatefulWidget {
  const MyFoodPage({super.key});

  @override
  State<MyFoodPage> createState() => _MyFoodPageState();
}

class _MyFoodPageState extends State<MyFoodPage> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 238, 238, 1.0),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: const Color.fromRGBO(16, 240, 12, 1.0),
        shadowColor: Colors.transparent,
        title: Text("Моя еда", textAlign: TextAlign.center, style: TextStyle(
          fontSize: screenHeight/29,
          fontFamily: 'Comfortaa',
          color: Colors.white,
        ),
        ),
        leading: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              backgroundColor: const Color.fromRGBO(16, 240, 12, 1.0),
              foregroundColor: const Color.fromRGBO(16, 240, 12, 1.0),
              shadowColor: Colors.transparent
          ),
          child: SvgPicture.asset(
            'images/arrow.svg',
            width: screenHeight/27,
            height: screenHeight/27,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                showDialog(context: context, builder: (BuildContext context) => const NewFood());
              });
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                backgroundColor: const Color.fromRGBO(16, 240, 12, 1.0),
                foregroundColor: const Color.fromRGBO(16, 240, 12, 1.0),
                shadowColor: Colors.transparent
            ),
            child: SvgPicture.asset(
              'images/plus.svg',
              width: screenHeight/27,
              height: screenHeight/27,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ],
      ),
      ///TODO изменить дизайн моей еды подобно дизайну главного экрана, который с диаграммами
      body: SizedBox(
        child: StreamBuilder(
          stream: getUserFoods(),
          builder: (BuildContext context, AsyncSnapshot<List<Food>> snapshot) {
            if (snapshot.data == null || snapshot.data!.isEmpty) return const Text('Вы не добавили ни одного продукта');
            //final listFood = snapshot.data!;
            return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: screenHeight/300),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index)
                {
                  int elementIndex = snapshot.data!.length - 1 - index;
                  return Padding(padding: EdgeInsets.only(top: screenHeight/200, left: screenWidth/100, right: screenWidth/100),
                      child:
                      GestureDetector(
                        onTap: () async {
                          bool deleteFood = await showDialog(context: context, builder: (BuildContext context) => UpdateFood(food: snapshot.data!.elementAt(elementIndex)));
                          //snapshot.data.
                          if (deleteFood){
                            setState(() {
                              snapshot.data!.remove(snapshot.data!.elementAt(elementIndex));
                            });
                          }
                        },
                        child: Container(
                            decoration:
                            BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 13,
                                  offset: Offset(0, 3),
                                ),
                              ],
                                // border: Border.all(color: const Color.fromRGBO(16, 240, 12, 1.0),
                                //     width: 4
                                // ),
                                borderRadius: BorderRadius.circular(15.0)
                            ),
                            width: screenWidth,
                            height: screenHeight/10,
                            child: Padding(padding: EdgeInsets.only(left: screenWidth/20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(padding: EdgeInsets.only(left: screenWidth/60)),
                                  Text(
                                    snapshot.data!.elementAt(elementIndex).title,
                                    style: TextStyle(
                                      fontSize: screenHeight/32,
                                      fontFamily: 'Comfortaa',
                                      color: const Color.fromRGBO(16, 240, 12, 1.0),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: screenHeight/100)),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: screenWidth/3,
                                        child: Text('${snapshot.data!.elementAt(elementIndex).calories.toString()}ккал.',style: TextStyle(
                                          fontSize: screenHeight/50,
                                          fontFamily: 'Comfortaa',
                                          color: const Color.fromRGBO(16, 240, 12, 1.0),
                                        ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth/2.5,
                                        child:
                                        Text('${snapshot.data!.elementAt(elementIndex).protein.toString()}|'
                                            '${snapshot.data!.elementAt(elementIndex).fats.toString()}|'
                                            '${snapshot.data!.elementAt(elementIndex).carbohydrates.toString()}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: screenHeight/50,
                                            fontFamily: 'Comfortaa',
                                            color: const Color.fromRGBO(16, 240, 12, 1.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                        ),
                      )
                  );

                }
            );
          },
        )
      )
    );
  }
}
