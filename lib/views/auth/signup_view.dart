import 'package:camel_trace/Helpers/const.dart';
import 'package:camel_trace/modles/UserModel.dart';
import 'package:camel_trace/views/owner_main_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Combonet/mywedjet.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupState();
}

class _SignupState extends State<SignupView> {
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var rePasswordController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var h = MyWidgets(context: context);
    return Form(
      key: _formKey,
      child: Column(children: [
       h.regularEditText(emailController, "email"),
        const SizedBox(height: 18),
      h.regularEditText(phoneController, "Phone number"),
        const SizedBox(height: 18),
        h.regularEditText(nameController, "owner name"),
        const SizedBox(height: 18),
       h.regularEditText(passwordController, "password"),
        const SizedBox(
          height: 18,
        ),
       h.regularEditText(rePasswordController, "confirm password"),
        const SizedBox(height: 18),
        h.addButton(Cons.signUp, () {
          f().then((value) => {
            createUser(value[true]).then((value)  {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const OwnerMain()));
            }).onError((error, stackTrace) {
              h.showAlertDialog(context, error.toString(), () {
                Navigator.of(context).pop();
              });
            })
          }).onError((error, stackTrace) =>  h.showAlertDialog(context, error.toString(), () {
            Navigator.of(context).pop();
          }));
        }),
      ]),
    );
  }

  Future f() async {
    var result = <bool, dynamic>{};
    if (_formKey.currentState!.validate()) {
      var user = UserModel(
          id: "",
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          userType: "owner",
          password: passwordController.text);
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value)
              {
                user.id = value.user!.uid;
                result.putIfAbsent(true, () => user);
              })
          .onError((error, stackTrace)
              {
                result.putIfAbsent(false, () => error!.toString());
              });
    } else {
      result.putIfAbsent(false, () => "error in Form State");
    }
    return result;
  }

  Future<bool> createUser(UserModel user) async {
    var result = true;
    var ref = FirebaseDatabase.instance.ref().child("users").child(user.id);
    await ref.set(user.toJson()).then((value)  async {
        final prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", user.id);
    await prefs.setString("userName", user.name);
    await prefs.setString("userType", user.userType);
    await prefs.setString("userPassword", user.password);
    await prefs.setString("userPhone", user.phone);
    await prefs.setString("userEmail", user.email);
        });
    return result;
  }


}

// await FirebaseAuth.instance.verifyPhoneNumber(
//   phoneNumber: phoneController.text,
//   verificationCompleted: (PhoneAuthCredential credential) {},
//   verificationFailed: (FirebaseAuthException e) {},
//   codeSent: (String verificationId, int? resendToken) {},
//   codeAutoRetrievalTimeout: (String verificationId) {},
// );
