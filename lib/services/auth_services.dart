part of 'services.dart';

class AuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignInSignUpResult> signUp(String email, String password,
      String name, List<String> selectedGenre, String selectedLanguage) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserAccount? user = credential.user?.convertToUserAccount(
          name: name,
          selectedGenre: selectedGenre,
          selectedLanguage: selectedLanguage);
      await UserAccountServices.updateUser(user!);

      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString());
    }
  }
}

class SignInSignUpResult {
  UserAccount? user;
  String? message;

  SignInSignUpResult({this.user, this.message});
}
