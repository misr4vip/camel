import 'package:camel_trace/Helpers/const.dart';
import 'package:camel_trace/Helpers/my_widgets.dart';
import 'package:camel_trace/modles/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../owner_main_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey =  GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var h = MyWidgets(context: context);
    return  Form(
        key: _formKey,
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "field is required";
                  }else if (value.length < 6) {
                    return "password length is less than 6 letter";
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return "field is required";
                  }else if (value.length < 6) {
                    return "password length is less than 6 letter";
                  }
                  return null;
                },
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
          h.addButton(Cons.signIn, () async{
            if(_formKey.currentState!.validate()){
                await FirebaseAuth.instance
                    .signInWithEmailAndPassword(email: userNameController.text, password: passwordController.text)
                    .then((value)  {
                      getUserData(value.user!.uid);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => const OwnerMain()));
                }).onError((error, stackTrace) => showAlert(error!.toString()));
            }
          }),
        ]),
      );
  }
   getUserData(String id) {
    FirebaseDatabase.instance.ref().child("users").child(id).get().then((value)  {
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


    }).onError((error, stackTrace){
      showAlert("error in getting data ${error.toString()}");
    });

  }
  showAlert(String message) {
    return showDialog(
      //if set to true allow to close popup by tapping out of the popup
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Information"),
        content: Text(message),
        elevation: 24,
      ),
    );
  }
}
