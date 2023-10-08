import 'package:app1/widgets/addFoodWidget.dart';
import 'package:app1/widgets/listFood.dart';
import 'package:app1/widgets/newFood.dart';
import 'package:app1/widgets/updateFood.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app1/service/UserSirvice.dart';


class MyFoodPage extends StatefulWidget {
  final bool isUpdatePage;
  const MyFoodPage({super.key, required this.isUpdatePage});

  @override
  State<MyFoodPage> createState() => _MyFoodPageState();
}

class _MyFoodPageState extends State<MyFoodPage> {
  late bool isUpdatePage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isUpdatePage = widget.isUpdatePage;

  }

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
            onPressed: () async{
              await showDialog(context: context, builder: (BuildContext context) => const NewFood());
              setState(()  {
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
      body: SizedBox(
          child:
          ListView.builder(
            padding: EdgeInsets.only(top: screenHeight/300),
            itemCount: localUser!.myFoods.length,
            itemBuilder: (BuildContext context, int index) {
              int elementIndex = localUser!.myFoods.length - 1 - index;
              return Padding(padding: EdgeInsets.only(top: screenHeight/200, left: screenWidth/100, right: screenWidth/100),
                  child:
                  GestureDetector(
                    onTap: () async{
                      print(isUpdatePage);
                      if(isUpdatePage){
                        await showDialog(context: context, builder: (BuildContext context) => UpdateFood(food: localUser!.myFoods[elementIndex]));
                        setState(() {});
                      }
                      else{
                        bool response = await showDialog(context: context, builder: (BuildContext context) => AddFood(food: localUser!.myFoods[elementIndex]));
                        if (response){
                          Navigator.pop(context);
                        }
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
                                offset: const Offset(0, 5),
                              ),
                            ],
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
                              SizedBox(
                                height: screenHeight/31,
                                child:
                                Text(
                                  localUser!.myFoods.elementAt(elementIndex).title,
                                  style: TextStyle(
                                    fontSize: screenHeight/32,
                                    fontFamily: 'Comfortaa',
                                    color: const Color.fromRGBO(16, 240, 12, 1.0),
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: screenHeight/100)),
                              Row(
                                children: [
                                  SizedBox(
                                    width: screenWidth/3,
                                    child: Text('${localUser!.myFoods.elementAt(elementIndex).calories.toString()}ккал.',style: TextStyle(
                                      fontSize: screenHeight/50,
                                      fontFamily: 'Comfortaa',
                                      color: const Color.fromRGBO(16, 240, 12, 1.0),
                                    ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth/2.5,
                                    child:
                                    Text('${localUser!.myFoods.elementAt(elementIndex).protein.toString()}|'
                                        '${localUser!.myFoods.elementAt(elementIndex).fats.toString()}|'
                                        '${localUser!.myFoods.elementAt(elementIndex).carbohydrates.toString()}',
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
            },
          )
      )
    );
  }
}
