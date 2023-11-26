import 'dart:async';
import 'dart:io';

import 'package:app1/service/UserSirvice.dart';
import 'package:app1/service/imageService.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'user_image_event.dart';
part 'user_image_state.dart';


///TODO после успешного получения изображения, отправить состояние, которое
///TODO сообщит о том, что изображение загружено во view и можно не обновлять состояние |
///TODO Сделать, чтобы не было кнопки удаления изображения, когда у юзера не аватарки
class UserImageBloc extends Bloc<UserImageEvent, UserImageState> {
  File? avatar;

  UserImageBloc() : super(UserImageInitial()) {
    on<SelectAndUploadImageEvent>(_onSelectAndUploadImage);
    on<LoadImageEvent>(_onLoadImage);
    on<DeleteImageEvent>(_onDeleteImage);
  }

  Future _onSelectAndUploadImage(SelectAndUploadImageEvent event, Emitter<UserImageState> emitter) async {
    emitter(UserImageNullState(''));
    File? newAvatar = await selectAndUploadImage();
    if (newAvatar == null){
      emitter(UserImageNullState('Изображение не выбрано'));
    }
    else{
      avatar = newAvatar;
      emitter(LoadImageState(newAvatar));
    }
  }

  Future _onLoadImage(LoadImageEvent event, Emitter<UserImageState> emitter) async {
    if(avatar == null){
      emitter(UserImageNullState('Изображение не найдено'));
      try{
        avatar = await downloadImage();
      }
      catch (error){
        emitter(UserImageNullState('Изображение не найдено'));
      }
      if (avatar != null){
        emitter(LoadImageState(avatar!));
      }
    }
    else{
      emitter(LoadImageState(avatar!));
    }
  }
  Future _onDeleteImage(DeleteImageEvent event, Emitter<UserImageState> emitter) async {
    await deleteImage();
    emitter(DeleteImageState());
  }
}
