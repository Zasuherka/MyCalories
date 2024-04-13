import 'package:app1/presentation/constants.dart';
import 'package:flutter/material.dart';

class TitleForGoalPage extends StatelessWidget {
  final String title;
  final Color? color;
  const TitleForGoalPage({super.key, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    
   
    return Row(
      children: [
        Container(
          width: screenHeight/50,
          height: screenHeight/50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color ?? AppColors.turquoise 
          ),
        ),
        SizedBox(width: screenWidth/20),
        Text(title,

          style: Theme.of(context).textTheme.titleSmall,
        )
      ],
    );
  }
}
