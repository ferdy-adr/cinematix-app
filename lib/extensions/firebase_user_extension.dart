part of 'extensions.dart';

extension FirebaseUserExtension on User {
  UserAccount convertToUserAccount(
          {String name = 'No Name',
          List<String> selectedGenre = const [],
          String selectedLanguage = 'English',
          int balance = 50000}) =>
      UserAccount(
        uid,
        email!,
        name: name,
        selectedGenre: selectedGenre,
        selectedLanguage: selectedLanguage,
        balance: balance,
      );

  Future<UserAccount> fromFirestore(String id) async {
    String jsonResult = await UserAccountServices.getUser(id);
    Map<String, dynamic> object = json.decode(jsonResult);

    return UserAccount(
      id,
      object['email'],
      name: object['name'],
      profilePicture: object['profilePicture'],
      selectedGenre:
          (object['selectedGenre'] as List).map((e) => e.toString()).toList(),
      selectedLanguage: object['selectedLanguage'],
      balance: object['balance'],
    );
  }
}
