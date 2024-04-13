part of 'database.dart';

class _ImageData{

  Future<String> uploadImage(String fileName, File imageFile) async {

    final UploadTask uploadTask = _imageRef.child(fileName).putFile(imageFile);

    final TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() => null);

    final String imageUrl = await storageTaskSnapshot.ref.getDownloadURL();

    return imageUrl;
  }

  Future<http.Response> downloadImage(String imageUrl) async {
    try{
      final http.Response response = await http.get(Uri.parse(imageUrl));
      return response;
    }
    catch(_){
      rethrow;
    }
  }

  Future<void> saveChanges(String userId, String? imageUrl) async {
    await _usersRef.child(userId).update({
      "urlAvatar": imageUrl
    });
  }
}