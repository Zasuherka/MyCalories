import 'package:app1/internal/bloc/user_image_bloc/user_image_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvatarWrap extends StatelessWidget {
  final bool avatarIsNotNull;
  const AvatarWrap({super.key, required this.avatarIsNotNull});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SizedBox(
          height: screenHeight/20,
          child: ListTile(
            title: const Text('Изменить фотографию', textAlign: TextAlign.center),

              onTap: (){
              BlocProvider.of<UserImageBloc>(context).add(const UserImageEvent.selectAndUploadImage());
              Navigator.pop(context);
            },
          ),
        ),
        avatarIsNotNull ? SizedBox(
          height: screenHeight/20,
          child: ListTile(
            leadingAndTrailingTextStyle: Theme.of(context).listTileTheme.leadingAndTrailingTextStyle,
            title: const Text('Удалить фотографию', textAlign: TextAlign.center),
            onTap: (){
              BlocProvider.of<UserImageBloc>(context).add(const UserImageEvent.deleteImage());
              Navigator.pop(context);
            },
          ),
        ) : const SizedBox(),
        SizedBox(
          height: screenHeight/20,
          child: ListTile(
            title: const Text('Отмена', textAlign: TextAlign.center),
            onTap: (){
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }
}
