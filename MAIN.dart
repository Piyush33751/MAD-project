import 'package:flutter/material.dart';
import 'package:hello_world/calender.dart';
import 'package:hello_world/widget/homepage.dart';
import 'package:hello_world/login.dart';
import 'package:hello_world/widget/sidemenu.dart';
import 'package:hello_world/entry_point.dart';
import 'report.dart';
import 'reportsDisplay.dart';
import 'map.dart';
import 'news.dart';
import 'register.dart';
import 'report.dart';
import 'reportsDisplay.dart';
import 'map.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'search.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MaterialApp(home: const Login(), routes: {
    '/calender': (context) => const CalendarPage(),
    '/homemain': (context) => const HomePage(),
    '/login': (context) => const Login(),
    '/homepage': (context) => const RegisterPage(),
    '/reportdislaypage':(context) => const reportDipslay(),
    '/reportpage':(context) => const report(),
    '/map' :(context)=> const MyMap(),
    '/News':(context)=> const News(),
    '/search':(context)=> const Search(),
  }));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HDB App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEEF1F8),
        primarySwatch: Colors.blue,
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
      home: const EntryPoint(),
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
