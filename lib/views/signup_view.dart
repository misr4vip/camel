import 'package:camel_trace/Helpers/const.dart';
import 'package:camel_trace/Helpers/my_widgets.dart';
import 'package:flutter/material.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupState();
}

class _SignupState extends State<SignupView> {
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
            controller: userNameController,
            decoration: const InputDecoration(
              labelText: "owner name",
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: 5), // add padding to adjust icon
                child: Icon(Icons.person),
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
      Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: TextFormField(
            controller: userNameController,
            decoration: const InputDecoration(
              labelText: "confirm password",
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: 5), // add padding to adjust icon
                child: Icon(Icons.phone),
              ),
            ),
          )),
      const SizedBox(height: 18),
      h.addButton(Cons.signUp, () {}),
    ]);
  }
}
