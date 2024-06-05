import 'package:app1/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ActiveCountTitle extends StatefulWidget {
  final TextEditingController? titleController;
  final void Function(String)? onChanged;
  final String hintText;

  const ActiveCountTitle({
    super.key,
    required this.hintText,
    this.titleController,
    this.onChanged,
  });

  @override
  State<ActiveCountTitle> createState() => _ActiveCountTitleState();
}

class _ActiveCountTitleState extends State<ActiveCountTitle> {

  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value){
        _fieldValidator(value);
        return null;
      },
      controller: widget.titleController,
      textAlign: TextAlign.center,
      maxLength: 3,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'[0-9-]'))
      ],
      keyboardType: TextInputType.phone,
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
          hintText: widget.hintText,
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          constraints: const BoxConstraints.tightFor(height: 40)
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
