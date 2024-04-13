part of 'user_image_bloc.dart';

@freezed
class UserImageState with _$UserImageState {
  const factory UserImageState.initial() = _Initial;
  const factory UserImageState.loading() = _Loading;
  const factory UserImageState.loadImage({
    required File image
  }) = _LoadImageState;
  const factory UserImageState.error({
    required String error
  }) = _Error;
  const factory UserImageState.deleteImage() = _DeleteImageState;
}

// @immutable
// abstract class UserImageState {}
//
// class UserImageInitial extends UserImageState {}
//
// class UserEditingInfoState extends UserImageState {}
//
// class Loading extends UserImageState {}
//
// class LoadImageState extends UserImageState {
//   final File image;
//
//   LoadImageState(this.image);
// }
//
// class UserImageErrorState extends UserImageState {
//   final String error;
//
//   UserImageErrorState(this.error);
// }
//
// class DeleteImageState extends UserImageState {}