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
}
