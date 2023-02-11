part of 'services.dart';

class UserAccountServices {
  static final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> updateUser(UserAccount user) async {
    _userCollection.doc(user.id).set({
      'email': user.email,
      'name': user.name,
      'balance': user.balance,
      'selectedGenre': user.selectedGenre,
      'selectedLanguage': user.selectedLanguage,
      'profilePicture': user.profilePicture ?? ""
    });
  }

  static Future<String> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();
    String jsonData = json.encode(snapshot.data());

    return jsonData;
  }
}
