part of 'pages.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    User? firebaseUser = Provider.of<User?>(context);

    if (firebaseUser == null) {
      if (prevPageEvent is! GoToSplashPage) {
        BlocProvider.of<PageBloc>(context).add(GoToSplashPage());
      }
    } else {
      if (prevPageEvent is! GoToMainPage) {
        BlocProvider.of<PageBloc>(context).add(GoToMainPage());
      }
    }

    return BlocBuilder<PageBloc, PageState>(
      builder: (_, state) {
        return (state is OnSplashPage)
            ? const SplashPage()
            : (state is OnSignInPage)
                ? const SignInPage()
                : MainPage(userId: firebaseUser?.uid);
      },
    );
  }
}
