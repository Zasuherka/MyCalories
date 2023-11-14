import 'package:app1/bloc/userImage/user_image_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvatarWrap extends StatelessWidget {
  final bool avatarIsNotNull;
  const AvatarWrap({super.key, required this.avatarIsNotNull});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Wrap(
      children: [
        SizedBox(
          height: screenHeight/20,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Изменить фотографию',
                  style: TextStyle(
                    fontSize: screenHeight/55,
                    fontFamily: 'Comfortaa',
                    color: Colors.black,
                  ),
                )
              ],
            ),
            onTap: (){
              BlocProvider.of<UserImageBloc>(context).add(SelectAndUploadImageEvent());
              Navigator.pop(context);
            },
          ),
        ),
        avatarIsNotNull ? SizedBox(
          height: screenHeight/20,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Удалить фотографию',
                  style: TextStyle(
                    fontSize: screenHeight/55,
                    fontFamily: 'Comfortaa',
                    color: Colors.black,
                  ),
                )
              ],
            ),
            onTap: (){
              BlocProvider.of<UserImageBloc>(context).add(DeleteImageEvent());
              Navigator.pop(context);
            },
          ),
        ) : Container(),
        SizedBox(
          height: screenHeight/20,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Отмена',
                  style: TextStyle(
                    fontSize: screenHeight/55,
                    fontFamily: 'Comfortaa',
                    color: Colors.black,
                  ),
                )
              ],
            ),
            onTap: (){
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }
}
