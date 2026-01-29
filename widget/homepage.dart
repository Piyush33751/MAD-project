import 'package:flutter/material.dart';
import 'package:hello_world/map.dart';
import 'package:hello_world/widget/sidemenu.dart';
import 'package:hello_world/entry_point.dart';
import 'package:hello_world/calender.dart';
import 'package:hello_world/classDatabase.dart';
import 'package:hello_world/report.dart';

class HdbApp extends StatelessWidget {
  const HdbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile HDB App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile HDB'),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: const Sidemenu(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Welcome to HDB App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 1,
              children: [
                _serviceTile(
                  context,
                  Icons.calendar_today,
                  'Calendar',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CalendarPage(),
                      ),
                    );
                  },
                ),
                _serviceTile(context, Icons.report, 'Reports', () {
                  Reports.checkstatus();
                  Navigator.pushNamed(context,'/reportpage');
                }),
                _serviceTile(context, Icons.map, 'HDB Map', () {
                  Navigator.pushNamed(context,'/map');
                }),
                _serviceTile(context, Icons.search, 'Search Flats', () {}),
                _serviceTile(context, Icons.newspaper, 'News', () {
                     Reports.checkstatus();
                    Navigator.pushNamed(context,'/News');
                }),
                _serviceTile(context, Icons.support_agent, 'Ask HDB', () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _serviceTile(
    BuildContext context,
    IconData icons,
    String details,
    VoidCallback onTap,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icons, size: 50, color: Colors.red),
              const SizedBox(height: 8),
              Text(
                details,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
