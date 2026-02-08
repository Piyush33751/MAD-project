import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'classDatabase.dart';
import 'widget/homepage.dart';
import 'mapdatabse.dart';

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
    bool value = await Mapdatabse.buildingsorter();
    if (value == false) {
      const snackBar1 = SnackBar(
        content: Text(
          "Unavailable HDB Block Number",
          style: TextStyle(fontSize: 20),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.purple,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
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
              },
              child: Text("Select")),
        ])));
  }
}
