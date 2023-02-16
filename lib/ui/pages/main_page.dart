part of 'pages.dart';

class MainPage extends StatelessWidget {
  final String? userId;
  const MainPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(userId ?? 'User data is empty'),
            ElevatedButton(
              onPressed: () async {
                await AuthServices.signOut();
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
