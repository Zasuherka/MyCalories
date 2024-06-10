import 'package:app1/presentation/constants.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double height;
  final double width;
  final double borderRadius;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.height = 30,
    this.width = 60,
    this.borderRadius = 20,
  });

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: (){
        value ? onChanged(false) : onChanged(true);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: value ? AppColors.turquoise  : AppColors.secondaryTextColor
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
            child: AnimatedAlign(
              curve: Curves.easeIn,
              duration: animationDurationMedium,
              alignment: value? Alignment.centerRight : Alignment.centerLeft,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: value ? AppColors.turquoise : AppColors.secondaryTextColor,
                  shape: BoxShape.circle,
                ),
                child: SizedBox(
                  width: height,
                  height: height,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
