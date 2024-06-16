import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/widgets/workout/text_fields/active_workout_title.dart';
import 'package:app1/presentation/widgets/workout/text_fields/workout_set_text_field.dart';
import 'package:flutter/material.dart';

class WorkoutSetActive extends StatefulWidget {
  final void Function(String, String, String) onChanged;
  final String title;
  final String setCount;
  final String repetitionsCount;

  const WorkoutSetActive({
    super.key,
    required this.onChanged,
    required this.title,
    required this.setCount,
    required this.repetitionsCount,
  });

  @override
  State<WorkoutSetActive> createState() => _WorkoutSetActiveState();
}

class _WorkoutSetActiveState extends State<WorkoutSetActive> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController setController = TextEditingController();

  final TextEditingController repetitionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    titleController.text = widget.title;
    setController.text = widget.setCount;
    repetitionController.text = widget.repetitionsCount;
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
          ActiveWorkOutTitle(
            titleController: titleController,
            onChanged: (_){
              widget.onChanged(
                titleController.text,
                setController.text,
                repetitionController.text,
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WorkoutSetTextField(
                workoutSetController: setController,
                onChanged: (_){
                  widget.onChanged(
                    titleController.text,
                    setController.text,
                    repetitionController.text,
                  );
                },
                width: 100,
                hintText: 'Подходы',
              ),
              WorkoutSetTextField(
                workoutSetController: repetitionController,
                onChanged: (_){
                  widget.onChanged(
                    titleController.text,
                    setController.text,
                    repetitionController.text,
                  );
                },
                width: 100,
                hintText: 'Повторы',
              ),
            ],
          )
        ],
      ),
    );
  }
}
