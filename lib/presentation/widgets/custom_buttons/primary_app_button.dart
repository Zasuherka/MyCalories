import 'package:app1/presentation/constants.dart';
import 'package:flutter/material.dart';

class PrimaryAppButton extends StatelessWidget {
  const PrimaryAppButton({
    super.key,
    required this.onTap,
    required this.child,
    this.withColor = false,
    this.isActive = true,
    this.isLoading = false,
    this.height,
    this.gradient,
    this.width,
    this.color,
    this.borderRadius,
    this.alignment = Alignment.center,
    this.padding,
    this.margin = EdgeInsets.zero,
    this.inactiveGradient,
    this.inactiveColor,
  });


  final void Function() onTap;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry margin;
  final Alignment alignment;
  final Gradient? gradient;
  final Gradient? inactiveGradient;
  final double? height;
  final double? width;
  final Color? color;
  final Color? inactiveColor;
  final bool withColor;
  final double? borderRadius;
  final bool isActive;
  final bool isLoading;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius ?? 25),
        onTap: () => onTap.call(),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: !withColor
                ? (isActive
                    ? gradient ?? AppColors.greenGradient
                    : inactiveGradient ?? AppColors.inactiveGreenGradient)
                : null,
            color: isActive
                ? color ?? AppColors.primaryButtonColor
                : inactiveColor ?? AppColors.inactivePrimaryButtonColor,
            boxShadow: boxShadow,
            borderRadius: BorderRadius.circular(borderRadius ?? 25),
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: SizedBox(
                height: height,
                width: width,
                child: Align(
                  alignment: alignment,
                  child: child,
                ),
            ),
          ),
        ),
      ),
    );
  }
}
