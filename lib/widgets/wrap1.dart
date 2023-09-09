import 'package:flutter/material.dart';

class Wrap1 extends StatelessWidget {
  const Wrap1({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Wrap(
      children: [
        Container(
          height: height/20,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Изменить фотографию',
                  style: TextStyle(
                    fontSize: height/55,
                    fontFamily: 'Comfortaa',
                    color: Colors.black,
                  ),
                )
              ],
            ),
            onTap: (){
            },
          ),
        ),
        Container(
          height: height/20,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Отмена',
                  style: TextStyle(
                    fontSize: height/55,
                    fontFamily: 'Comfortaa',
                    color: Colors.black,
                  ),
                )
              ],
            ),
            onTap: (){
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }
}
