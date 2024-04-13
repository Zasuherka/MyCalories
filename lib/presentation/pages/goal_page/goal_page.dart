import 'package:app1/internal/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:app1/domain/enums/goal.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/validation/profile.dart';
import 'package:app1/presentation/pages/goal_page/widgets/CPFC_form.dart';
import 'package:app1/presentation/pages/goal_page/widgets/activity_slider.dart';
import 'package:app1/presentation/widgets/custom_drop_down_button.dart';
import 'package:app1/presentation/widgets/switch.dart';
import 'package:app1/presentation/pages/goal_page/widgets/title_for_goal_page.dart';
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

  final Color textAdditionalColor = AppColors.lightGrey;

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

  Color defaultColor = AppColors.textColor;
  Color defaultWeightColor = Colors.transparent;
  Color activeColor = AppColors.turquoise ;
  Color errorColor = AppColors.red;

  late Color _weightTextFieldColor;
  late Color _heightTextFieldColor;
  late Color _ageTextFieldColor;
  late Color _sexButtonColor;
  late Color _gainWeightColor;
  late Color _saveWeightColor;
  late Color _loseWeightColor;

  final TextEditingController _controllerWeight = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();
  final TextEditingController _controllerHeight = TextEditingController();

  BoxDecoration _getContainerDecoration(Color color) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: color,
            width: 1
        )
    );
  }

  BoxDecoration _getButtonDecoration(Color borderColor){
    return BoxDecoration(
      color: AppColors.elementColor,
      boxShadow: boxShadow,
      borderRadius: BorderRadius.circular(25),
      border: Border.all(
        width: 1,
        color: borderColor
      )
    );
  }

  void _assignDefaultColor() {
    _sexButtonColor = defaultColor;
    _weightTextFieldColor = defaultColor;
    _heightTextFieldColor = defaultColor;
    _ageTextFieldColor = defaultColor;
  }

  void _assignDefaultWeightColor() {
    _gainWeightColor = defaultWeightColor;
    _saveWeightColor = defaultWeightColor;
    _loseWeightColor = defaultWeightColor;
  }

  void _countCPFC(){
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
    _assignDefaultColor();
    _assignDefaultWeightColor();
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        _assignDefaultColor();
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).padding.top + 20,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.greenGradient
            ),
          ),
          leading: context.router.canPop() ? Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(
                maxWidth: 33,
                maxHeight: 33,
              ),
              child: GestureDetector(
                onTap: () {
                  context.router.pop();
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
          ) : const SizedBox(),
          title: const Text(
            'Калькулятор КБЖУ'
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
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
                    _switchValue ? const SizedBox(
                      height: 20,
                    ) : const SizedBox(),
                    CPFCForm(isActive: _switchValue),
                    const SizedBox(
                      height: 25,
                    ),
                    const TitleForGoalPage(title: 'Общая информация'),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                        const SizedBox(
                            width :10
                        ),
                        Expanded(
                          child: Container(
                            height: 74,
                            padding: const EdgeInsets.only(top: 20),
                            alignment: Alignment.centerLeft,
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
                                _controllerWeight.text = value;
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
                                constraints: const BoxConstraints.tightFor(width: 160, height: 70),
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
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 74,
                            padding: const EdgeInsets.only(top: 20),
                            alignment: Alignment.centerLeft,
                            decoration: _getContainerDecoration(_ageTextFieldColor),
                            child: TextFormField(
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
                                  _assignDefaultColor();
                                  _ageTextFieldColor = activeColor;
                                });
                              },
                              decoration: InputDecoration(
                                counterText: '',
                                constraints: const BoxConstraints.tightFor(width: 160, height: 70),
                                contentPadding: const EdgeInsets.only(bottom: 20, left: 20),
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
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 74,
                            padding: const EdgeInsets.only(top: 20),
                            alignment: Alignment.centerLeft,
                            decoration: _getContainerDecoration(_heightTextFieldColor),
                            child: TextFormField(
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
                                constraints: const BoxConstraints.tightFor(width: 160, height: 70),
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
                      ],
                    ),
                    const SizedBox(
                        height: 20
                    ),
                    const TitleForGoalPage(title: 'Активность'),
                    const SizedBox(
                        height: 20
                    ),
                    ActivitySlider(onChanged: (value) {
                      activityCoefficient = value;
                      _assignDefaultColor();
                    }),
                    const SizedBox(
                        height: 20
                    ),
                    const TitleForGoalPage(title: 'Ваша цель'),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() {
                              _assignDefaultWeightColor();
                              _loseWeightColor = activeColor;
                              _goalValue = Goal.lose;
                            }),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              decoration: _getButtonDecoration(_loseWeightColor),
                              child: Text(Goal.lose.goal,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() {
                              _assignDefaultWeightColor();
                              _saveWeightColor = activeColor;
                              _goalValue = Goal.save;
                            }),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              decoration: _getButtonDecoration(_saveWeightColor),
                              child: Text(Goal.save.goal,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() {
                              _assignDefaultWeightColor();
                              _gainWeightColor = activeColor;
                              _goalValue = Goal.gain;
                            }),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              decoration: _getButtonDecoration(_gainWeightColor),
                              child: Text(Goal.gain.goal,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: (){
                        if(sexValue.toLowerCase() == 'не выбран'){
                          setState(() {
                            _sexButtonColor = errorColor;
                            validate = false;
                          });
                          return;
                        }
                        else {
                          setState(() {
                            _sexButtonColor = defaultColor;
                            validate = true;
                          });
                        }
                        if(_formKey.currentState != null && _formKey.currentState!.validate() && validate){
                          _assignDefaultColor();
                          _assignDefaultWeightColor();
                          _saveWeightColor = activeColor;
                          if(calories == 0){
                            scrollController.animateTo(340, duration: const Duration(seconds: 1), curve: Curves.easeIn);
                          }
                          _countCPFC();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        decoration: BoxDecoration(
                          gradient: AppColors.greenGradient,
                          boxShadow: boxShadow,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text('Расчитать',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.white
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                        width: calories != 0 ? screenWidth : 0,
                        height: calories != 0 ? 325 : 0,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                            const Spacer(flex: 2),
                            Text('Дневная суточная норма',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const Spacer(flex: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 20),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  width: 70,
                                  height: 90,
                                  child: PieChart(
                                    PieChartData(
                                        sectionsSpace: 5,
                                        startDegreeOffset : 270,
                                        centerSpaceRadius: 28,
                                        centerSpaceColor: Colors.white,
                                        borderData: FlBorderData(show: false),
                                        sections: [
                                          PieChartSectionData
                                            (
                                              title: '',
                                              radius: 12,
                                              value: carbohydrates.toDouble(),
                                              color: AppColors.colorForCarbohydrates
                                          ),
                                          PieChartSectionData
                                            (
                                              title: '',
                                              radius: 12,
                                              value: fats.toDouble(),
                                              color: AppColors.colorForFats
                                          ),
                                          PieChartSectionData
                                            (
                                              title: '',
                                              radius: 12,
                                              value: protein.toDouble(),
                                              color: AppColors.colorForProtein
                                          ),
                                        ]
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text('${calories.toStringAsFixed(0)} кКал',
                                  style: Theme.of(context).textTheme.titleMedium,
                                )
                              ],
                            ),
                            const Spacer(flex: 2),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20),
                              child: Text('Из которых:',
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
                                const SizedBox(width: 20),
                                Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TitleForGoalPage(title: '$protein г.', color: AppColors.colorForProtein),
                                        const SizedBox(height: 5),
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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TitleForGoalPage(title: '$fats г.', color: AppColors.colorForFats),
                                        const SizedBox(height: 5),
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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TitleForGoalPage(title: '$carbohydrates г.', color: AppColors.colorForCarbohydrates),
                                        const SizedBox(height: 5),
                                        Text('Углеводы',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                              color: AppColors.colorForHintText
                                          ),
                                        )
                                      ],
                                    )
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                            const Spacer(flex: 2),
                            BlocBuilder<UserInfoBloc, UserInfoState>(
                                builder: (context,state){
                                  state.whenOrNull(
                                    error: (error) {
                                      response = error;
                                      _responseColor = errorColor;
                                    },
                                    successful: () {
                                      response = 'Изменения успешно сохранены';
                                      _responseColor = activeColor;
                                    }
                                  );
                                  return Text(response,
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          color: _responseColor
                                      ));
                                }
                            ),
                            const Spacer(flex: 2),
                            GestureDetector(
                              onTap: (){
                                FocusScope.of(context).unfocus();
                                _assignDefaultColor();
                                if(_formKey.currentState != null && _formKey.currentState!.validate()){
                                  BlocProvider.of<UserInfoBloc>(context).add(UserInfoEvent.update(
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
                                width: 250,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: AppColors.turquoise,
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: boxShadow
                                ),
                                child: Text('Сохранить',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: AppColors.white
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                                      color: textAdditionalColor
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
                                      color: textAdditionalColor
                                  )
                              ),
                              TextSpan(
                                  text: '10 * вес(кг) + 6,25 * рост(см) – 5 * возраст(г) + 5;\n',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      height: 1.5,
                                      color: textAdditionalColor,
                                      fontStyle: FontStyle.italic
                                  )
                              ),
                              TextSpan(
                                  text: 'для женщин: \n' ,
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      height: 1.5,
                                      color: textAdditionalColor
                                  )
                              ),
                              TextSpan(
                                  text: '10 * вес(кг) + 6,25 * рост(см) – 5 * возраст(г) - 161;\n',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      height: 1.5,
                                      color: textAdditionalColor,
                                      fontStyle: FontStyle.italic
                                  )
                              ),
                              TextSpan(
                                  text: '2) Доработанный вариант формулы Миффлина-Сан Жеора, в отличие от упрощенного '
                                      'дает более точную информацию и учитывает степень физической активности человека:\n'
                                      'для мужчин: \n',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      height: 1.5,
                                      color: textAdditionalColor
                                  )
                              ),
                              TextSpan(
                                  text: '(10 * вес(кг) + 6,25 * рост(см) – 5 * возраст(г) + 5) * A;\n',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      height: 1.5,
                                      color: textAdditionalColor,
                                      fontStyle: FontStyle.italic
                                  )
                              ),
                              TextSpan(
                                  text: 'для женщин: \n' ,
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      height: 1.5,
                                      color: textAdditionalColor
                                  )
                              ),
                              TextSpan(
                                  text: '(10 * вес(кг) + 6,25 * рост(см) – 5 * возраст(г) - 161) * A;\n',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      height: 1.5,
                                      color: textAdditionalColor,
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
                                      color: textAdditionalColor
                                  )
                              ),
                            ]
                        )
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )
          )
        ),
      ),
    );
  }
}




