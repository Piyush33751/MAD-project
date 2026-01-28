import 'package:flutter/material.dart';
import 'classDatabase.dart';


class testing extends StatefulWidget {
  const testing({super.key});

  @override
  State<testing> createState() => _testingState();
}

class _testingState extends State<testing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:const Text("Testing")),

      body:Center(
        child:Row(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
             FilledButton(
              onPressed:()async{
                await Reports.checkstatus();
                Navigator.pushNamed(context, '/reportpage');
              }, 
              child:Text("Test for report")),

              const SizedBox(width:20),

              FilledButton(
              onPressed:()async{
                await Reports.checkstatus();
                Navigator.pushNamed(context,'/News');
              }, 
              child:Text("Test for News")),

              const SizedBox(width:20),
          ],
        ))
      
      );
  }
}