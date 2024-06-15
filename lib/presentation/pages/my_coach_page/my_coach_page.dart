import 'package:app1/presentation/pages/my_coach_page/coach_page.dart';
import 'package:app1/presentation/pages/my_coach_page/search_coach_page.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MyCoachPage extends StatelessWidget {
  final String? coachId;
  const MyCoachPage({super.key, required this.coachId});

  @override
  Widget build(BuildContext context) {
    if(coachId == null){
      return const SearchCoachPage();
    }
    return const CoachPage();
  }
}
