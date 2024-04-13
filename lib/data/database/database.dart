import 'dart:async';
import 'dart:io';

import 'package:app1/data/dto/collection/collection_dto.dart';
import 'package:app1/data/dto/create_food/food_dto.dart';
import 'package:app1/domain/enums/authorization_status.dart';
import 'package:app1/domain/enums/registration_status.dart';
import 'package:app1/domain/model/collection.dart';
import 'package:app1/domain/model/collection_view.dart';
import 'package:app1/domain/model/eating_food.dart';
import 'package:app1/domain/model/food.dart';
import 'package:app1/domain/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

part 'collection_data.dart';
part 'user_data.dart';
part 'food_data.dart';
part 'image_data.dart';

final _usersRef = FirebaseDatabase.instance.ref('users');
final _foodsRef = FirebaseDatabase.instance.ref('foods');
final _collectionsRef = FirebaseDatabase.instance.ref('collections');
final _imageRef = FirebaseStorage.instance.ref('images');

class Database{
  final collectionData = _CollectionData();
  final foodData = _FoodData();
  final userData = _UserData();
  final imageData = _ImageData();
}