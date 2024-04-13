import 'package:app1/presentation/constants.dart';
import 'package:flutter/material.dart';

class ActivitySlider extends StatefulWidget {
  final ValueChanged<double> onChanged;
  const ActivitySlider({super.key, required this.onChanged});

  @override
  State<ActivitySlider> createState() => _ActivitySliderState();
}

class _ActivitySliderState extends State<ActivitySlider> {
  final List<String> activeList = [
    'Минимальная активность',
    'Слабый уровень активности',
    'Умеренный уровень активности',
    'Тяжелая или трудоемкая активность',
    'Экстремальный уровень'
  ];
  final List<String> activeListDescription = [
    'Сидячая работа, не требующая значительных физических нагрузок',
    'Интенсивные упражнения не менее 20 минут один-три раза в неделю',
    'Интенсивная тренировка не менее 30-60 мин три-четыре раза в неделю',
    'Интенсивные упражнения и занятия спортом 5-7 дней в неделю',
    'Включает чрезвычайно активные и/или очень энергозатратные виды деятельности: '
        'занятия спортом с почти ежедневным графиком и несколькими тренировками в течение дня'
  ];
  double _currentSliderValue = 1;
  @override
  Widget build(BuildContext context) {
    
   
    return Column(
      //mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            overlayShape: SliderComponentShape.noOverlay,
          ),
          child: Slider(
            value: _currentSliderValue,
            min: 0,
            max: 4,
            divisions: 4,
            activeColor: AppColors.turquoise ,
            onChanged: (value){
              setState(() {
                _currentSliderValue = value;
              });
              switch(_currentSliderValue){
                case 0:
                  widget.onChanged(1.2);
                  break;
                case 1:
                  widget.onChanged(1.375);
                  break;
                case 2:
                  widget.onChanged(1.55);
                  break;
                case 3:
                  widget.onChanged(1.7);
                  break;
                case 4:
                  widget.onChanged(1.9);
                  break;
              }
            },
          ),
        ),
        SizedBox(height: screenHeight/40),
        SizedBox(
          width: screenWidth,
          child: Text('${activeList[_currentSliderValue.toInt()]}:',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        SizedBox(height: screenHeight/50),
        SizedBox(
          child: Text('${activeListDescription[_currentSliderValue.toInt()]}.',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.lightGrey
            ),
          ),
        ),
      ],
    );
  }
}
