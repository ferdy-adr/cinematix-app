part of 'pages.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            BlocProvider.of<PageBloc>(context).add(GoToSignInPage());
          },
          child: const Text('To Sign In Page'),
        ),
      ),
    );
  }
}
