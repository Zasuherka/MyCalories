import 'package:app1/internal/bloc/coach_bloc/coach_bloc.dart';
import 'package:app1/presentation/pages/my_coach_page/coach_page.dart';
import 'package:app1/presentation/pages/my_coach_page/search_coach_page.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MyCoachPage extends StatelessWidget {
  const MyCoachPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CoachBloc coachBloc = context.read<CoachBloc>();
    if (coachBloc.coachId == null) {
      return const SearchCoachPage();
    }
    coachBloc.add(const CoachEvent.getCoachInfo());
    return const CoachPage();
  }
}
