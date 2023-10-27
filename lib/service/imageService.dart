import 'package:app1/service/UserSirvice.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

///Выгрузка фотографии в FireBase + обращение к [downloadImage()]
///В слуае ошибки, а она может проозийти исключительно при остутствии интернета, мы будем использовать уже имеющуюся фотографию
///используя [loadImage()]
//TODO Обязательно допилить, чтобы вовсе нельзя было использовать при выключенном интернете
Future selectAndUploadImage() async {
  try{
    ///Выбор файла
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final File imageFile = File(image.path);
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      ///Сохранение фото в storage
      final Reference imageRef = FirebaseStorage.instance.ref().child('images/$fileName');
      final UploadTask uploadTask = imageRef.putFile(imageFile);
      final TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() => null);
      final String imageUrl = await storageTaskSnapshot.ref.getDownloadURL();

      final documentDirectory = await getApplicationDocumentsDirectory() ;
      File file = File('${documentDirectory.path}/avatar.jpg');
      file.writeAsBytesSync(await image.readAsBytes(), flush: true);
      localUser!.avatar = Image.file(file);

      localUser!.urlAvatar = imageUrl;
      localUser?.avatar = Image.file(imageFile);
      saveChanges();
    }
  }
  catch(e){
    await loadImage();
  }
}

///Используем для получения аватарки при включенном интернете.
///В случае какой-нибудь ошибки, а вероятнее всего только остутствие подключения, будет использован метод [loadImage()]
Future downloadImage() async {
  if(await isConnected()){
    if(localUser!.urlAvatar != null && localUser!.urlAvatar != 'null'){
      try{
        final http.Response response = await http.get(Uri.parse(localUser!.urlAvatar!));
        final documentDirectory = await getApplicationDocumentsDirectory() ;
        File file = File('${documentDirectory.path}/avatar.jpg');
        file.writeAsBytesSync(response.bodyBytes, flush: true);
        localUser!.avatar = Image.file(file);
      }
      catch(e){
        print(e.toString());
        loadImage();
      }
    }
    else{
      localUser!.avatar = null;
    }
  }
  else{
    print('Не прошли проверку на подключение');
    loadImage();
  }
}

///Используем для получения аватарки при выключенном интернете
Future loadImage() async {
  if(localUser!.urlAvatar != null){
    final documentDirectory = await getApplicationDocumentsDirectory();
    File file = File('${documentDirectory.path}/avatar.jpg');
    localUser!.avatar = Image.file(file);
  }
  else{
    localUser!.avatar = null;
  }
}

Future deleteImage() async {
  if(localUser!.urlAvatar != null && localUser!.avatar != null){
    localUser!.avatar = null;
    final documentDirectory = await getApplicationDocumentsDirectory();
    File file = File('${documentDirectory.path}/avatar.jpg');
    file.deleteSync();
    final FirebaseStorage imageRef = FirebaseStorage.instance;
    await imageRef.refFromURL(localUser!.urlAvatar!).delete().then((value) {
    })
        .catchError((error) {
      print('Ошибка при удалении файла: $error');
    });
    localUser!.urlAvatar = null;
    saveChanges();
  }
}

Future saveChanges() async {
  final DatabaseReference userRef = FirebaseDatabase.instance.ref("users/${localUser!.userId}");
  await userRef.update({
    "urlAvatar": localUser!.urlAvatar
  });
  await setUserInfo(localUser!);
}