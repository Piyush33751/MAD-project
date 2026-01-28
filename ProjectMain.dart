import 'package:flutter/material.dart';
import 'news.dart';
import 'testing.dart';
import 'report.dart';
import 'reportsDisplay.dart';
import 'map.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main ()async{

  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(MaterialApp(home:const testing(),


  routes: {
    '/reportdislaypage':(context) => const reportDipslay(),
    '/reportpage':(context) => const report(),
    '/map' :(context)=> const MyMap(),
    '/News':(context)=> const News(),

  },
  
  ));
}