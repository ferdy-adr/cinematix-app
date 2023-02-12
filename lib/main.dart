import 'package:cinematix/services/services.dart';
import 'package:cinematix/ui/pages/pages.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.userStream(),
      initialData: null,
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
