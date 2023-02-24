part of 'models.dart';

class RegistrationData extends Equatable {
  final String name, email, password, selectedLanguage;
  final List<String> selectedGenre;
  final File? profilePicture;

  const RegistrationData({
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
