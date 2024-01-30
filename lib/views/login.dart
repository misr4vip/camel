import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Email"),
              ),
              ElevatedButton(onPressed: () {}, child: Text("Log in")),
              TextButton(onPressed: () {}, child: Text("Create an account"))
            ],
          ),
        ),
      ),
    );
  }
}
