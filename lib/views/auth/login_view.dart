import 'package:camel_trace/Helpers/const.dart';
import 'package:camel_trace/modles/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Combonet/my_widget.dart';
import '../owner_main_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var w = MyWidgets(context: context);
    return Form(
      key: _formKey,
      child: Column(children: [
        w.regularEditText(userNameController, "Phone number",
            icon: Icons.phone),
        const SizedBox(height: 18),
        w.regularEditText(passwordController, "password",
            icon: Icons.password, isObscure: true),
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
        w.addButton(Cons.signIn, () async {
          if (_formKey.currentState!.validate()) {
            await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: userNameController.text,
                    password: passwordController.text)
                .then((value) {
              getUserData(value.user!.uid, context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const OwnerMain()));
            }).onError((error, stackTrace) {
              w.showAlertDialog(context, error.toString(), () {
                Navigator.of(context).pop();
              });
            });
          }
        }),
      ]),
    );
  }

  getUserData(String id, BuildContext context) {
    var w = MyWidgets(context: context);
    FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(id)
        .get()
        .then((value) {
      var object = value.value as Map;
      var user = UserModel.fromJson(object);

      SharedPreferences.getInstance().then((value) {
        value.setString("userId", user.id);
        value.setString("userName", user.name);
        value.setString("userType", user.userType);
        value.setString("userPassword", user.password);
        value.setString("userPhone", user.phone);
        value.setString("userEmail", user.email);
      });
    }).onError((error, stackTrace) {
      w.showAlertDialog(context, error.toString(), () {
        Navigator.of(context).pop();
      });
    });
  }
}
