import 'dart:async';

import 'package:app1/service/UserSirvice.dart';
import 'package:app1/service/imageService.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'user_image_event.dart';
part 'user_image_state.dart';

class UserImageBloc extends Bloc<UserImageEvent, UserImageState> {
  UserImageBloc() : super(UserImageInitial()) {
    on<SelectAndUploadImageEvent>(_onSelectAndUploadImage);
    on<LoadImageEvent>(_onLoadImage);
    on<DeleteImageEvent>(_onDeleteImage);
  }
  Future _onSelectAndUploadImage(SelectAndUploadImageEvent event, Emitter<UserImageState> emitter) async {
    await selectAndUploadImage();
    if (localUser!.avatar == null){
      emitter(UserImageErrorState('Изображение не выбрано'));
    }
    else{
      emitter(LoadImageState(localUser!.avatar!));
    }
  }

  Future _onLoadImage(LoadImageEvent event, Emitter<UserImageState> emitter) async {
    if (localUser!.avatar != null){
      emitter(LoadImageState(localUser!.avatar!));
    }
    else{
      emitter(UserImageErrorState('Изображение не найдено'));
    }
  }
  Future _onDeleteImage(DeleteImageEvent event, Emitter<UserImageState> emitter) async {
    await deleteImage();
    emitter(DeleteImageState());
  }
}
