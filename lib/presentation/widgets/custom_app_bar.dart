import 'package:app1/presentation/constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    super.key,
    required this.title,
    this.leftIcon,
    this.withoutLeftIcon = false,
    this.withoutRightIcon = false,
    this.rightIcon,
    this.leftOnTap,
    this.rightOnTap
  }) : preferredSize = _PreferredAppBarSize(null, null);

  @override
  final Size preferredSize;

  final String title;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final bool withoutLeftIcon;
  final bool withoutRightIcon;
  final void Function()? leftOnTap;
  final void Function()? rightOnTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: MediaQuery
          .of(context)
          .padding
          .top + 20,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            gradient: AppColors.greenGradient
        ),
      ),
      actions: !withoutRightIcon ? [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: (){
              rightOnTap?.call();
            },
            child: rightIcon ?? SvgPicture.asset(
              'images/mark.svg',
              width: 33,
              height: 33,
              colorFilter: const ColorFilter.mode(AppColors.primaryButtonColor, BlendMode.srcIn),
            ),
          ),
        )
      ] : [],
      leading: !withoutLeftIcon
          ? leftIcon ??
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: leftOnTap ?? () => context.router.popForced(),
                  child: SvgPicture.asset(
                    'images/arrow.svg',
                    width: 33,
                    height: 33,
                    colorFilter:
                        const ColorFilter.mode(AppColors.primaryButtonColor, BlendMode.srcIn),
                  ),
                ),
              )
          : const SizedBox(),
      title: Text(
          title
      ),
      centerTitle: true,
    );
  }
}

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight)
      : super.fromHeight((toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}
