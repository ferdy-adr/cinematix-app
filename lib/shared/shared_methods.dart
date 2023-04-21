part of 'shared.dart';

Future<File?> getImage() async {
  XFile? pickedFileImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  File? fileImage;

  if (pickedFileImage != null) {
    fileImage = File(pickedFileImage.path);
  }

  return fileImage;
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);

  Reference reference = FirebaseStorage.instance.ref().child(fileName);
  UploadTask task = reference.putFile(image);
  TaskSnapshot snapshot = await task;

  return await snapshot.ref.getDownloadURL();
}

Future<void> deleteImage(String imageURL) async {
  Reference reference = FirebaseStorage.instance.refFromURL(imageURL);
  await reference.delete();
}
