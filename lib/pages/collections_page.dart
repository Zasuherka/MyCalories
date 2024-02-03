import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants.dart';


@RoutePage()
class CollectionsPage extends StatefulWidget {
  const CollectionsPage({super.key});

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Коллекции еды'),
        leading: Padding(
          padding: EdgeInsets.only(left: screenWidth/40),
          child: Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(
              maxWidth: screenHeight/27,
              maxHeight: screenHeight/27,
            ),
            child: GestureDetector(
              onTap: () {
                //BlocProvider.of<UserInfoBloc>(context).add(LocalUserInfoEvent());
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                'images/arrow.svg',
                width: screenHeight / 27,
                height: screenHeight / 27,
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
                width: screenHeight / 27,
                height: screenHeight / 27,
                colorFilter:
                const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
              ),
            ),)
        ],
      ),
    );
  }
}