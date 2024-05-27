import 'package:app1/domain/model/workout/exercise_set.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/widgets/workout/text_fields/active_number_circles.dart';
import 'package:app1/presentation/widgets/workout/text_fields/active_workout_title.dart';
import 'package:app1/presentation/widgets/workout/text_fields/workout_set_text_field.dart';
import 'package:flutter/material.dart';

class WorkoutCardioWithActiveTitle extends StatefulWidget {
  final void Function(String, String) onChanged;
  final String title;
  final String count;

  const WorkoutCardioWithActiveTitle({
    super.key,
    required this.onChanged,
    required this.title,
    required this.count,
  });

  @override
  State<WorkoutCardioWithActiveTitle> createState() => _WorkoutCardioWithActiveTitleState();
}

class _WorkoutCardioWithActiveTitleState extends State<WorkoutCardioWithActiveTitle> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController countController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    titleController.text = widget.title;
    countController.text = widget.count;
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: boxShadow,
          color: AppColors.primaryButtonColor
      ),
      child: Row(
        children: [
          const SizedBox(width: 10,),
          Expanded(
            flex: 8,
            child: ActiveWorkOutTitle(
              titleController: titleController,
              onChanged: (_){
                widget.onChanged(
                    titleController.text,
                    countController.text,
                );
              },
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(
            flex: 4,
            child: ActiveCountTitle(
              titleController: countController,
              onChanged: (_){
                widget.onChanged(
                  titleController.text,
                  countController.text,
                );
              },
            ),
          ),
          const SizedBox(width: 10,),
        ],
      ),
    );
  }
}
