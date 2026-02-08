import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'calender.dart';
import 'widget/homepage.dart';
import 'login/login.dart';
import 'login/register.dart';
import 'widget/sidemenu.dart';
import 'entry_point.dart';
import 'report.dart';
import 'reportsDisplay.dart';
import 'map.dart';
import 'news.dart';
import 'search.dart';
import 'firebase_options.dart';
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
            scaffoldBackgroundColor: const Color(0xFFEEF1F8),
            primarySwatch: Colors.red,
            fontFamily: "Intel",
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              errorStyle: TextStyle(height: 0),
              border: defaultInputBorder,
              enabledBorder: defaultInputBorder,
              focusedBorder: defaultInputBorder,
              errorBorder: defaultInputBorder,
            ),
          ),
          home: Login(),
          routes: {
            '/calender': (context) => const CalendarPage(),
            '/homemain': (context) => const HomePage(),
            '/login': (context) => Login(),
            '/register': (context) => RegisterPage(),
            '/homepage': (context) => RegisterPage(),
            '/reportdislaypage': (context) => const reportDipslay(),
            '/reportpage': (context) => const report(),
            '/map': (context) => const MyMap(),
            '/News': (context) => const News(),
            '/search': (context) => const Search(),
          },
        );
      },
    );
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);
