import 'package:app1/objects/food.dart';
import 'package:app1/service/foodService.dart';
import 'package:app1/widgets/newFood.dart';
import 'package:firebase_database/firebase_database.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
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
              showDialog(context: context, builder: (BuildContext context) => const NewFood());
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
      body: SizedBox(
        child: StreamBuilder(
          stream: getUserFoods(),
          builder: (BuildContext context, AsyncSnapshot<List<Food>> snapshot) {
            if (snapshot.data == null || snapshot.data!.isEmpty) return const Text('Вы не добавили ни одного продукта');
            return ListView.builder(
                padding: EdgeInsets.only(top: screenHeight/300),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index)
                {
                  return
                    Padding(padding: EdgeInsets.only(top: screenHeight/300),
                        child:
                        ///TODO Дописать действие для кнопки продукта
                        GestureDetector(
                          onTap: (){
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: const Color.fromRGBO(16, 240, 12, 1.0),
                                      width: 4
                                  ),
                                  borderRadius: BorderRadius.circular(20.0)
                              ),
                              width: screenWidth,
                              height: screenHeight/10,
                              child: Padding(padding: EdgeInsets.only(left: screenWidth/30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(padding: EdgeInsets.only(left: screenWidth/60)),
                                    Text(
                                      snapshot.data!.elementAt(index).title,
                                      style: TextStyle(
                                        fontSize: screenHeight/30,
                                        fontFamily: 'Comfortaa',
                                        color: const Color.fromRGBO(16, 240, 12, 1.0),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: screenHeight/100)),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: screenWidth/3,
                                          child: Text('${snapshot.data!.elementAt(index).calories.toString()}ккал.',style: TextStyle(
                                            fontSize: screenHeight/50,
                                            fontFamily: 'Comfortaa',
                                            color: const Color.fromRGBO(16, 240, 12, 1.0),
                                          ),
                                          ),
                                        ),
                                        Text('${snapshot.data!.elementAt(index).proteins.toString()}|'
                                            '${snapshot.data!.elementAt(index).fats.toString()}|'
                                            '${snapshot.data!.elementAt(index).carbohydrates.toString()}',style: TextStyle(
                                          fontSize: screenHeight/50,
                                          fontFamily: 'Comfortaa',
                                          color: const Color.fromRGBO(16, 240, 12, 1.0),
                                        ),
                                        )
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
