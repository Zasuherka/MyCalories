import 'package:app1/internal/bloc/wards_bloc/wards_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/pages/food_diary_page/widgets/eating_charts.dart';
import 'package:app1/presentation/pages/food_diary_page/widgets/eating_widget.dart';
import 'package:app1/presentation/widgets/custom_app_bar.dart';
import 'package:app1/utils/extensions/context_extensions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

@RoutePage()
class WardFoodDiaryPage extends StatelessWidget {
  const WardFoodDiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final WardsBloc wardsBloc = context.read<WardsBloc>();
    return BlocBuilder<WardsBloc, WardsState>(
      builder: (context, state) {
        return Scaffold(
            appBar: CustomAppBar(
              title: wardsBloc.selectedDate == null
                  ? context.localization.diary
                  : DateFormat('dd.MM.yyyy').format(wardsBloc.selectedDate!),
              rightIcon: const Icon(
                Icons.calendar_month,
                color: AppColors.primaryButtonColor,
                size: 33,
              ),
              rightOnTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                    locale: const Locale('ru', 'RU'),
                    helpText: 'Выберите дату рождения',
                    cancelText: 'Отмена',
                    confirmText: 'Ок',
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950, 1),
                    lastDate: DateTime(2101));
                if (pickedDate != null) {
                  wardsBloc.add(WardsEvent.getInfoAboutFoodDiaryWard(dateTime: pickedDate));
                }
              },
              leftOnTap: (){
                wardsBloc.resetData();
                context.router.popForced();
              },
            ),
            body: PopScope(
              onPopInvoked: (canPop){
                wardsBloc.resetData();
              },
              child: state.maybeMap(
                loading: (_) => Center(
                  child: Image.asset(
                    'images/bouncing-circles.gif',
                    height: 100,
                  ),
                ),
                initial: (_) => Center(
                  child: Text(
                    'Выберите интересующую дату',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: AppColors.secondaryTextColor),
                  ),
                ),
                orElse: () {
                  if (wardsBloc.calories == 0) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.all(7),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          EatingCharts(
                            calories: wardsBloc.calories,
                            protein: wardsBloc.protein,
                            fats: wardsBloc.fats,
                            carbohydrates: wardsBloc.carbohydrates,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          EatingWidget(
                              title: 'Завтрак',
                              calories: wardsBloc.breakfastCalories.toStringAsFixed(2),
                              list: wardsBloc.breakfast),
                          const SizedBox(
                            height: 10,
                          ),
                          EatingWidget(
                              title: 'Обед',
                              calories: wardsBloc.lunchCalories.toStringAsFixed(2),
                              list: wardsBloc.lunch),
                          const SizedBox(
                            height: 10,
                          ),
                          EatingWidget(
                              title: 'Ужин',
                              calories: wardsBloc.dinnerCalories.toStringAsFixed(2),
                              list: wardsBloc.dinner),
                          const SizedBox(
                            height: 10,
                          ),
                          EatingWidget(
                              title: 'Другое',
                              calories: wardsBloc.anotherCalories.toStringAsFixed(2),
                              list: wardsBloc.another),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ));
      },
    );
  }
}
