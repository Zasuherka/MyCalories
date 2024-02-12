import 'dart:typed_data';

import 'package:app1/service/user_sirvice.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';




class ImageService{

  final UserService _userService = UserService();

  ///Выгрузка фотографии в FireBase + обращение к [downloadImage]
  ///В слуае ошибки, а она может проозийти исключительно при остутствии интернета, мы будем использовать уже имеющуюся фотографию
  ///используя [loadImage()]
//TODO Обязательно допилить, чтобы вовсе нельзя было использовать при выключенном интернете
  Future<File?> selectAndUploadImage() async {

    final localUser = _userService.localUser;

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
        final Reference imageRef = FirebaseStorage.instance.ref().child('images/$fileName');
        final UploadTask uploadTask = imageRef.putFile(imageFile);
        final TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() => null);
        final String imageUrl = await storageTaskSnapshot.ref.getDownloadURL();
        localUser.avatar = imageFile;
        localUser.urlAvatar = imageUrl;
        _userService.setAvatar(imageUrl, imageFile);
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
  Future<File?> downloadImage() async {

    final localUser = _userService.localUser;

    if(localUser == null){
      throw 'localUser равен нулю';
    }
    if(await _userService.isConnected()){
      if(localUser.urlAvatar != null && localUser.urlAvatar != 'null'){
        try{
          final http.Response response = await http.get(Uri.parse(localUser.urlAvatar!));
          final documentDirectory = await getApplicationDocumentsDirectory() ;
          File file = File('${documentDirectory.path}/avatar.jpg');
          file.writeAsBytesSync(response.bodyBytes, flush: true);
          localUser.avatar = file;
          _userService.setAvatar(localUser.urlAvatar, file);
        }
        catch(error){
          return loadImage();
        }
      }
      else{
        localUser.avatar = null;
        _userService.setAvatar(localUser.urlAvatar, null);
      }
    }
    else{
      return loadImage();
    }
    return localUser.avatar;
  }

  ///Используем для получения аватарки при выключенном интернете
  Future<File?> loadImage() async {

    final localUser = _userService.localUser;

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
    _userService.setAvatar(localUser.urlAvatar, localUser.avatar);
    return localUser.avatar;
  }

  Future deleteImage() async {

    final localUser = _userService.localUser;

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
      _userService.setAvatar(null,null);
      _saveChanges();
    }
  }

  Future _saveChanges() async {

    final localUser = _userService.localUser;

    if(localUser == null){
      throw 'localUser равен нулю';
    }

    final DatabaseReference userRef = FirebaseDatabase.instance.ref("users/${localUser.userId}");
    await userRef.update({
      "urlAvatar": localUser.urlAvatar
    });
    await _userService.setUserInfo(localUser);
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


  Future signOut() async{
    final localUser = _userService.localUser;
    if(localUser != null && localUser.avatar != null){
      final documentDirectory = await getApplicationDocumentsDirectory();
      File file = File('${documentDirectory.path}/avatar.jpg');
      await file.delete();
    }
  }
}