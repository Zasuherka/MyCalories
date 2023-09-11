import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MyFoodPage extends StatelessWidget {
  const MyFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    List listFood = [['Творог','16.0|15.0|3.5'],['Курица тушёная','25.0|10.0|15,.0']];
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
        child: ListView.builder(
            padding: EdgeInsets.only(top: screenHeight/300),
            itemCount: listFood.length,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(listFood[index][0],style: TextStyle(
                              fontSize: screenHeight/30,
                              fontFamily: 'Comfortaa',
                              color: const Color.fromRGBO(16, 240, 12, 1.0),
                            ),
                            ),
                            Padding(padding: EdgeInsets.only(top: screenHeight/100)),
                            Text(listFood[index][1],style: TextStyle(
                              fontSize: screenHeight/50,
                              fontFamily: 'Comfortaa',
                              color: const Color.fromRGBO(16, 240, 12, 1.0),
                            ),
                            )
                          ],
                        ),
                      ),
                    )
                );
            }
            )
      )
    );
  }
}
