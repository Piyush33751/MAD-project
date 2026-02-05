import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:hello_world/classDatabase.dart';
import 'package:hello_world/widget/homepage.dart';
import 'package:hello_world/mapdatabse.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _hdbblocknumber = TextEditingController();
  void select() async {
    Reports.X = [];
    Reports.Z = [];
    Reports.G = [];
    Mapdatabse.X = {};
    Reports.loginbuild = _hdbblocknumber.text;
    Mapdatabse.loginbuild = _hdbblocknumber.text;
    await Reports.buildingsorter();
    await Mapdatabse.buildingsorter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Search Flats"),
          backgroundColor: Colors.red,
        ),
        body: Center(
            child: Column(children: [
          SizedBox(height: 20),
          TextField(
            controller: _hdbblocknumber,
            decoration: const InputDecoration(
              labelText: "HDB Block Number",
              prefixIcon: Icon(Icons.home),
            ),
          ),
          SizedBox(height: 20),
          FilledButton(
              onPressed: () {
                select();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: Text("Select")),
        ])));
  }
}
