import 'package:app1/presentation/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConnectionSnackBar extends StatelessWidget {
  const ConnectionSnackBar({super.key});

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
              SvgPicture.asset(
                'images/wi-fi_off.svg',
                height: 20,
                width: 20,
                colorFilter: const ColorFilter.mode(AppColors.turquoise, BlendMode.srcIn),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Подключение к интернету отсутствует',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.turquoise,
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
