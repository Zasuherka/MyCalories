import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/widgets/workout/text_fields/active_workout_title.dart';
import 'package:app1/presentation/widgets/workout/text_fields/workout_set_text_field.dart';
import 'package:flutter/material.dart';

class WorkoutSetWithActiveTitle extends StatefulWidget {
  final void Function(String, String, String) onChanged;


  const WorkoutSetWithActiveTitle({
    super.key,
    required this.onChanged
  });

  @override
  State<WorkoutSetWithActiveTitle> createState() => _WorkoutSetWithActiveTitleState();
}

class _WorkoutSetWithActiveTitleState extends State<WorkoutSetWithActiveTitle> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _setController = TextEditingController();
  final TextEditingController _repetitionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
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
            titleController: _titleController,
            onChanged: (_){
              widget.onChanged(
                _titleController.text,
                _setController.text,
                _repetitionController.text,
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
                workoutSetController: _setController,
                onChanged: (_){
                  widget.onChanged(
                    _titleController.text,
                    _setController.text,
                    _repetitionController.text,
                  );
                },
                width: 100,
                hintText: 'Подходы',
              ),
              WorkoutSetTextField(
                workoutSetController: _repetitionController,
                onChanged: (_){
                  widget.onChanged(
                    _titleController.text,
                    _setController.text,
                    _repetitionController.text,
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
