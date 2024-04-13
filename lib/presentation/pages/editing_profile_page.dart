import 'package:app1/internal/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:app1/domain/enums/sex.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/validation/profile.dart';
import 'package:app1/presentation/widgets/custom_drop_down_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

@RoutePage()
class EditingProfilePage extends StatefulWidget {
  const EditingProfilePage({super.key});

  @override
  State<EditingProfilePage> createState() => _EditingProfilePageState();
}

class _EditingProfilePageState extends State<EditingProfilePage> with ProfileValidationMixin {

  Color defaultColor = AppColors.dark;
  Color activeColor = AppColors.turquoise ;
  Color errorColor = AppColors.red;
  String name = '';
  String email = '';
  String weight = '';
  String weightGoal = '';
  String height = '';
  String birthday = '';
  String error = '';
  late Color _nameTextFieldColor;
  late Color _emailTextFieldColor;
  late Color _weightTextFieldColor;
  late Color _weightGoalTextFieldColor;
  late Color _heightTextFieldColor;
  late Color _birthdayTextFieldColor;
  late Color _sexButtonColor;
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerWeight = TextEditingController();
  final TextEditingController _controllerWeightGoal = TextEditingController();
  final TextEditingController _controllerBirthday = TextEditingController();
  final TextEditingController _controllerHeight = TextEditingController();
  final List<String> sexList = ['Не выбран',Sex.male.sex,Sex.female.sex];
  String sexValue = 'Не выбран';

  DateTime? selectedDate;

  final  _formKey = GlobalKey<FormState>();
  bool validate = true;
  void _assignDefaultColor() {
    _sexButtonColor = defaultColor;
    _nameTextFieldColor = defaultColor;
    _emailTextFieldColor = defaultColor;
    _weightTextFieldColor = defaultColor;
    _weightGoalTextFieldColor = defaultColor;
    _heightTextFieldColor = defaultColor;
    _birthdayTextFieldColor = defaultColor;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        helpText: 'Выберите дату рождения',
        cancelText: 'Отмена',
        confirmText: 'Ок',
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950, 1),
        lastDate: DateTime(2101));
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        birthday = DateFormat('dd.MM.yyyy').format(pickedDate);
      });
    }
  }

  BoxDecoration _getContainerDecoration(Color color) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: color,
            width: 1
        )
    );
  }
  
  Widget verticalOffset = const SizedBox(
      height: 10
  );
  Widget horizontalOffset = const SizedBox(
      width: 10
  );

  @override
  void initState() {
    super.initState();
    _assignDefaultColor();
    final localUser = context.read<UserInfoBloc>().localUser;
    if(localUser != null){
      name = localUser.name;
      email = localUser.email;
      weight = localUser.weightNow?.toString() ?? '';
      weightGoal = localUser.weightGoal?.toString() ?? '';
      height = localUser.height?.toString() ?? '';
      birthday = localUser.birthday != null ? DateFormat('dd.MM.yyyy').format(localUser.birthday!) : '';
      selectedDate = localUser.birthday;
      sexValue = localUser.sex?.sex ?? sexValue;
      _controllerName.text = name;
      _controllerEmail.text = email;
      _controllerWeight.text = weight;
      _controllerWeightGoal.text = weightGoal;
      _controllerHeight.text = height;
      _controllerBirthday.text = birthday;
      if(sexValue != 'Не выбран'){
        sexList.remove('Не выбран');
      }
    }
  }

  ///Очищаем память
  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerName.dispose();
    _controllerWeight.dispose();
    _controllerWeightGoal.dispose();
    _controllerHeight.dispose();
    _controllerBirthday.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
          _assignDefaultColor();
        },
        child: Stack(
          children: [
            ///Для тёмной темы, если будет
            Image.asset('images/background_image.png',
              height: screenHeight,
              width: screenWidth,
              fit: BoxFit.cover,
            ),
            Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  toolbarHeight: MediaQuery.of(context).padding.top + 20,
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      gradient: AppColors.greenGradient
                    ),
                  ),
                  leading: Container(
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        //BlocProvider.of<UserInfoBloc>(context).add(LocalUserInfoEvent());
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        'images/arrow.svg',
                        width: 33,
                        height: 33,
                        colorFilter:
                        const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  actions: [
                    Padding(padding: const EdgeInsets.only(right: 20),
                      child: GestureDetector(
                        onTap: () {
                          validate = true;
                          if (selectedDate == null){
                            _birthdayTextFieldColor = errorColor;
                            validate = false;
                          }
                          if (sexValue == 'Не выбран'){
                            _sexButtonColor = errorColor;
                            validate = false;
                          }
                          setState(() {});
                          if(_formKey.currentState != null){
                            if(_formKey.currentState!.validate() && validate){
                              _assignDefaultColor();
                              ///TODO Убрал почту
                              BlocProvider.of<UserInfoBloc>(context).add(
                                  UserInfoEvent.update(
                                      name: name,
                                      //email: email,
                                      weightNow: double.parse(weight),
                                      weightGoal: double.parse(weightGoal),
                                      birthday: DateTime(selectedDate!.year, selectedDate!.month, selectedDate!.day),
                                      height: int.parse(height),
                                      sexValue: sexValue
                                  )
                              );
                            }
                          }
                        },
                        child: SvgPicture.asset(
                          'images/mark.svg',
                          width: 33,
                          height: 33,
                          colorFilter:
                          const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                        ),
                      ),
                    )
                  ],
                  title: const Text(
                    'Личные данные',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                body: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:
                          [
                            verticalOffset,
                            Container(
                                height: 74,
                                padding: const EdgeInsets.only(top: 16),
                                alignment: Alignment.centerLeft,
                                decoration: _getContainerDecoration(_nameTextFieldColor),
                                ///TODO переделать изменение цевта границ(border) с помощью двух параметров OutlineInputBorder и OutlineInputBorder
                                child: TextFormField(
                                  validator: (value) {
                                    if(isNameValid(value)){
                                      setState(() {
                                        _nameTextFieldColor = defaultColor;
                                      });
                                      return null;
                                    }
                                    setState(() {
                                      _nameTextFieldColor = errorColor;
                                    });
                                    if(validate){
                                      validate = false;
                                    }
                                    return 'Имя должно содержать от 6 до 20 символов';
                                  },
                                  controller: _controllerName,
                                  style:Theme.of(context).textTheme.titleMedium,
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я0-9. ]'))],
                                  maxLength: 20,
                                  textAlign: TextAlign.start,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  onChanged: (String value){
                                    name = value;
                                  },
                                  onTap: (){
                                    setState(() {
                                      _assignDefaultColor();
                                      _nameTextFieldColor = activeColor;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    counterText: '',
                                    constraints: const BoxConstraints(maxWidth: 355, maxHeight: 70),
                                    contentPadding: const EdgeInsets.only(bottom: 20, left: 20),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    labelText: 'Имя',
                                    labelStyle: Theme.of(context).textTheme.titleMedium,
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                  ),
                                )
                            ),
                            verticalOffset,
                            // Container(
                            //     height: 74,
                            //     padding: const EdgeInsets.only(top: 20),
                            //     alignment: Alignment.centerLeft,
                            //     decoration: _getContainerDecoration(_emailTextFieldColor),
                            //     child: TextFormField(
                            //       validator: (value){
                            //         if(isEmailValid(value) != null)
                            //         {
                            //           setState(() {
                            //             _emailTextFieldColor = errorColor;
                            //           });
                            //           return isEmailValid(value);
                            //         }
                            //         else{
                            //           _emailTextFieldColor = defaultColor;
                            //           return null;
                            //         }
                            //       },
                            //       controller: _controllerEmail,
                            //       style: Theme.of(context).textTheme.titleMedium,
                            //       inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я0-9.@]'))],
                            //       textAlign: TextAlign.start,
                            //       textAlignVertical: TextAlignVertical.bottom,
                            //       onChanged: (String value){
                            //         email = value;
                            //       },
                            //       onTap: (){
                            //         setState(() {
                            //           _assignDefaultColor();
                            //           _emailTextFieldColor = activeColor;
                            //         });
                            //       },
                            //       decoration: InputDecoration(
                            //         counterText: '',
                            //         constraints: const BoxConstraints(maxWidth: 355, maxHeight: 70),
                            //         contentPadding: const EdgeInsets.only(bottom: 20, left: 20),
                            //         border: const OutlineInputBorder(
                            //           borderSide: BorderSide.none,
                            //         ),
                            //         labelText: 'Почта',
                            //         labelStyle: Theme.of(context).textTheme.titleMedium,
                            //         floatingLabelBehavior: FloatingLabelBehavior.always,
                            //       ),
                            //     )
                            // ),
                            // verticalOffset,
                            GestureDetector(
                              onTap: () async {
                                _selectDate(context);
                              },
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(top: 4.5, left: 20),
                                  height: 74,
                                  decoration: _getContainerDecoration(_birthdayTextFieldColor),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Spacer(),
                                      Text('Дата рождения',
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      ),
                                      const Spacer(),
                                      Text(
                                        birthday,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                      const Spacer(),
                                    ],
                                  )
                              ),
                            ),
                            verticalOffset,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 74,
                                    padding: const EdgeInsets.only(top: 20),
                                    decoration: _getContainerDecoration(_weightTextFieldColor),
                                    child: TextFormField(
                                      validator: (value){
                                        if(isWeightValid(value)){
                                          setState(() {
                                            _weightTextFieldColor = defaultColor;
                                          });
                                        }
                                        else{
                                          setState(() {
                                            _weightTextFieldColor = errorColor;
                                            validate = false;
                                          });
                                        }
                                        return null;
                                      },
                                      controller: _controllerWeight,
                                      style: Theme.of(context).textTheme.titleMedium,
                                      maxLength: 5,
                                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                      textAlign: TextAlign.start,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      onChanged: (String value){
                                        weight = value;
                                      },
                                      onTap: (){
                                        setState(() {
                                          _assignDefaultColor();
                                          _weightTextFieldColor = activeColor;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        counterText: '',
                                        constraints: const BoxConstraints.tightFor(height: 70),
                                        contentPadding: const EdgeInsets.only(bottom: 20, left: 20),
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        labelText: 'Вес',
                                        labelStyle: Theme.of(context).textTheme.titleMedium,
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                      ),
                                    ),

                                  ),
                                ),
                                horizontalOffset,
                                Expanded(
                                  child: Container(
                                    height: 74,
                                    padding: const EdgeInsets.only(top: 20),
                                    decoration: _getContainerDecoration(_weightGoalTextFieldColor),
                                    child: TextFormField(
                                      validator: (value){
                                        if(isWeightValid(value)){
                                          setState(() {
                                            _weightGoalTextFieldColor = defaultColor;
                                          });
                                        }
                                        else{
                                          setState(() {
                                            _weightGoalTextFieldColor = errorColor;
                                          });
                                          if(validate){
                                            validate = false;
                                          }
                                        }
                                        return null;
                                      },
                                      controller: _controllerWeightGoal,
                                      style: Theme.of(context).textTheme.titleMedium,
                                      maxLength: 5,
                                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                      textAlign: TextAlign.start,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      onChanged: (String value){
                                        weightGoal = value;
                                      },
                                      onTap: (){
                                        setState(() {
                                          _assignDefaultColor();
                                          _weightGoalTextFieldColor = activeColor;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        counterText: '',
                                        constraints: const BoxConstraints.tightFor(height: 70),
                                        contentPadding: const EdgeInsets.only(bottom: 20, left: 20),
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        labelText: 'Желаемый вес',
                                        labelStyle: Theme.of(context).textTheme.titleMedium,
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            verticalOffset,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 74,
                                    padding: const EdgeInsets.only(top: 20),
                                    alignment: Alignment.centerLeft,
                                    decoration: _getContainerDecoration(_heightTextFieldColor),
                                    child: TextFormField(
                                      validator: (value){
                                        if(isHeightValid(value)){
                                          setState(() {
                                            _heightTextFieldColor = defaultColor;
                                          });
                                        }
                                        else{
                                          setState(() {
                                            _heightTextFieldColor = errorColor;
                                          });
                                          if(validate){
                                            validate = false;
                                          }
                                        }
                                        return null;
                                      },
                                      controller: _controllerHeight,
                                      style: Theme.of(context).textTheme.titleMedium,
                                      maxLength: 5,
                                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                      textAlign: TextAlign.start,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      onChanged: (String value){
                                        height = value;
                                      },
                                      onTap: (){
                                        setState(() {
                                          _assignDefaultColor();
                                          _heightTextFieldColor = activeColor;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        counterText: '',
                                        constraints: const BoxConstraints.tightFor(height: 70),
                                        contentPadding: const EdgeInsets.only(bottom: 20, left: 20),
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        labelText: 'Рост',
                                        labelStyle: Theme.of(context).textTheme.titleMedium,
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                      ),
                                    ),
                                  ),
                                ),
                                horizontalOffset,
                                Expanded(
                                  child: CustomDropDownButton(
                                    value: sexValue,
                                    itemHeight: 74,
                                    borderColor: _sexButtonColor,
                                    labelText: 'Пол',
                                    listValues: sexList,
                                    onTap: () {
                                      setState(() {
                                        _assignDefaultColor();
                                        _sexButtonColor = activeColor;
                                      });
                                    },
                                    onChanged: (value) => setState(() {
                                      _assignDefaultColor();
                                      sexValue = value;
                                      if(value != 'Не выбран'){
                                        sexList.remove('Не выбран');
                                      }
                                    }),
                                  ),
                                ),
                                // Container(
                                //   height: 74,
                                //   width: 180,
                                //   //padding: const EdgeInsets.only(top: 20),
                                //   alignment: Alignment.centerLeft,
                                //   decoration: _getContainerDecoration(_sexTextFieldColor),
                                //   child: DropdownButtonFormField<String>(
                                //     iconSize: 0,
                                //     value: sexValue,
                                //     items: List.generate(
                                //         sexList.length, (index) => DropdownMenuItem<String>(
                                //         value: sexList[index],
                                //         child: Text(sexList[index]))),
                                //     onChanged: (value) => setState(() {
                                //       sexValue = value ?? 'Не выбран';
                                //       if(value != 'Не выбран'){
                                //         sexList.remove('Не выбран');
                                //       }
                                //     }),
                                //     style: Theme.of(context).textTheme.titleMedium,
                                //     decoration: InputDecoration(
                                //       // border: const OutlineInputBorder(
                                //       //   borderSide: BorderSide.none,
                                //       // ),
                                //       counterText: '',
                                //       filled: true,
                                //       fillColor: AppColors.colorForCarbohydrates,
                                //       //constraints: const BoxConstraints(minWidth: 160, minHeight: 70),
                                //       //contentPadding: const EdgeInsets.only(bottom: 20, left: 20),
                                //       labelText: 'Пол',
                                //       labelStyle: Theme.of(context).textTheme.titleMedium,
                                //       //floatingLabelBehavior: FloatingLabelBehavior.always,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            verticalOffset,
                            SizedBox(
                                width: 375,
                                height: 45,
                                child: BlocBuilder<UserInfoBloc, UserInfoState>(
                                  builder: (context, state) {
                                    error = '';
                                    Color textColor = AppColors.turquoise;
                                    state.whenOrNull(
                                        error: (errorState) {
                                          error = errorState;
                                          textColor = AppColors.red;
                                        },
                                        successful: () => error = 'Успешно сохранено'
                                    );
                                    return Text(
                                      error,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.clip,
                                      style: Theme.of(context).textTheme.titleMedium
                                          ?.copyWith(color: textColor),
                                    );
                                  },
                                )
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                context.router.pop();
                                BlocProvider.of<UserInfoBloc>(context).add(const UserInfoEvent.singOut());
                              },
                              child: Container(
                                  width: 375,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    //color: AppColors.elementColor,
                                    gradient: AppColors.greenGradient,
                                    borderRadius: BorderRadius.circular(90),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 0,
                                        blurRadius: 0,
                                        offset: const Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                        'Выйти из аккаунта',
                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                            color: AppColors.white
                                        )
                                    ),
                                  )
                              ),
                            ),
                            const SizedBox(
                              height: 30
                            )
                          ]
                      ),
                    )
                )
            )
          ],
        )
    );
  }
}