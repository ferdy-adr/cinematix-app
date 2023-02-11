part of 'models.dart';

class UserAccount extends Equatable {
  final String id, email;
  final int? balance;
  final String? name, profilePicture, selectedLanguage;
  final List<String>? selectedGenre;

  const UserAccount(this.id, this.email,
      {this.name,
      this.profilePicture,
      this.selectedGenre,
      this.selectedLanguage,
      this.balance});

  @override
  String toString() {
    return '[$id] - $name, $email';
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        profilePicture,
        selectedGenre,
        selectedLanguage,
        balance
      ];
}
