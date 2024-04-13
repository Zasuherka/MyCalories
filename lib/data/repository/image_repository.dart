import 'dart:typed_data';
import 'package:app1/data/database/database.dart';
import 'package:app1/data/repository/user_repository.dart';
import 'package:app1/domain/repository/i_image_repository.dart';
import 'package:app1/domain/repository/i_user_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';


class ImageRepository implements IImageRepository {

  final IUserRepository _userRepository = UserRepository();
  final Database _database = Database();

  ///Выгрузка фотографии в FireBase + обращение к [downloadImage]
  ///В слуае ошибки, а она может проозийти исключительно при остутствии интернета, мы будем использовать уже имеющуюся фотографию
  ///используя [loadImage()]
//TODO Обязательно допилить, чтобы вовсе нельзя было использовать при выключенном интернете
  @override
  Future<File?> selectAndUploadImage() async {

    final localUser = _userRepository.localUser;

    if(localUser == null){
      throw 'localUser равен нулю';
    }

    try{
      ///Выбор файла
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final File imageFile = await _cropImage(image);
        final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final String imageUrl = await _database
            .imageData.uploadImage(fileName, imageFile);
        localUser.avatar = imageFile;
        localUser.urlAvatar = imageUrl;
        _userRepository.setAvatar(imageUrl, imageFile);
        _saveChanges();
      }
    }
    catch(e){
      print('Error: ${e.toString()}');
    }
    return localUser.avatar;
  }

  ///Используем для получения аватарки при включенном интернете.
  ///В случае какой-нибудь ошибки, а вероятнее всего только остутствие подключения, будет использован метод [loadImage()]
  @override
  Future<File?> downloadImage() async {

    final localUser = _userRepository.localUser;

    if(localUser == null){
      throw 'localUser равен нулю';
    }

    if(await _userRepository.isConnected()){
      if(localUser.urlAvatar != null && localUser.urlAvatar != 'null'){
        try{
          final http.Response response = await _database
              .imageData.downloadImage(localUser.urlAvatar!);
          final documentDirectory = await getApplicationDocumentsDirectory() ;
          File file = File('${documentDirectory.path}/avatar.jpg');
          file.writeAsBytesSync(response.bodyBytes, flush: true);
          localUser.avatar = file;
          _userRepository.setAvatar(localUser.urlAvatar, file);
        }
        catch(error){
          return loadImage();
        }
      }
      else{
        localUser.avatar = null;
        _userRepository.setAvatar(localUser.urlAvatar, null);
      }
    }
    else{
      return loadImage();
    }
    return localUser.avatar;
  }

  ///Используем для получения аватарки при выключенном интернете
  @override
  Future<File?> loadImage() async {

    final localUser = _userRepository.localUser;

    if(localUser == null){
      throw 'localUser равен нулю';
    }
    
    if(localUser.urlAvatar != null && localUser.urlAvatar != 'null'){
      final documentDirectory = await getApplicationDocumentsDirectory();
      File file = File('${documentDirectory.path}/avatar.jpg');
      localUser.avatar = file;
    }
    else{
      localUser.avatar = null;
    }
    _userRepository.setAvatar(localUser.urlAvatar, localUser.avatar);
    return localUser.avatar;
  }

  @override
  Future deleteImage() async {

    final localUser = _userRepository.localUser;

    if(localUser == null){
      throw 'localUser равен нулю';
    }

    if(localUser.urlAvatar != null && localUser.avatar != null){
      final documentDirectory = await getApplicationDocumentsDirectory();
      File file = File('${documentDirectory.path}/avatar.jpg');
      file.deleteSync();
      final FirebaseStorage imageRef = FirebaseStorage.instance;
      try{
        await imageRef.refFromURL(localUser.urlAvatar!).delete();
      }
      catch(_){
        rethrow;
      }
      _userRepository.setAvatar(null,null);
      _saveChanges();
    }
  }

  Future<void> _saveChanges() async {

    final localUser = _userRepository.localUser;

    if(localUser == null){
      throw 'localUser равен нулю';
    }
    await _database.imageData.saveChanges(localUser.userId, localUser.urlAvatar);
  }

  Future<File> _cropImage(XFile file) async {
    final File imageFile = File(file.path.toString());
    var decodedImage = await decodeImageFromList(imageFile.readAsBytesSync());
    final int maxSize = decodedImage.width > decodedImage.height ? decodedImage.width : decodedImage.height;

    final documentDirectory = await getApplicationDocumentsDirectory() ;
    final Uint8List resultImage = await FlutterImageCompress.compressWithList(
        await file.readAsBytes(),
        minHeight: decodedImage.height.toInt(),
        minWidth: decodedImage.width.toInt(),
        quality: (100 * 1000/maxSize).round()
    );

    final File compressedFile = File('${documentDirectory.path}/avatar.jpg');
    await compressedFile.writeAsBytes(resultImage);
    return compressedFile;
  }


  @override
  Future<void> signOut() async{
    final localUser = _userRepository.localUser;
    if(localUser != null && localUser.avatar != null){
      final documentDirectory = await getApplicationDocumentsDirectory();
      File file = File('${documentDirectory.path}/avatar.jpg');
      await file.delete();
      print('Удалил');
    }
  }
}