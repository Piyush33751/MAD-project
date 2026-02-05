import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hello_world/calender.dart';
import 'package:hello_world/widget/homepage.dart';
import 'firebase_options.dart';

import 'login/login.dart';

import 'login/register.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    BlocProvider(
      create: (_) => AppLocalizationBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLocalizationBloc, AppLocalizationState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'HDB App',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('zh'),
          ],
          locale: state.locale,
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: Login(),
          routes: {
            '/calender': (context) => const CalendarPage(),
            '/homemain': (context) => const HomePage(),
            '/login': (context) => Login(),
            '/register': (context) => RegisterPage(),
          },
        );
      },
    );
  }
}
