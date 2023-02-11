part of 'services.dart';

class UserAccountServices {
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static Future<void> updateUser(UserAccount user) async {
    users.doc(user.id).set({
      'email': user.email,
      'name': user.name,
      'balance': user.balance,
      'selectedGenre': user.selectedGenre,
      'selectedLanguage': user.selectedLanguage,
      'profilePicture': user.profilePicture ?? ""
    });
  }
}
