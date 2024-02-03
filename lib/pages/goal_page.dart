import 'package:app1/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:app1/enums/goal.dart';
import 'package:app1/constants.dart';
import 'package:app1/validation/profile.dart';
import 'package:app1/widgets/CPFC_form.dart';
import 'package:app1/widgets/actity_slider.dart';
import 'package:app1/widgets/switch.dart';
import 'package:app1/widgets/title_for_goal_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class GoalPage extends StatefulWidget {
  const GoalPage({super.key});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> with ProfileValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _switchValue = false;
  bool isShow = false;

  bool validate = true;

  bool switchValue = false;
  bool dropMenuValue = false;
  List<String> sexList = ['Не выбран','Мужской','Женский'];
  String weight = '';
  String height = '';
  String age = '';
  double activityCoefficient = 1.375;
  int protein = 0;
  int fats = 0;
  int carbohydrates = 0;
  int calories = 0;
  Goal _goalValue = Goal.save;
  String sexValue = 'Не выбран';
  String error = '';
  String response = '';
  Color? _responseColor;


  final ScrollController scrollController = ScrollController();

  Color defaultColor = AppColors.dark;
  Color defaultWeightColor = AppColors.white;
  Color activeColor = AppColors.turquoise ;
  Color errorColor = AppColors.red;

  late Color _weightTextFieldColor;
  late Color _heightTextFieldColor;
  late Color _ageTextFieldColor;
  late Color _sexTextFieldColor;
  late Color _gainWeightColor;
  late Color _saveWeightColor;
  late Color _loseWeightColor;

  final TextEditingController _controllerWeight = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();
  final TextEditingController _controllerHeight = TextEditingController();

  BoxDecoration _getContainerDecoration(Color color) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
            color: color,
            width: 1
        )
    );
  }

  BoxDecoration _getButtonDecoration(Color borderColor){
    return BoxDecoration(
      color: AppColors.white,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: AppColors.black.withOpacity(0.2),
          offset: const Offset(10,10),
          blurRadius: 15
        ),
      ],
      borderRadius: BorderRadius.circular(25),
      border: Border.all(
        width: 2,
        color: borderColor
      )
    );
  }

  void assignDefaultColor() {
    _sexTextFieldColor = defaultColor;
    _weightTextFieldColor = defaultColor;
    _heightTextFieldColor = defaultColor;
    _ageTextFieldColor = defaultColor;
  }

  void assignDefaultWeightColor() {
    _gainWeightColor = defaultWeightColor;
    _saveWeightColor = defaultWeightColor;
    _loseWeightColor = defaultWeightColor;
  }

  void countCPFC(){
    if (sexValue.toLowerCase() == 'не выбран')
    {
      return;
    }
    final sexNum = sexValue == 'Мужской' ? 5 : -161;
    int percent = 100;
    switch(_goalValue){
      case Goal.lose:
        percent = 80;
        break;
      case Goal.gain:
        percent = 120;
      case Goal.save:
        percent = 100;
    }
    setState(() {
      calories =  ((10 * double.parse(weight)  + 6.25 * double.parse(height) -
          5 * double.parse(age) + sexNum) * activityCoefficient * (percent/100)).toInt();

      protein = calories * 0.3 ~/ 4;
      fats = calories * 0.3 ~/ 9;
      carbohydrates = calories * 0.4 ~/ 4;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assignDefaultColor();
    assignDefaultWeightColor();
    _saveWeightColor = AppColors.turquoise ;
  }

  ///Очищаем память
  @override
  void dispose() {
    _controllerWeight.dispose();
    _controllerHeight.dispose();
    _controllerAge.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localUser = context.read<UserInfoBloc>().localUser;
    if(localUser != null){
      weight = localUser.weightNow?.toString() ?? '';
      height = localUser.height?.toString() ?? '';
      age = localUser.age?.toString()  ??  '';
      sexValue = localUser.sex?.sex ?? sexValue;
      _controllerWeight.text = weight;
      _controllerHeight.text = height;
      _controllerAge.text = age;
      if(sexValue != 'Не выбран'){
        sexList.remove('Не выбран');
      }
    }
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        assignDefaultColor();
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: AppColors.greenGradient
            ),
          ),
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
                  context.router.pop();
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
          title: const Text(
            'Калькулятор КБЖУ'
          ),
        ),
        body: Form(
          key: _formKey,
          child: BlocBuilder<UserInfoBloc, UserInfoState>(
            builder: (context, state) {

              // if(state is LocalUserInfoState) {
              //
              //   BlocProvider.of<UserInfoBloc>(context).add(StopBuildUserInfoEvent());
              // }
              if(state is UserInfoErrorState){
                error = state.error;
              }
              return SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: (screenWidth - (screenWidth/1.1))/2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenHeight/100,
                        ),
                        Row(
                          children: [
                            Transform.scale(
                                scale: 0.75,
                                alignment: Alignment.centerLeft,
                                child: CustomSwitch(
                                    value: _switchValue,
                                    onChanged: (value) => setState(()=> _switchValue = !_switchValue)
                                )
                            ),
                            Text('Знаю свой КБЖУ',
                              style: Theme.of(context).textTheme.titleSmall,
                            )
                          ],
                        ),
                        _switchValue ? SizedBox(
                          height: screenHeight/50,
                        ) : const SizedBox(),
                        CPFCForm(isActive: _switchValue),
                        SizedBox(
                          height: screenHeight/40,
                        ),
                        const TitleForGoalPage(title: 'Общая информация'),
                        SizedBox(
                          height: screenHeight/50,
                        ),
                        SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: screenHeight * 0.083,
                                width: screenWidth * 0.43,
                                alignment: Alignment.centerLeft,
                                //padding: EdgeInsets.zero,
                                decoration: _getContainerDecoration(_sexTextFieldColor),
                                child: Padding(
                                  padding: EdgeInsets.only(top: screenHeight/45),
                                  child: DropdownButtonFormField<String>(
                                    iconSize: 0,
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
                                      constraints: BoxConstraints.tightFor(width: screenWidth * 0.43, height: screenHeight * 0.075),
                                      contentPadding: EdgeInsets.only(bottom: screenHeight/40, left: screenWidth/20),
                                      labelText: 'Пол',
                                      labelStyle: Theme.of(context).textTheme.titleMedium,
                                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                height: screenHeight * 0.083,
                                width: screenWidth * 0.43,
                                alignment: Alignment.centerLeft,
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
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeight/50,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: screenHeight * 0.083,
                              width: screenWidth * 0.43,
                              alignment: Alignment.centerLeft,
                              decoration: _getContainerDecoration(_ageTextFieldColor),
                              child: Padding(
                                padding: EdgeInsets.only(top: screenHeight/45),
                                child:
                                TextFormField(
                                  validator: (value){
                                    if(isWeightValid(value)){
                                      setState(() {
                                        _ageTextFieldColor = defaultColor;
                                      });
                                    }
                                    else{
                                      setState(() {
                                        _ageTextFieldColor = errorColor;
                                      });
                                      if(validate){
                                        validate = false;
                                      }
                                    }
                                    return null;
                                  },
                                  controller: _controllerAge,
                                  style: Theme.of(context).textTheme.titleMedium,
                                  maxLength: 3,
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  textAlign: TextAlign.start,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  onChanged: (String value){
                                    age = value;
                                  },
                                  onTap: (){
                                    setState(() {
                                      assignDefaultColor();
                                      _ageTextFieldColor = activeColor;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    counterText: '',
                                    constraints: BoxConstraints.tightFor(width: screenWidth * 0.4, height: screenHeight * 0.075),
                                    contentPadding: EdgeInsets.only(bottom: screenHeight/40, left: screenWidth/20),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    labelText: 'Возраст',
                                    labelStyle: Theme.of(context).textTheme.titleMedium,
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              height: screenHeight * 0.083,
                              width: screenWidth * 0.43,
                              alignment: Alignment.centerLeft,
                              decoration: _getContainerDecoration(_heightTextFieldColor),
                              child: Padding(
                                padding: EdgeInsets.only(top: screenHeight/45),
                                child:
                                TextFormField(
                                  validator: (value){
                                    if(isWeightValid(value)){
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
                                  maxLength: 3,
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
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
                          ],
                        ),
                        SizedBox(height: screenHeight/20),
                        const TitleForGoalPage(title: 'Активность'),
                        SizedBox(height: screenHeight/50),
                        ActivitySlider(onChanged: (value) {
                          activityCoefficient = value;
                          assignDefaultColor();
                        }),
                        SizedBox(height: screenHeight/20),
                        const TitleForGoalPage(title: 'Ваша цель'),
                        SizedBox(height: screenHeight/50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => setState(() {
                                assignDefaultWeightColor();
                                _loseWeightColor = activeColor;
                                _goalValue = Goal.lose;
                              }),
                              child: Container(
                                alignment: Alignment.center,
                                width: screenWidth * 0.28,
                                height: screenHeight/15,
                                decoration: _getButtonDecoration(_loseWeightColor),
                                child: Text(Goal.lose.goal,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setState(() {
                                assignDefaultWeightColor();
                                _saveWeightColor = activeColor;
                                _goalValue = Goal.save;
                              }),
                              child: Container(
                                alignment: Alignment.center,
                                width: screenWidth * 0.28,
                                height: screenHeight/15,
                                decoration: _getButtonDecoration(_saveWeightColor),
                                child: Text(Goal.save.goal,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setState(() {
                                assignDefaultWeightColor();
                                _gainWeightColor = activeColor;
                                _goalValue = Goal.gain;
                              }),
                              child: Container(
                                alignment: Alignment.center,
                                width: screenWidth * 0.28,
                                height: screenHeight/15,
                                decoration: _getButtonDecoration(_gainWeightColor),
                                child: Text(Goal.gain.goal,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight/30),
                        GestureDetector(
                          onTap: (){
                            if(sexValue.toLowerCase() == 'не выбран'){
                              setState(() {
                                _sexTextFieldColor = errorColor;
                                validate = false;
                              });
                              return;
                            }
                            else {
                              setState(() {
                                _sexTextFieldColor = defaultColor;
                                validate = true;
                              });
                            }
                            if(_formKey.currentState != null && _formKey.currentState!.validate() && validate){
                              assignDefaultColor();
                              _saveWeightColor = activeColor;
                              if(calories == 0){
                                scrollController.animateTo(screenHeight/3.5, duration: const Duration(seconds: 1), curve: Curves.easeIn);
                              }
                              countCPFC();
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: screenWidth/1.1,
                            height: screenHeight/20,
                            decoration: BoxDecoration(
                                color: AppColors.turquoise ,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: AppColors.black.withOpacity(0.2),
                                      offset: const Offset(10,10),
                                      blurRadius: 15
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text('Расчитать',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.white
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight/30),
                        Center(
                          child: AnimatedContainer(
                            onEnd: () {
                              setState(() {
                                if(calories != 0){
                                  isShow = true;
                                }
                              });
                            },
                            duration: const Duration(milliseconds: 400),
                            width: calories != 0 ? screenWidth/1.1 : 0,
                            height: calories != 0 ? screenHeight/3 : 0,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: AppColors.black.withOpacity(0.2),
                                      offset: const Offset(10,10),
                                      blurRadius: 15
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(25),
                            ),
                            child: !isShow ? const SizedBox() : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Spacer(),
                                Text('Дневная суточная норма',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: screenWidth/20),
                                    SizedBox(
                                      width: screenHeight/10,
                                      height: screenHeight/10,
                                      child: PieChart(
                                        PieChartData(
                                          sectionsSpace: screenWidth/100,
                                          startDegreeOffset : 270,
                                          centerSpaceRadius: screenWidth * 0.07,
                                          centerSpaceColor: Colors.white,
                                          borderData: FlBorderData(show: false),
                                          sections: [
                                            PieChartSectionData
                                              (
                                                title: '',
                                                radius: screenWidth * 0.03,
                                                value: carbohydrates.toDouble(),
                                                color: AppColors.colorForCarbohydrates
                                            ),
                                            PieChartSectionData
                                              (
                                                title: '',
                                                radius: screenWidth * 0.03,
                                                value: fats.toDouble(),
                                                color: AppColors.colorForFats
                                            ),
                                            PieChartSectionData
                                              (
                                                title: '',
                                                radius: screenWidth * 0.03,
                                                value: protein.toDouble(),
                                                color: AppColors.colorForProtein
                                            ),
                                          ]
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: screenWidth/40),
                                    Text('${calories.toStringAsFixed(0)} кКал',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    )
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  padding: EdgeInsets.only(left: screenWidth/12),
                                  width: screenWidth/1.1,
                                  child: Text('Из которых',
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: AppColors.colorForHintText
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: screenWidth/20),
                                    Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                width: screenWidth/3.5,
                                                child: TitleForGoalPage(title: '$protein г.', color: AppColors.colorForProtein)),
                                            SizedBox(height: screenHeight/200),
                                            Text('Белки',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                  color: AppColors.colorForHintText
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                    Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                width: screenWidth/3.5,
                                                child: TitleForGoalPage(title: '$fats г.', color: AppColors.colorForFats)),
                                            SizedBox(height: screenHeight/200),
                                            Text('Жиры',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                  color: AppColors.colorForHintText
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                    Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                width: screenWidth/3.5,
                                                child: TitleForGoalPage(title: '$carbohydrates г.', color: AppColors.colorForCarbohydrates)),
                                            SizedBox(height: screenHeight/200),
                                            Text('Углеводы',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                  color: AppColors.colorForHintText
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                    SizedBox(width: screenWidth/20),
                                  ],
                                ),
                                const Spacer(),
                                BlocBuilder<UserInfoBloc, UserInfoState>(
                                    builder: (context,state){
                                      if(state is UserInfoErrorState){
                                        response = state.error;
                                        _responseColor = errorColor;
                                      }
                                      if(state is UserInfoSuccessfulState){
                                        response = 'Изменения успешно сохранены';
                                        _responseColor = activeColor;
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
                                    if(_formKey.currentState != null && _formKey.currentState!.validate()){
                                      BlocProvider.of<UserInfoBloc>(context).add(UserEditingInfoEvent(
                                          carbohydratesGoal: carbohydrates,
                                          caloriesGoal: calories,
                                          fatsGoal: fats,
                                          proteinGoal: protein
                                      ));
                                      return;
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: screenWidth/1.4,
                                    height: screenHeight/23,
                                    decoration: BoxDecoration(
                                      color: AppColors.turquoise ,
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
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight/40),
                        RichText(
                            text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' Формула Миффлина-Сан Жеора,\n',
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          height: 1.5,
                                      )
                                  ),
                                  TextSpan(
                                      text: 'разработанная группой '
                                      'американских врачей-диетологов под руководством докторов Миффлина и Сан Жеора в 2005 году, '
                                      'выдаёт необходимое количество килокалорий в сутки для каждого конкретного человека.\n',
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      height: 1.5,
                                      color: AppColors.grey
                                      )
                                  ),
                                  TextSpan(
                                      text: ' Существует два варианта формулы:\n',
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          height: 1.5,
                                      )
                                  ),
                                  TextSpan(
                                      text: '1) Упрощенный вариант формулы Миффлина-Сан Жеора:\n'
                                          'для мужчин: \n' ,
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          height: 1.5,
                                          color: AppColors.grey
                                      )
                                  ),
                                  TextSpan(
                                      text: '10 * вес(кг) + 6,25 * рост(см) – 5 * возраст(г) + 5;\n',
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          height: 1.5,
                                          color: AppColors.grey,
                                          fontStyle: FontStyle.italic
                                      )
                                  ),
                                  TextSpan(
                                      text: 'для женщин: \n' ,
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          height: 1.5,
                                          color: AppColors.grey
                                      )
                                  ),
                                  TextSpan(
                                      text: '10 * вес(кг) + 6,25 * рост(см) – 5 * возраст(г) - 161;\n',
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          height: 1.5,
                                          color: AppColors.grey,
                                          fontStyle: FontStyle.italic
                                      )
                                  ),
                                  TextSpan(
                                      text: '2) Доработанный вариант формулы Миффлина-Сан Жеора, в отличие от упрощенного '
                                          'дает более точную информацию и учитывает степень физической активности человека:\n'
                                          'для мужчин: \n',
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          height: 1.5,
                                          color: AppColors.grey
                                      )
                                  ),
                                  TextSpan(
                                      text: '(10 * вес(кг) + 6,25 * рост(см) – 5 * возраст(г) + 5) * A;\n',
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          height: 1.5,
                                          color: AppColors.grey,
                                          fontStyle: FontStyle.italic
                                      )
                                  ),
                                  TextSpan(
                                      text: 'для женщин: \n' ,
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          height: 1.5,
                                          color: AppColors.grey
                                      )
                                  ),
                                  TextSpan(
                                      text: '(10 * вес(кг) + 6,25 * рост(см) – 5 * возраст(г) - 161) * A;\n',
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          height: 1.5,
                                          color: AppColors.grey,
                                          fontStyle: FontStyle.italic
                                      )
                                  ),
                                  TextSpan(
                                      text: 'A – это уровень физической активности человека. Его различают по пяти степеням физических нагрузок в сутки:\n'
                                          '\u2022  1.2 – минимальная активность;\n'
                                          '\u2022  1.375 – слабый уровень активности;\n'
                                          '\u2022  1,55 – умеренный уровень активности;\n'
                                          '\u2022  1,7 – тяжелая или трудоемкая активность;\n'
                                          '\u2022  1,9 – экстремальный уровень;\n'
                                          'В приложении \'Мой фитнес\' используется второй вариант формулы.',
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          height: 1.5,
                                          color: AppColors.grey
                                      )
                                  ),
                                ]
                            )
                        ),
                        SizedBox(height: screenHeight/40),
                      ],
                    ),
                  )
              );
            },
          ),
        ),
      ),
    );
  }
}




