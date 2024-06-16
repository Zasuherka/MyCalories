import 'package:app1/presentation/constants.dart';
import 'package:flutter/material.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    String time = '15 апреля 2024г.';
    String description = 'Здоровое питание – это такое питание, которое обеспечивает рост, оптимальное развитие, полноценную жизнедеятельность, способствует укреплению здоровья и профилактике неинфекционных заболеваний (НИЗ), включая диабет, болезни сердца, инсульт и рак.\nЗдоровое питание на протяжении всей жизни - важнейший элемент сохранения и укрепления здоровья нынешних и будущих поколений, а также, непременное условие достижения активного долголетия.';
    String imageUrl = 'https://mykaleidoscope.ru/x/uploads/posts/2022-09/1663788558_56-mykaleidoscope-ru-p-steik-tibon-yeda-krasivo-63.jpg';

    Widget verticalOffset = const SizedBox(
      height: 10,
    );
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.5, vertical: 8),
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        color: AppColors.elementColor,
        borderRadius: BorderRadius.circular(25)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          verticalOffset,
          verticalOffset,
          Container(
            padding: const EdgeInsets.only(left: 30),
            alignment: Alignment.centerLeft,
            child: Text(time,
                style: Theme.of(context).textTheme.bodyLarge
            ),
          ),
          verticalOffset,
          Image.network(imageUrl,
            alignment: Alignment.topCenter,
            width: screenWidth - 60,
          ),
          verticalOffset,
          verticalOffset,
          SizedBox(
            width: screenWidth - 60,
            child: Text(description,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          verticalOffset,

        ],
      ),
    );
  }
}
