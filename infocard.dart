import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class infocard extends StatelessWidget {
  const infocard({
    Key? key, required this.name, required this.blocknumber, 
  }) : super(key: key);
  
  final String name, blocknumber;

  @override 
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          CupertinoIcons.person,
          color: Colors.white,
        ),
      ),
      title: Text(name, style: const TextStyle(color: Colors.white)),
      subtitle: Text(
        blocknumber,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
