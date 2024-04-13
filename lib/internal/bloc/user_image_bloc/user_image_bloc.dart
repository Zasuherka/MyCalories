import 'dart:async';
import 'dart:io';
import 'package:app1/data/repository/image_repository.dart';
import 'package:app1/data/repository/user_repository.dart';
import 'package:app1/domain/repository/i_image_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_image_event.dart';
part 'user_image_state.dart';
part 'user_image_bloc.freezed.dart';

///TODO после успешного получения изображения, отправить состояние, которое
///TODO сообщит о том, что изображение загружено во view и можно не обновлять состояние |
///TODO Сделать, чтобы не было кнопки удаления изображения, когда у юзера не аватарки
class UserImageBloc extends Bloc<UserImageEvent, UserImageState> {

  final IImageRepository _imageRepository = ImageRepository();

  File? avatar;

  UserImageBloc() : super(const UserImageState.initial()) {
    on<UserImageEvent>((event, emit) async {
      await event.when(
          selectAndUploadImage: () => _selectAndUploadImage(emit),
          loadImage: () => _loadImage(emit),
          deleteImage: () => _deleteImage(emit)
      );
    });
    UserRepository.controller.stream.listen((event) {
      if(event == null){
        avatar = null;
      }
    });
  }

  Future _selectAndUploadImage(Emitter<UserImageState> emitter) async {
    emitter(const UserImageState.loading());
    File? newAvatar = await _imageRepository.selectAndUploadImage();
    if (newAvatar == null) {
      emitter(const UserImageState.error(error: 'Изображение не выбрано'));
    } else {
      avatar = newAvatar;
      emitter(UserImageState.loadImage(image: newAvatar));
    }
  }

  Future _loadImage(Emitter<UserImageState> emitter) async {
    emitter(const UserImageState.loading());
    if (avatar == null) {
      emitter(const UserImageState.error(error: 'Изображение не найдено'));
      try {
        avatar = await _imageRepository.downloadImage();
      }
      catch (error) {
        emitter(const UserImageState.error(error: 'Изображение не найдено'));
      }
      if (avatar != null) {
        emitter(UserImageState.loadImage(image: avatar!));
      }
    }
    else {
      emitter(UserImageState.loadImage(image: avatar!));
    }
  }

  Future _deleteImage(Emitter<UserImageState> emitter) async {
    emitter(const UserImageState.loading());
    await _imageRepository.deleteImage();
    emitter(const UserImageState.deleteImage());
  }
}
