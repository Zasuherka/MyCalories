import 'package:flutter/material.dart';

class NewFood extends StatelessWidget {
  const NewFood({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child:
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30)
          ),
          width: screenWidth/1.3,
          height: screenHeight/3.5,
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(top: screenHeight/100)),
              SizedBox(
                width: screenWidth/2,
                height: screenHeight/14,
                child: TextField(
                  onChanged: (String value){
                    /// TODO доделать запись значения
                  },
                  style: TextStyle(
                      fontSize: screenHeight/40,
                      fontFamily: 'Comfortaa',
                      color: Colors.black
                  ),
                  decoration: InputDecoration(   hoverColor: Colors.orange,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: 'Название',
                    hintStyle: TextStyle(
                        fontSize: screenHeight/40,
                        fontFamily: 'Comfortaa',
                        color: const Color.fromRGBO(0, 0, 0, 0.1)
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                    contentPadding: const EdgeInsets.only(bottom: -10),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
