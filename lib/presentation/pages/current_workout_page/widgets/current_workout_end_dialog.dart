import 'package:app1/presentation/constants.dart';
import 'package:flutter/material.dart';

class CurrentWorkoutEndWarning extends StatelessWidget {
  const CurrentWorkoutEndWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        backgroundColor: AppColors.primaryButtonColor,
          shape: ShapeBorder
      ),
    );
  }
}
