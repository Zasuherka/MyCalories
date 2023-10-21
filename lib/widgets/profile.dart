import 'package:app1/widgets/wrap1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//TODO: НЕ ЗАБЫТЬ УДАЛИТЬ Profile2
class Profile extends StatelessWidget {

  const Profile({super.key});

  @override
  Widget build(BuildContext context,) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    Image getImage(String url) {
      Image image = Image.network(url, errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace)
      {
        return Image.asset('images/icon.jpg',fit: BoxFit.cover);
        },
          fit: BoxFit.cover
      );
      return image;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(137, 195, 232, 0.3),
                            spreadRadius: 5,
                            blurRadius: 13,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      width: screenWidth,
                      height: screenWidth / 27  * 13,
                      child: SvgPicture.asset(
                        'images/wawes.svg',
                        colorFilter: const ColorFilter.mode(
                            Colors.transparent, BlendMode.color),
                        // Применение прозрачного фильтра
                        width: screenWidth,
                      )
                  ),
                  Padding(padding: EdgeInsets.only(top: screenWidth / 27  * 13 - screenHeight/14, left: screenWidth/2 - screenHeight/14),
                    child: GestureDetector(
                      onTap: (){
                        showModalBottomSheet(context: context, builder: (BuildContext context) => const Wrap1());
                      },
                      child: Container(
                        height: screenHeight/7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                            boxShadow: [BoxShadow(
                              color: Colors.black.withOpacity(0.17),
                              spreadRadius: 4,
                              blurRadius: 10,
                              offset: Offset(0, -5),
                            )]
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(360),
                          child: getImage("https://sun9-42.userapi.com/impf/c851032/v851032490/1677ea/6YLRQHsmaDo.jpg?size=1080x1078&quality=96&sign=481d08ba800ac523bd43c64bcc1a1b09&type=album"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: screenHeight/70)),
              Text('Natasha', style: TextStyle(
                fontSize: screenHeight/29,
                fontFamily: 'Comfortaa',
                color: Colors.black,
              ),
              ),
              Padding(padding: EdgeInsets.only(top: screenHeight/100)),
              Text(
                'zasuherka2002@gmail.com',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: screenHeight/50,
                  fontFamily: 'Comfortaa',
                  color: Colors.black,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: screenHeight/70)),
              Container(
                width: screenWidth * 0.95,
                height: screenHeight/4,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 13,
                        offset: const Offset(10, 10),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: screenHeight/70)),
                    Text(
                      'Очень высокая активность',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: screenHeight/50 ,
                        fontFamily: 'Comfortaa',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      )
    );
  }
}

//TODO: ЭТО ТЕСТОВАЯ ВЕЩЬ ЕЁ ОБЯЗАТЕЛЬНО ПОТОМ УДАЛИТЬ!!!
class Profile2 extends StatelessWidget {

  const Profile2({super.key});

  @override
  Widget build(BuildContext context,) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    Image getImage(String url) {
      Image image = Image.network(url, errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace)
      {
        return Image.asset('images/icon.jpg',fit: BoxFit.cover);
      },
          fit: BoxFit.cover
      );
      return image;
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: height/15)),
              GestureDetector(
                onTap: (){
                  showModalBottomSheet(context: context, builder: (BuildContext context) => const Wrap1());
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: const Color.fromRGBO(16, 240, 12, 1.0),
                        width: width/100
                    ),
                  ),
                  height: width/2,
                  width: width/2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(360),
                    child: getImage("https://w.forfun.com/fetch/a9/a9cd07f219cf102dcda5ccff4acde0b5.jpeg"),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: height/40)),
              Text('Miaks', style: TextStyle(
                fontSize: height/29,
                fontFamily: 'Comfortaa',
                color: Colors.black,
              ),
              ),
              Padding(padding: EdgeInsets.only(top: height/40)),
              Text(
                'zasuherka2002@gmail.com',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: height/50,
                  fontFamily: 'Comfortaa',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        )
    );
  }
}