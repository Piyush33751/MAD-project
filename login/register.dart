import 'package:flutter/material.dart';
import 'package:hello_world/userdataservice.dart';

void main() {
  runApp(MaterialApp(home: RegisterPage()));
}

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final name = TextEditingController();
  final email = TextEditingController();
  final pw = TextEditingController();
  final confirmPw = TextEditingController();
  final nric = TextEditingController();
  final blockno = TextEditingController();

  void checkdetails() {
    if (name.text.isEmpty) {
      alert("Please enter your name");
      return;
    }
    if (email.text.isEmpty) {
      alert("Please enter your email");
      return;
    }
    if (pw.text.isEmpty) {
      alert("Please enter your Password");
      return;
    }
    if (confirmPw.text != pw.text) {
      alert("Passwords do not match");
      return;
    }
    if (confirmPw.text.isEmpty) {
      alert("Please enter your Password Again");
      return;
    }
    if (nric.text.isEmpty) {
      alert("Please enter your NRIC number");
      return;
    }
    if (blockno.text.isEmpty) {
      alert("Please enter your block number");
      return;
    }

    UserDataService.addUser(
      name.text,
      email.text,
      confirmPw.text,
      nric.text,
      blockno.text,
    );
    alert("Registration Success!");
    Navigator.pop(context);
  }

  void alert(String alert) {
    final snackBar = SnackBar(
      content: Text(
        alert,
      ),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Create Account", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            TextField(
              controller: name,
              decoration: InputDecoration(labelText: "Full Name"),
            ),
            TextField(
              controller: email,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: pw,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            TextField(
              controller: confirmPw,
              decoration: InputDecoration(labelText: "Confirm Password"),
              obscureText: true,
            ),
            TextField(
              controller: nric,
              decoration: InputDecoration(labelText: "NRIC Number"),
            ),
            TextField(
              controller: blockno,
              decoration: InputDecoration(labelText: "HDB Block Number"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: checkdetails,
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
