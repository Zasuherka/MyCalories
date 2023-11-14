part of 'user_image_bloc.dart';

@immutable
abstract class UserImageState {}

class UserImageInitial extends UserImageState {}

class UserEditingInfoState extends UserImageState {}

class LoadImageState extends UserImageState {
  final File image;

  LoadImageState(this.image);
}

class UserImageNullState extends UserImageState {
  final String error;

  UserImageNullState(this.error);
}

class DeleteImageState extends UserImageState {}