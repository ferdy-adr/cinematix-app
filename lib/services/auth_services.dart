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
      return SignInSignUpResult(message: e.toString().split(']')[1]);
    }
  }

  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      UserAccount? user =
          await credential.user?.fromFirestore(credential.user!.uid);

      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(']')[1]);
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Stream<User?> userStream() => _auth.authStateChanges();
}

class SignInSignUpResult {
  UserAccount? user;
  String? message;

  SignInSignUpResult({this.user, this.message});
}
