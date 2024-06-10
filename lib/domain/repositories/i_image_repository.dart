import 'dart:io';

abstract class IImageRepository {

  Future<File?> selectAndUploadImage();

  Future<File?> downloadImage();

  Future<File?> loadImage();

  Future deleteImage();

  Future<void> signOut();
}