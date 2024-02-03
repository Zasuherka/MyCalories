part of 'user_image_bloc.dart';

abstract class UserImageEvent {}

class SelectAndUploadImageEvent extends UserImageEvent {}

class LoadImageEvent extends UserImageEvent {}

class DeleteImageEvent extends UserImageEvent {}
