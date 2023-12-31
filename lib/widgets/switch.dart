import 'package:app1/constants.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const CustomSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        value ? onChanged(false) : onChanged(true);
      },
      child: AnimatedContainer(
        duration: animationDurationMedium,
        alignment: value? Alignment.centerRight : Alignment.centerLeft,
        width: screenWidth/5,
        height: screenHeight/20,
        decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: value ? AppColors.green : AppColors.dark
            ),
            borderRadius: BorderRadius.circular(30)
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: screenHeight/20,
          height: screenHeight/20,
          margin: EdgeInsets.fromLTRB(screenWidth/400, screenHeight/200, screenWidth/400, screenHeight/200),
          decoration: BoxDecoration(
              color: value? AppColors.green : AppColors.dark,
              //image: value? const DecorationImage(image: AssetImage('images/icon.png')) : null,
              shape: BoxShape.circle
          ),
        ),
      ),
    );
  }
}
