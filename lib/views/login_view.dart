import 'package:camel_trace/Helpers/const.dart';
import 'package:camel_trace/Helpers/my_widgets.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var h = MyWidgets(context: context);
    return Column(children: [
      Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: TextFormField(
            controller: userNameController,
            decoration: const InputDecoration(
              labelText: "Phone number",
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: 5), // add padding to adjust icon
                child: Icon(Icons.phone),
              ),
            ),
          )),
      const SizedBox(height: 18),
      Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: "password",
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: 5), // add padding to adjust icon
                child: Icon(Icons.lock),
              ),
            ),
          )),
      const SizedBox(
        height: 18,
      ),
      const Padding(
        padding: EdgeInsets.only(right: 0),
        child: TextButton(
            onPressed: null,
            child: Text(
              "forget password?",
              style: TextStyle(
                color: Color(0xff9D7A68),
                fontSize: 18,
              ),
            )),
      ),
      h.addButton(Cons.signIn, () {}),
    ]);
  }
}
