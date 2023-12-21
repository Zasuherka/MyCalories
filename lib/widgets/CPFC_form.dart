import 'package:app1/bloc/userInfo/user_info_bloc.dart';
import 'package:app1/validation/cpfc_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';

class CPFCForm extends StatefulWidget {
  final bool isActive;
  const CPFCForm({
    super.key,
    required this.isActive
  });

  @override
  State<CPFCForm> createState() => _CPFCFormState();
}

class _CPFCFormState extends State<CPFCForm> with CPFCValidator {

  bool _isShow = false;
  String response = '';
  Color? _responseColor;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  int _protein = 0;
  int _fats = 0;
  int _calories = 0;
  int _carbohydrates = 0;

  final Color _defaultColor = AppColors.dark;
  final Color _activeColor = AppColors.green;
  final Color _errorColor = AppColors.red;

  late Color _caloriesTextFieldColor;
  late Color _proteinTextFieldColor;
  late Color _fatsTextFieldColor;
  late Color _carbohydratesTextFieldColor;

  BoxDecoration _getContainerDecoration(Color color) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
            color: color,
            width: 1.5
        )
    );
  }

  void assignDefaultColor() {
    _caloriesTextFieldColor = _defaultColor;
    _proteinTextFieldColor = _defaultColor;
    _fatsTextFieldColor = _defaultColor;
    _carbohydratesTextFieldColor = _defaultColor;
  }

  @override
  void initState() {
    super.initState();
    assignDefaultColor();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        assignDefaultColor();
      },
      child: Form(
        key: _key,
        child: Center(
          child: AnimatedContainer(
            onEnd: (){
              setState(() {
                _isShow = !_isShow;
              });
            },
            duration: animationDurationMedium,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(screenHeight/100),
            height: widget.isActive ? screenHeight/3 : 0,
            width: widget.isActive ? screenWidth/1.1 : 0,
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: AppColors.black.withOpacity(0.2),
                    offset: const Offset(10,10),
                    blurRadius: 15,
                    spreadRadius: 5
                ),
              ],
              borderRadius: BorderRadius.circular(25),
            ),
            child: _isShow && widget.isActive ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Container(
                      height: screenHeight * 0.083,
                      width: screenWidth * 0.37,
                      alignment: Alignment.centerLeft,
                      decoration: _getContainerDecoration(_caloriesTextFieldColor),
                      child: Padding(
                        padding: EdgeInsets.only(top: screenHeight/45),
                        child:
                        TextFormField(
                          validator: (value){
                            if (value == null || !cpfcValidator(value)){
                              _caloriesTextFieldColor = _errorColor;
                            }
                            else{
                              _caloriesTextFieldColor = _defaultColor;
                            }
                            setState(() {

                            });
                            return null;
                          },
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLength: 5,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.bottom,
                          onChanged: (String value){
                            _calories = int.tryParse(value) ?? 0;
                          },
                          onTap: (){
                            setState(() {
                              assignDefaultColor();
                              _caloriesTextFieldColor = _activeColor;
                            });
                          },
                          decoration: InputDecoration(
                            counterText: '',
                            constraints: BoxConstraints.tightFor(width: screenWidth * 0.4, height: screenHeight * 0.075),
                            contentPadding: EdgeInsets.only(bottom: screenHeight/40, left: screenWidth/20),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            labelText: 'Калории',
                            labelStyle: Theme.of(context).textTheme.titleMedium,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(flex: 2),
                    Container(
                      height: screenHeight * 0.083,
                      width: screenWidth * 0.37,
                      alignment: Alignment.centerLeft,
                      decoration: _getContainerDecoration(_proteinTextFieldColor),
                      child: Padding(
                        padding: EdgeInsets.only(top: screenHeight/45),
                        child:
                        TextFormField(
                          validator: (value){
                            if (value == null || !cpfcValidator(value)){
                              _proteinTextFieldColor = _errorColor;
                            }
                            else{
                              _proteinTextFieldColor = _defaultColor;
                            }
                            setState(() {

                            });
                            return null;
                          },
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLength: 4,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.bottom,
                          onChanged: (String value){
                            _protein = int.tryParse(value) ?? 0;
                          },
                          onTap: (){
                            setState(() {
                              assignDefaultColor();
                              _proteinTextFieldColor = _activeColor;
                            });
                          },
                          decoration: InputDecoration(
                            counterText: '',
                            constraints: BoxConstraints.tightFor(width: screenWidth * 0.4, height: screenHeight * 0.075),
                            contentPadding: EdgeInsets.only(bottom: screenHeight/40, left: screenWidth/20),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            labelText: 'Белки',
                            labelStyle: Theme.of(context).textTheme.titleMedium,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Container(
                      height: screenHeight * 0.083,
                      width: screenWidth * 0.37,
                      alignment: Alignment.centerLeft,
                      decoration: _getContainerDecoration(_fatsTextFieldColor),
                      child: Padding(
                        padding: EdgeInsets.only(top: screenHeight/45),
                        child:
                        TextFormField(
                          validator: (value){
                            if (value == null || !cpfcValidator(value)){
                              _fatsTextFieldColor = _errorColor;
                            }
                            else{
                              _fatsTextFieldColor = _defaultColor;
                            }
                            setState(() {

                            });
                            return null;
                          },
                          onTap: (){
                            setState(() {
                              assignDefaultColor();
                              _fatsTextFieldColor = _activeColor;
                            });
                          },
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLength: 4,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.bottom,
                          onChanged: (String value){
                            _fats = int.tryParse(value) ?? 0;
                          },
                          decoration: InputDecoration(
                            counterText: '',
                            constraints: BoxConstraints.tightFor(width: screenWidth * 0.4, height: screenHeight * 0.075),
                            contentPadding: EdgeInsets.only(bottom: screenHeight/40, left: screenWidth/20),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            labelText: 'Жиры',
                            labelStyle: Theme.of(context).textTheme.titleMedium,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(flex: 2),
                    Container(
                      height: screenHeight * 0.083,
                      width: screenWidth * 0.37,
                      alignment: Alignment.centerLeft,
                      decoration: _getContainerDecoration(_carbohydratesTextFieldColor),
                      child: Padding(
                        padding: EdgeInsets.only(top: screenHeight/45),
                        child:
                        TextFormField(
                          validator: (value){
                            if (value == null || !cpfcValidator(value)){
                              _carbohydratesTextFieldColor = _errorColor;
                            }
                            else{
                              _carbohydratesTextFieldColor = _defaultColor;
                            }
                            setState(() {

                            });
                            return null;
                          },
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLength: 4,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.bottom,
                          onChanged: (String value){
                            _carbohydrates = int.tryParse(value) ?? 0;
                          },
                          onTap: (){
                            setState(() {
                              assignDefaultColor();
                              _carbohydratesTextFieldColor = _activeColor;
                            });
                          },
                          decoration: InputDecoration(
                            counterText: '',
                            constraints: BoxConstraints.tightFor(width: screenWidth * 0.4, height: screenHeight * 0.075),
                            contentPadding: EdgeInsets.only(bottom: screenHeight/40, left: screenWidth/20),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            labelText: 'Углеводы',
                            labelStyle: Theme.of(context).textTheme.titleMedium,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const Spacer(),
                BlocBuilder<UserInfoBloc, UserInfoState>(
                    builder: (context,state){
                      if(state is UserInfoErrorState){
                        response = state.error;
                        _responseColor = _errorColor;
                      }
                      if(state is UserInfoSuccessfulState){
                        response = 'Изменения успешно сохранены';
                        _responseColor = _activeColor;
                      }
                      return Text(response,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: _responseColor
                          ));
                    }
                ),
                const Spacer(),
                GestureDetector(
                  onTap: (){
                    FocusScope.of(context).unfocus();
                    assignDefaultColor();
                    if(_key.currentState != null && _key.currentState!.validate()){
                      BlocProvider.of<UserInfoBloc>(context).add(UserEditingInfoEvent(
                          carbohydratesGoal: _carbohydrates,
                          caloriesGoal: _calories,
                          fatsGoal: _fats,
                          proteinGoal: _protein
                      ));
                      return;
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: screenWidth/1.4,
                    height: screenHeight/23,
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: AppColors.black.withOpacity(0.2),
                            offset: const Offset(10,10),
                            blurRadius: 15
                        ),
                      ],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text('Сохранить',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.white
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ) : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
