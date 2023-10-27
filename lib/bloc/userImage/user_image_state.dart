part of 'user_image_bloc.dart';

@immutable
abstract class UserImageState {}

class UserImageInitial extends UserImageState {}

class UserEditingInfoState extends UserImageState {}

class LoadImageState extends UserImageState {
  final Image image;

  LoadImageState(this.image);
}

class UserImageErrorState extends UserImageState {
  final String error;

  UserImageErrorState(this.error);
}

class DeleteImageState extends UserImageState {}