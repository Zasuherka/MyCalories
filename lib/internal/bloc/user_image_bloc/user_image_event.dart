part of 'user_image_bloc.dart';

@freezed
class UserImageEvent with _$UserImageEvent {
  const factory UserImageEvent.selectAndUploadImage() = _SelectAndUploadImage;
  const factory UserImageEvent.loadImage() = _LoadImageEvent;
  const factory UserImageEvent.deleteImage() = _DeleteImageEvent;
}

// abstract class UserImageEvent {}
//
// class SelectAndUploadImageEvent extends UserImageEvent {}
//
// class LoadImageEvent extends UserImageEvent {}
//
// class DeleteImageEvent extends UserImageEvent {}
