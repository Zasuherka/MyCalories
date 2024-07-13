import 'package:app1/domain/model/workout/exercise_round_set.dart';
import 'package:app1/internal/cubit/workout_cubit/workout_cubit.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/widgets/workout/text_fields/active_number_circles.dart';
import 'package:app1/presentation/widgets/workout/text_fields/active_workout_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorkoutRoundSetActive extends StatefulWidget {
  final void Function(String, String, List<PhysicalActivity> physicalActivityList) onChanged;
  final int indexExercise;
  final void Function() onValidate;

  const WorkoutRoundSetActive({
    super.key,
    required this.onChanged,
    required this.indexExercise,
    required this.onValidate,
  });

  @override
  State<WorkoutRoundSetActive> createState() => _WorkoutRoundSetActiveState();
}

class _WorkoutRoundSetActiveState extends State<WorkoutRoundSetActive> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController setCountController = TextEditingController();

  int? errorIndex;

  List<PhysicalActivity> physicalActivityList = [];

  int? validateAllPhysicalActivity(List<PhysicalActivity> list){
    for(int index = 0; index < list.length; index++){
      if(list[index].repetitionsCount.isEmpty || list[index].title.isEmpty){
        return index;
      }
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    setCountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final WorkoutCubit workoutCubit = context.read<WorkoutCubit>();
    final ExerciseRoundSet exerciseRoundSet = workoutCubit
        .currentWorkout.listExercise[widget.indexExercise] as ExerciseRoundSet;
    physicalActivityList = exerciseRoundSet.physicalActivityList;
    titleController.text = exerciseRoundSet.title;
    setCountController.text = exerciseRoundSet.setCount;
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: boxShadow,
          color: AppColors.primaryButtonColor
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const SizedBox(width: 10,),
              Expanded(
                flex: 8,
                child: ActiveWorkOutTitle(
                  titleController: titleController,
                  onChanged: (_){
                    widget.onChanged(
                        titleController.text,
                        setCountController.text,
                        physicalActivityList
                    );
                  },
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                flex: 4,
                child: ActiveCountTitle(
                  titleController: setCountController,
                  hintText: 'Кругов',
                  onChanged: (_){
                    widget.onChanged(
                        titleController.text,
                        setCountController.text,
                        physicalActivityList
                    );
                  },
                ),
              ),
              const SizedBox(width: 10,),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          physicalActivityList.isNotEmpty ? Table(
            border: TableBorder.all(
              color: AppColors.turquoise,
            ),
            columnWidths: const {
              0: IntrinsicColumnWidth(flex: 6),
              1: IntrinsicColumnWidth(flex: 2),
              2: IntrinsicColumnWidth(flex: 1),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: List.generate(physicalActivityList.length, (index) {
              return TableRow(
                  children: [
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: TextFormField(
                          initialValue: physicalActivityList[index].title.isNotEmpty
                              ? physicalActivityList[index].title
                              : null,
                          maxLength: 15,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я]')),
                          ],
                          onChanged: (String value){
                            physicalActivityList[index].title = value;
                          },
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: 'Название',
                            hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: index == errorIndex ? AppColors.red : AppColors.grey
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            focusedBorder: InputBorder.none,
                            constraints: const BoxConstraints(maxHeight: 50),
                            border: InputBorder.none,
                          ),
                        )
                    ),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: TextFormField(
                          initialValue: physicalActivityList[index].repetitionsCount.isNotEmpty
                              ? physicalActivityList[index].repetitionsCount
                              : null,
                          maxLength: 5,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          onChanged: (String value){
                            physicalActivityList[index].repetitionsCount = value;
                          },
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(hoverColor: Colors.orange,
                            counterText: '',
                            hintText: 'кол-во',
                            hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: index == errorIndex ? AppColors.red : AppColors.grey
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            focusedBorder: InputBorder.none,
                            constraints: const BoxConstraints(maxHeight: 50),
                            border: InputBorder.none,
                          ),
                        )
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: (){
                            physicalActivityList.removeAt(index);
                            context.read<WorkoutCubit>().setCurrentRoundSet(
                              physicalActivityList,
                              titleController.text,
                              setCountController.text,
                            );
                          },
                          child: SvgPicture.asset(
                            'images/delete.svg',
                            height: 25,
                            colorFilter: const ColorFilter.mode(AppColors.red, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    )
                  ]
              );
            }),
          ) : const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              widget.onValidate.call();

              /// Если поля не заполнены не продолжаем
              if(titleController.text.isEmpty || setCountController.text.isEmpty) return;

              /// Если ещё нет ни одного упражениния, то добавляем пустое упражнение без валидации
              if(physicalActivityList.isEmpty){
                widget.onChanged(
                    titleController.text,
                    setCountController.text,
                    physicalActivityList
                );
                physicalActivityList.add(PhysicalActivity(title: '', repetitionsCount: ''));
                context.read<WorkoutCubit>().setCurrentRoundSet(
                  physicalActivityList,
                  titleController.text,
                  setCountController.text,
                );
                return;
              }

              /// Получаем индекс упражения не прошедшего валидацию
              errorIndex = validateAllPhysicalActivity(physicalActivityList);

              /// Если не нашли упражнение с ошибкой, то сохраняем изменения в БД и создаём пустое упражнение
              if(errorIndex == null) {
                widget.onChanged(
                    titleController.text,
                    setCountController.text,
                    physicalActivityList
                );
                physicalActivityList.add(PhysicalActivity(title: '', repetitionsCount: ''));
                context.read<WorkoutCubit>().setCurrentRoundSet(
                    physicalActivityList,
                    titleController.text,
                    setCountController.text,
                );
              }
              setState(() {});
            },
            child: SvgPicture.asset(
              'images/plus.svg',
              height: 36,
              colorFilter: const ColorFilter.mode(
                  AppColors.grey,
                  BlendMode.srcIn
              ),
            ),
          ),
        ],
      ),
    );
  }
}

