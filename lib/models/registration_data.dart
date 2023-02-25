part of 'models.dart';

// ignore: must_be_immutable
class RegistrationData extends Equatable {
  final String name, email, password, selectedLanguage;
  final List<String> selectedGenre;
  File? profilePicture;

  RegistrationData({
    this.name = '',
    this.email = '',
    this.password = '',
    this.selectedGenre = const [],
    this.selectedLanguage = '',
    this.profilePicture,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        selectedGenre,
        selectedLanguage,
        profilePicture,
      ];
}
