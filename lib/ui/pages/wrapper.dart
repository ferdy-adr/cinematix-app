part of 'pages.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    User? userData = Provider.of<User?>(context);

    return (userData == null)
        ? const SignInPage()
        : MainPage(userId: userData.uid);
  }
}
