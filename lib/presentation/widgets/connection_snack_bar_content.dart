import 'package:app1/presentation/constants.dart';
import 'package:flutter/material.dart';

class WarningSnackBar extends StatelessWidget {
  final String title;
  final Color textColor;
  final Widget? suffix;
  const WarningSnackBar({
    super.key,
    required this.title,
    this.textColor = AppColors.turquoise,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        surfaceTintColor: Colors.transparent,
        shadowColor: AppColors.dark,
        insetPadding: const EdgeInsets.all(24),
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(suffix != null) ...[
                suffix!,
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
