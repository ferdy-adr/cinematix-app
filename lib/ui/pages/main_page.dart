part of 'pages.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<UserBloc, UserState>(
              builder: (_, state) {
                return (state is UserLoaded)
                    ? Text(state.user.name.toString())
                    : const SizedBox();
              },
            ),
            ElevatedButton(
              onPressed: () async {
                await AuthServices.signOut().then(
                  (_) => BlocProvider.of<UserBloc>(context).add(SignOut()),
                );
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
