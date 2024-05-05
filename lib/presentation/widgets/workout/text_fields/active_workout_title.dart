import 'package:app1/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ActiveWorkOutTitle extends StatefulWidget {
  final TextEditingController? titleController;
  final void Function(String)? onChanged;

  const ActiveWorkOutTitle({
    super.key,
    this.titleController,
    this.onChanged
  });

  @override
  State<ActiveWorkOutTitle> createState() => _ActiveWorkOutTitleState();
}

class _ActiveWorkOutTitleState extends State<ActiveWorkOutTitle> {

  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.titleController,
      textAlign: TextAlign.center,
      maxLength: 20,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'[a-zA-Zа-яА-Я0-9.-]'))
      ],
      onChanged: (value){
        _fieldValidator(value);
        if(widget.onChanged != null){
          widget.onChanged!(value);
        }
      },
      decoration: InputDecoration(
          counterText: '',
          error: hasError ? const SizedBox() : null,
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.dark
            ),
          ),
          hintText: 'Название',
          hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.hintTextColor
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.red
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.dark
            ),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.red
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 50),
          constraints: const BoxConstraints.tightFor(height: 40)
      ),
    );
  }

  void _fieldValidator(String value){
    setState(() {
      if(value.isEmpty){
        hasError = true;
      } else {
        hasError = false;
      }
    });
  }
}
