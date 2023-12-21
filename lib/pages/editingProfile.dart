import 'package:app1/bloc/userInfo/user_info_bloc.dart';
import 'package:app1/enums/sex.dart';
import 'package:app1/pages/authPage.dart';
import 'package:app1/pages/authorizationPage.dart';
import 'package:app1/constants.dart';
import 'package:app1/validation/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class EditingProfile extends StatefulWidget {
  const EditingProfile({super.key});

  @override
  State<EditingProfile> createState() => _EditingProfileState();
}

class _EditingProfileState extends State<EditingProfile> with ProfileValidationMixin {

  Color defaultColor = AppColors.dark;
  Color activeColor = AppColors.green;
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
  late Color _sexTextFieldColor;
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
  void assignDefaultColor() {
    _sexTextFieldColor = defaultColor;
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

  @override
  void initState() {
    super.initState();
    assignDefaultColor();
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

  // ///Перед тем, как закрыть, нам нужно вновь отстроить [Profile]
  // ///Но Profile для постройки ждёт состояния [LocalUserInfoState], но
  // ///при включенном [EditingProfile], активно состояние [StopBuildUserInfoState],
  // ///поэтому у bloc нужно запросить состояние [LocalUserInfo]. Поэтому переопределяем
  // ///метод [didUpdateWidget] чтобы перед закрытием запросить состояние
  // @override
  // void didUpdateWidget(covariant EditingProfile oldWidget) {
  //   BlocProvider.of<UserInfoBloc>(context).add(LocalUserInfoEvent());
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
     
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
        assignDefaultColor();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: Padding(
              padding: EdgeInsets.only(left: screenWidth/40),
              child: Container(
                alignment: Alignment.center,
                constraints: BoxConstraints(
                  maxWidth: screenHeight/27,
                  maxHeight: screenHeight/27,
                ),
                child: GestureDetector(
                  onTap: () {
                    //BlocProvider.of<UserInfoBloc>(context).add(LocalUserInfoEvent());
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    'images/arrow.svg',
                    width: screenHeight / 27,
                    height: screenHeight / 27,
                    colorFilter:
                    const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            actions: [
              Padding(padding: EdgeInsets.only(right: screenWidth/20),
                child: GestureDetector(
                onTap: () {
                  validate = true;
                  if (selectedDate == null){
                    _birthdayTextFieldColor = errorColor;
                    validate = false;
                  }
                  if (sexValue == 'Не выбран'){
                    _sexTextFieldColor = errorColor;
                    validate = false;
                  }
                  setState(() {});
                  if(_formKey.currentState != null){
                    if(_formKey.currentState!.validate() && validate){
                      assignDefaultColor();
                      BlocProvider.of<UserInfoBloc>(context).add(
                          UserEditingInfoEvent(
                              name: name,
                              email: email,
                              weightNow: double.parse(weight),
                              weightGoal: double.parse(weightGoal),
                              birthday: DateTime(selectedDate!.year, selectedDate!.month, selectedDate!.day),
                              height: int.parse(height),
                              sexValue: sexValue
                          ));
                    }
                  }
                },
                child: SvgPicture.asset(
                  'images/mark.svg',
                  width: screenHeight / 27,
                  height: screenHeight / 27,
                  colorFilter:
                  const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                ),
              ),)
            ],
            title: const Text(
              'Личные данные',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          body: Form(
            key: _formKey,
            child:
            BlocBuilder<UserInfoBloc,UserInfoState>(builder: (context, state){
              if(state is LocalUserInfoState) {
                name = state.appUser.name;
                email = state.appUser.email;
                weight = state.appUser.weightNow?.toString() ?? '';
                weightGoal = state.appUser.weightGoal?.toString() ?? '';
                height = state.appUser.height?.toString() ?? '';
                birthday = state.appUser.birthday != null ? DateFormat('dd.MM.yyyy').format(state.appUser.birthday!) : '';
                selectedDate = state.appUser.birthday;
                sexValue = state.appUser.sex?.sex ?? sexValue;
                _controllerName.text = name;
                _controllerEmail.text = email;
                _controllerWeight.text = weight;
                _controllerWeightGoal.text = weightGoal;
                _controllerHeight.text = height;
                _controllerBirthday.text = birthday;
                if(sexValue != 'Не выбран'){
                  sexList.remove('Не выбран');
                }
                BlocProvider.of<UserInfoBloc>(context).add(StopBuildUserInfoEvent());
              }
              if(state is UserInfoErrorState){
                error = state.error;
              }
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:
                    [
                      SizedBox(height: screenHeight/50),
                      Container(
                        height: screenHeight * 0.082,
                        width: screenWidth/1.1,
                        alignment: Alignment.centerLeft,
                        decoration: _getContainerDecoration(_nameTextFieldColor),
                        child: Padding(
                          padding: EdgeInsets.only(top: screenHeight/50),
                          child:
                          TextFormField(
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
                                assignDefaultColor();
                                _nameTextFieldColor = activeColor;
                              });
                            },
                            decoration: InputDecoration(
                              counterText: '',
                              constraints: BoxConstraints.tightFor(width: screenWidth/1.2, height: screenHeight * 0.075),
                              contentPadding: EdgeInsets.only(bottom: screenHeight/40, left: screenWidth/20),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              labelText: 'Имя',
                              labelStyle: Theme.of(context).textTheme.titleMedium,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight/50),
                      Container(
                        height: screenHeight * 0.082,
                        width: screenWidth/1.1,
                        alignment: Alignment.centerLeft,
                        decoration: _getContainerDecoration(_emailTextFieldColor),
                        child: Padding(
                          padding: EdgeInsets.only(top: screenHeight/45),
                          child:
                          TextFormField(
                            validator: (value){
                              if(isEmailValid(value) != null)
                              {
                                setState(() {
                                  _emailTextFieldColor = errorColor;
                                });
                                return isEmailValid(value);
                              }
                              else{
                                _emailTextFieldColor = defaultColor;
                                return null;
                              }
                            },
                            controller: _controllerEmail,
                            style: Theme.of(context).textTheme.titleMedium,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я0-9.@]'))],
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.bottom,
                            onChanged: (String value){
                              email = value;
                            },
                            onTap: (){
                              setState(() {
                                assignDefaultColor();
                                _emailTextFieldColor = activeColor;
                              });
                            },
                            decoration: InputDecoration(

                              counterText: '',
                              constraints: BoxConstraints.tightFor(width: screenWidth/1.2, height: screenHeight * 0.075),
                              contentPadding: EdgeInsets.only(bottom: screenHeight/40, left: screenWidth/20),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              labelText: 'Почта',
                              labelStyle: Theme.of(context).textTheme.titleMedium,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight/50),
                      GestureDetector(
                        onTap: () async {
                          _selectDate(context);
                        },
                        child: Container(
                          width: screenWidth/1.1,
                          height: screenHeight * 0.082,
                          decoration: _getContainerDecoration(_birthdayTextFieldColor),
                          child: Padding(
                              padding: EdgeInsets.only(top: screenHeight/85, left: screenWidth/20),
                              child:
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Дата рождения',
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Padding(padding: EdgeInsets.only(top: screenHeight/150)),
                                  Text(
                                    birthday,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  )
                                ],
                              )
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: screenHeight/50),
                          child: SizedBox(
                            width: screenWidth/1.1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: screenHeight * 0.082,
                                  width: screenWidth * 0.43,
                                  decoration: _getContainerDecoration(_weightTextFieldColor),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: screenHeight/45),
                                    child:
                                    TextFormField(
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
                                          assignDefaultColor();
                                          _weightTextFieldColor = activeColor;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        counterText: '',
                                        constraints: BoxConstraints.tightFor(width: screenWidth * 0.4, height: screenHeight * 0.075),
                                        contentPadding: EdgeInsets.only(bottom: screenHeight/40, left: screenWidth/20),
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
                                Container(
                                  height: screenHeight * 0.082,
                                  width: screenWidth * 0.43,
                                  decoration: _getContainerDecoration(_weightGoalTextFieldColor),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: screenHeight/45),
                                    child:
                                    TextFormField(
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
                                          assignDefaultColor();
                                          _weightGoalTextFieldColor = activeColor;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        counterText: '',
                                        constraints: BoxConstraints.tightFor(width: screenWidth * 0.4, height: screenHeight * 0.075),
                                        contentPadding: EdgeInsets.only(bottom: screenHeight/40, left: screenWidth/20),
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
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight/50),
                        child: SizedBox(
                          width: screenWidth/1.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: screenHeight * 0.082,
                                width: screenWidth * 0.43,
                                alignment: Alignment.centerLeft,
                                decoration: _getContainerDecoration(_heightTextFieldColor),
                                child: Padding(
                                  padding: EdgeInsets.only(top: screenHeight/45),
                                  child:
                                  TextFormField(
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
                                        assignDefaultColor();
                                        _heightTextFieldColor = activeColor;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      counterText: '',
                                      constraints: BoxConstraints.tightFor(width: screenWidth * 0.4, height: screenHeight * 0.075),
                                      contentPadding: EdgeInsets.only(bottom: screenHeight/40, left: screenWidth/20),
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
                              Container(
                                height: screenHeight * 0.082,
                                width: screenWidth * 0.43,
                                alignment: Alignment.centerLeft,
                                decoration: _getContainerDecoration(_sexTextFieldColor),
                                child: Padding(
                                  padding: EdgeInsets.only(top: screenHeight/45),
                                  child: DropdownButtonFormField<String>(
                                    value: sexValue,
                                    items: List.generate(
                                        sexList.length, (index) => DropdownMenuItem<String>(
                                        value: sexList[index],
                                        child: Text(sexList[index]))),
                                    onChanged: (value) => setState(() {
                                      sexValue = value ?? 'Не выбран';
                                      if(value != 'Не выбран'){
                                        sexList.remove('Не выбран');
                                      }
                                    }),
                                    style: Theme.of(context).textTheme.titleMedium,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      counterText: '',
                                      constraints: BoxConstraints.tightFor(width: screenWidth * 0.4, height: screenHeight * 0.075),
                                      contentPadding: EdgeInsets.only(bottom: screenHeight/40, left: screenWidth/20),
                                      labelText: 'Пол',
                                      labelStyle: Theme.of(context).textTheme.titleMedium,
                                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight/50),
                      SizedBox(
                          width: screenWidth/1.1,
                          height: screenHeight/20,
                          child: Text(
                            error,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.red
                            ),
                          )
                      ),
                      SizedBox(height: screenHeight/4.5),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<UserInfoBloc>(context).add(UserSingOutEvent());
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const AuthPage()), (Route<dynamic> route) => false);
                        },
                        child: Container(
                            width: screenWidth * 0.95,
                            height: screenHeight/20,
                            decoration: BoxDecoration(
                                color: AppColors.dark,
                                borderRadius: BorderRadius.circular(90),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 13,
                                    offset: const Offset(10, 10),
                                  ),
                                ]
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
                    ]
                ),
              );
            }
            ),
          )
      )
    );
  }
}
