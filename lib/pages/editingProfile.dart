import 'package:app1/bloc/userInfo/user_info_bloc.dart';
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


  Color defaultColor = const Color(0xFF2D2D2D).withOpacity(0.5);
  Color activeColor = const Color(0xFF10F00C).withOpacity(0.5);
  Color errorColor = const Color(0xFFFF000D).withOpacity(0.5);
  String name = '';
  String email = '';
  String weight = '';
  String weightDream = '';
  String height = '';
  String birthday = '';
  String error = '';
  late Color _nameTextFieldColor;
  late Color _emailTextFieldColor;
  late Color _weightTextFieldColor;
  late Color _weightDreamTextFieldColor;
  late Color _heightTextFieldColor;
  late Color _birthdayTextFieldColor;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerWeight = TextEditingController();
  TextEditingController _controllerWeightDream = TextEditingController();
  TextEditingController _controllerBirthday = TextEditingController();
  TextEditingController _controllerHeight = TextEditingController();

  DateTime? selectedDate;

  final _formKey = GlobalKey<FormState>();
  bool validate = true;
  void assignDefaultColor() {
    _nameTextFieldColor = defaultColor;
    _emailTextFieldColor = defaultColor;
    _weightTextFieldColor = defaultColor;
    _weightDreamTextFieldColor = defaultColor;
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



  @override
  void initState() {
    super.initState();
    assignDefaultColor();
  }

  ///Очищаем память
  @override
  void dispose() {
    _controllerName.dispose();
    _controllerEmail.dispose();
    _controllerWeight.dispose();
    _controllerWeightDream.dispose();
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        assignDefaultColor();
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(238, 238, 238, 1.0),
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(238, 238, 238, 1.0),
            shadowColor: Colors.black,
            leading: ElevatedButton(
              onPressed: () {
                BlocProvider.of<UserInfoBloc>(context).add(LocalUserInfoEvent());
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  backgroundColor: const Color.fromRGBO(238, 238, 238, 1.0),
                  foregroundColor: const Color.fromRGBO(238, 238, 238, 1.0),
                  shadowColor: Colors.transparent),
              child: SvgPicture.asset(
                'images/arrow.svg',
                width: screenHeight / 27,
                height: screenHeight / 27,
                colorFilter:
                const ColorFilter.mode(Color(0xff2D2D2D), BlendMode.srcIn),
              ),
            ),
            actions: [
              Padding(padding: EdgeInsets.only(right: screenWidth/20),
                child: GestureDetector(
                onTap: () {
                  if (selectedDate == null){
                    setState(() {
                      _birthdayTextFieldColor = errorColor;
                      if(validate){
                        validate = false;
                      }
                    });
                  }
                  else {
                    setState(() {
                      assignDefaultColor();
                    });
                  }
                  if(_formKey.currentState != null){
                    if(_formKey.currentState!.validate() && validate){
                      BlocProvider.of<UserInfoBloc>(context).add(
                          UserEditingInfoEvent(name: name, email: email, 
                              weightNow: double.parse(weight), weightDream: 
                              double.parse(weightDream), 
                              birthday: DateTime(selectedDate!.year, selectedDate!.month, selectedDate!.day), 
                              height: int.parse(height)));
                    }
                  }
                },
                child: SvgPicture.asset(
                  'images/mark.svg',
                  width: screenHeight / 27,
                  height: screenHeight / 27,
                  colorFilter:
                  const ColorFilter.mode(Color(0xff2D2D2D), BlendMode.srcIn),
                ),
              ),)
            ],
            title: Text(
              'Личные данные',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: screenHeight / 50,
                fontFamily: 'Comfortaa',
                color: const Color(0xff2D2D2D),
              ),
            ),
          ),
          body: Form(
            key: _formKey,
            child: SizedBox(
                width: screenWidth,
                child: BlocBuilder<UserInfoBloc,UserInfoState>(builder: (context, state){
                  if(state is LocalUserInfoState) {
                    name = state.appUser.name;
                    email = state.appUser.email;
                    weight = state.appUser.weightNow?.toString() ?? '';
                    weightDream = state.appUser.weightDream?.toString() ?? '';
                    height = state.appUser.height?.toString() ?? '';
                    birthday = state.appUser.birthday != null ? DateFormat('dd.MM.yyyy').format(state.appUser.birthday!) : '';
                    _controllerName = TextEditingController(text: name);
                    _controllerEmail = TextEditingController(text: email);
                    _controllerWeight = TextEditingController(text: weight);
                    _controllerWeightDream = TextEditingController(text: weightDream);
                    _controllerHeight = TextEditingController(text: height);
                    _controllerBirthday = TextEditingController(text: birthday);
                    BlocProvider.of<UserInfoBloc>(context).add(StopBuildUserInfoEvent());
                  }
                  if(state is UserInfoErrorState){
                    error = state.error;
                  }
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                      [
                        Padding(
                            padding: EdgeInsets.only(top: screenHeight/50),
                            child: Container(
                              width: screenWidth/1.1,
                              height: screenHeight/14,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: _nameTextFieldColor,
                                      width: 2
                                  )
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: screenHeight/50),
                                child:
                                TextFormField(
                                  validator: (value) {
                                    if(isNameValid(value)){
                                      setState(() {
                                        assignDefaultColor();
                                      });
                                      setState(() {
                                        _nameTextFieldColor = errorColor;
                                      });
                                      return null;
                                    }
                                    return 'Имя должно содержать от 6 до 20 символов';
                                  },
                                  controller: _controllerName,
                                  style: TextStyle(
                                    fontSize: screenHeight / 40,
                                    fontFamily: 'Comfortaa',
                                    color: const Color(0xff2D2D2D),
                                  ),
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
                                    contentPadding: EdgeInsets.only(bottom: screenHeight/70, left: screenWidth/20),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    labelText: 'Имя',
                                    labelStyle: TextStyle(
                                      fontSize: screenHeight / 45,
                                      fontFamily: 'Comfortaa',
                                      color: const Color(0xff2D2D2D),
                                    ),
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                  ),
                                ),
                              ),
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: screenHeight/50),
                            child: Container(
                              width: screenWidth/1.1,
                              height: screenHeight/14,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: _emailTextFieldColor,
                                      width: 2
                                  )
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: screenHeight/50),
                                child:
                                TextFormField(
                                  validator: (value){
                                    return isEmailValid(value);
                                  },
                                  controller: _controllerEmail,
                                  style: TextStyle(
                                    fontSize: screenHeight / 40,
                                    fontFamily: 'Comfortaa',
                                    color: const Color(0xff2D2D2D),
                                  ),
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
                                    contentPadding: EdgeInsets.only(bottom: screenHeight/70, left: screenWidth/20),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    labelText: 'Почта',
                                    labelStyle: TextStyle(
                                      fontSize: screenHeight / 45,
                                      fontFamily: 'Comfortaa',
                                      color: const Color(0xff2D2D2D),
                                    ),
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                  ),
                                ),
                              ),
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: screenHeight/50),
                            child: SizedBox(
                              width: screenWidth/1.1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: screenWidth/1.1 * 0.48,
                                    height: screenHeight/14,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: _weightTextFieldColor,
                                            width: 2
                                        )
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: screenHeight/50),
                                      child:
                                      TextFormField(
                                        validator: (value){
                                          if(isWeightValid(value)){
                                            setState(() {
                                              assignDefaultColor();
                                            });
                                          }
                                          else{
                                            setState(() {
                                              _weightTextFieldColor = errorColor;
                                            });
                                            if(validate){
                                              validate = false;
                                            }
                                          }
                                          return null;
                                        },
                                        controller: _controllerWeight,
                                        style: TextStyle(
                                          fontSize: screenHeight / 40,
                                          fontFamily: 'Comfortaa',
                                          color: const Color(0xff2D2D2D),
                                        ),
                                        maxLength: 5,
                                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
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
                                          contentPadding: EdgeInsets.only(bottom: screenHeight/70, left: screenWidth/20),
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          labelText: 'Вес',
                                          labelStyle: TextStyle(
                                            fontSize: screenHeight / 45,
                                            fontFamily: 'Comfortaa',
                                            color: const Color(0xff2D2D2D),
                                          ),
                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: screenWidth/1.1 * 0.48,
                                    height: screenHeight/14,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: _weightDreamTextFieldColor,
                                            width: 2
                                        )
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: screenHeight/50),
                                      child:
                                      TextFormField(
                                        validator: (value){
                                          if(isWeightValid(value)){
                                            setState(() {
                                              assignDefaultColor();
                                            });
                                          }
                                          else{
                                            setState(() {
                                              _weightDreamTextFieldColor = errorColor;
                                            });
                                            if(validate){
                                              validate = false;
                                            }
                                          }
                                          return null;
                                        },
                                        controller: _controllerWeightDream,
                                        style: TextStyle(
                                          fontSize: screenHeight / 40,
                                          fontFamily: 'Comfortaa',
                                          color: const Color(0xff2D2D2D),
                                        ),
                                        maxLength: 5,
                                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                                        textAlign: TextAlign.start,
                                        textAlignVertical: TextAlignVertical.bottom,
                                        onChanged: (String value){
                                          weightDream = value;
                                        },
                                        onTap: (){
                                          setState(() {
                                            assignDefaultColor();
                                            _weightDreamTextFieldColor = activeColor;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          counterText: '',
                                          contentPadding: EdgeInsets.only(bottom: screenHeight/70, left: screenWidth/20),
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          labelText: 'Желаемый вес',
                                          labelStyle: TextStyle(
                                            fontSize: screenHeight / 45,
                                            fontFamily: 'Comfortaa',
                                            color: const Color(0xff2D2D2D),
                                          ),
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
                                children: [
                                  Container(
                                    width: screenWidth/1.1 * 0.48,
                                    height: screenHeight/14,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: _heightTextFieldColor,
                                            width: 2
                                        )
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: screenHeight/50),
                                      child:
                                      TextFormField(
                                        validator: (value){
                                          if(isHeightValid(value)){
                                            setState(() {
                                              assignDefaultColor();
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
                                        style: TextStyle(
                                          fontSize: screenHeight / 40,
                                          fontFamily: 'Comfortaa',
                                          color: const Color(0xff2D2D2D),
                                        ),
                                        maxLength: 5,
                                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
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
                                          contentPadding: EdgeInsets.only(bottom: screenHeight/70, left: screenWidth/20),
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          labelText: 'Рост',
                                          labelStyle: TextStyle(
                                            fontSize: screenHeight / 45,
                                            fontFamily: 'Comfortaa',
                                            color: const Color(0xff2D2D2D),
                                          ),
                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      _selectDate(context);
                                    },
                                    child: Container(
                                      width: screenWidth/1.1 * 0.48,
                                      height: screenHeight/14,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(
                                              color: _birthdayTextFieldColor,
                                              width: 2
                                          )
                                      ),
                                      child: Padding(
                                          padding: EdgeInsets.only(top: screenHeight/100, left: screenWidth/20),
                                          child:
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Дата рождения',
                                                style: TextStyle(
                                                  fontSize: screenHeight / 63,
                                                  fontFamily: 'Comfortaa',
                                                  color: const Color(0xff2D2D2D),
                                                ),
                                              ),
                                              Padding(padding: EdgeInsets.only(top: screenHeight/200)),
                                              Text(
                                                birthday,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: screenHeight / 45,
                                                  fontFamily: 'Comfortaa',
                                                  color: const Color(0xff2D2D2D),
                                                ),
                                              )
                                            ],
                                          )
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                        ),
                        Padding(padding: EdgeInsets.only(top: screenHeight/50),
                          child: SizedBox(
                            width: screenWidth,
                            child: Text(
                              error,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: screenHeight / 45,
                                fontFamily: 'Comfortaa',
                                color: const Color(0xffff000d),
                              ),
                            )
                          ),
                        )
                      ]
                  );
                }
                )
            ),
          )
      )
    );

  }
}
