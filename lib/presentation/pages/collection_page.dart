import 'package:app1/presentation/constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@AutoRouter()
class CollectionPage extends StatelessWidget {
  final String collectionId;
  const CollectionPage({super.key, required this.collectionId});

  @override
  Widget build(BuildContext context) {
    final listFood = [];
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            toolbarHeight: MediaQuery.of(context).padding.top + 20,
            //expandedHeight: MediaQuery.of(context).padding.top + 20,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: AppColors.greenGradient
              ),),
            title: const Text('Ныборы еды'),
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.only(left: 23),
              child: Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(
                  maxWidth: 33,
                  maxHeight: 33,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    'images/arrow.svg',
                    width: 33,
                    height: 33,
                    colorFilter:
                    const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            actions: [
              Padding(padding: EdgeInsets.only(right: screenWidth/20),
                child: GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    'images/plus.svg',
                    width: 33,
                    height: 33,
                    colorFilter:
                    const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
