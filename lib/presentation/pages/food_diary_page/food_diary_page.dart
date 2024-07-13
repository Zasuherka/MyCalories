import 'package:app1/internal/cubit/food_diary_cubit/food_diary_cubit.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/pages/food_diary_page/widgets/eating_charts.dart';
import 'package:app1/presentation/pages/food_diary_page/widgets/eating_widget.dart';
import 'package:app1/presentation/widgets/custom_app_bar.dart';
import 'package:app1/utils/extensions/context_extensions.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

@RoutePage()
class FoodDiaryPage extends StatelessWidget {
  const FoodDiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FoodDiaryCubit foodDiaryCubit = context.read<FoodDiaryCubit>();
    return BlocBuilder<FoodDiaryCubit, FoodDiaryState>(
      builder: (context, state) {
        return Scaffold(
            appBar: CustomAppBar(
              title: foodDiaryCubit.selectedDate == null
                  ? context.localization.diary
                  : DateFormat('dd.MM.yyyy').format(foodDiaryCubit.selectedDate!),
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
                  foodDiaryCubit.getEatingByData(pickedDate);
                }
              },
            ),
            body: state.maybeMap(
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
                if (foodDiaryCubit.calories == 0) return const SizedBox();
                return Padding(
                  padding: const EdgeInsets.all(7),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        EatingCharts(
                          calories: foodDiaryCubit.calories,
                          protein: foodDiaryCubit.protein,
                          fats: foodDiaryCubit.fats,
                          carbohydrates: foodDiaryCubit.carbohydrates,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        EatingWidget(
                            title: 'Завтрак',
                            calories: foodDiaryCubit.breakfastCalories.toStringAsFixed(2),
                            list: foodDiaryCubit.breakfast),
                        const SizedBox(
                          height: 10,
                        ),
                        EatingWidget(
                            title: 'Обед',
                            calories: foodDiaryCubit.lunchCalories.toStringAsFixed(2),
                            list: foodDiaryCubit.lunch),
                        const SizedBox(
                          height: 10,
                        ),
                        EatingWidget(
                            title: 'Ужин',
                            calories: foodDiaryCubit.dinnerCalories.toStringAsFixed(2),
                            list: foodDiaryCubit.dinner),
                        const SizedBox(
                          height: 10,
                        ),
                        EatingWidget(
                            title: 'Другое',
                            calories: foodDiaryCubit.anotherCalories.toStringAsFixed(2),
                            list: foodDiaryCubit.another),
                      ],
                    ),
                  ),
                );
              },
            ));
      },
    );
  }
}
