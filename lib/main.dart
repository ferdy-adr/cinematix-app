import 'package:cinematix/bloc/blocs.dart';
import 'package:cinematix/services/services.dart';
import 'package:cinematix/shared/shared.dart';
import 'package:cinematix/ui/pages/pages.dart';
import 'package:cinematix/extensions/extensions.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PageBloc()),
          BlocProvider(create: (_) => UserBloc()),
          BlocProvider(create: (_) => ThemeBloc()),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (_, themeState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeState.themeData,
              home: const Wrapper(),
            );
          },
        ),
      ),
    );
  }
}
