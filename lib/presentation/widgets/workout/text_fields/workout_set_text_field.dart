import 'package:app1/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WorkoutSetTextField extends StatefulWidget {
  final TextEditingController? workoutSetController;
  final void Function(String)? onChanged;
  final double? width;
  final String? hintText;

  const WorkoutSetTextField({
    super.key,
    this.workoutSetController,
    this.onChanged,
    this.width,
    this.hintText,
  });

  @override
  State<WorkoutSetTextField> createState() => _WorkoutSetTextFieldState();
}

class _WorkoutSetTextFieldState extends State<WorkoutSetTextField> {

  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value){
        _fieldValidator(value);
        return null;
      },
      controller: widget.workoutSetController,
      textAlign: TextAlign.center,
      maxLength: 3,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      onChanged: (value){
        _fieldValidator(value);
        if(widget.onChanged != null){
          widget.onChanged!(value);
        }
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'[0-9-]'))
      ],
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        counterText: '',
        error: hasError ? const SizedBox() : null,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColors.dark
          ),
        ),
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.hintTextColor
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColors.red
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColors.dark
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColors.red
          ),
        ),
        contentPadding: EdgeInsets.zero,
        constraints: BoxConstraints.tightFor(width: widget.width),
      ),
    );
  }

  void _fieldValidator(String? value){
    setState(() {
      if(value == null || value.isEmpty){
        hasError = true;
      } else {
        hasError = false;
      }
    });
  }
}

