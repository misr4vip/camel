import 'package:camel_trace/Helpers/const.dart';
import 'package:camel_trace/Helpers/my_widgets.dart';
import 'package:camel_trace/modles/UserModel.dart';
import 'package:camel_trace/views/owner_main_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty || value.length < 6) {
                  return "Phone number must be at least 12 characters long";
                }
                // else if (!RegExp(
                //         "^[+]?[(]?[0-9]{1,4}[)]?[ -]?[0-9]{1,6}[ ]?[0-9]{1,6}")
                //     .hasMatch(value)) {
                //   return "Invalid format of the phone number";
                // }
                return null;
              },
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "email",
                prefixIcon: Padding(
                  padding:
                      EdgeInsets.only(top: 5), // add padding to adjust icon
                  child: Icon(Icons.email_outlined),
                ),
              ),
            )),
        const SizedBox(height: 18),
        Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty || value.length < 6) {
                  return "Phone number must be at least 12 characters long";
                }
                // else if (!RegExp(
                //         "^[+]?[(]?[0-9]{1,4}[)]?[ -]?[0-9]{1,6}[ ]?[0-9]{1,6}")
                //     .hasMatch(value)) {
                //   return "Invalid format of the phone number";
                // }
                return null;
              },
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: "Phone number",
                prefixIcon: Padding(
                  padding:
                      EdgeInsets.only(top: 5), // add padding to adjust icon
                  child: Icon(Icons.phone),
                ),
              ),
            )),
        const SizedBox(height: 18),
        Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty || value.length < 3) {
                  return "name should at least  have 3 letters.";
                }
                return null;
              },
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "owner name",
                prefixIcon: Padding(
                  padding:
                      EdgeInsets.only(top: 5), // add padding to adjust icon
                  child: Icon(Icons.person),
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
                } else if (value.length < 6) {
                  return "password length is less than 6 letter";
                }
                return null;
              },
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "password",
                prefixIcon: Padding(
                  padding:
                      EdgeInsets.only(top: 5), // add padding to adjust icon
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
              validator: (value) {
                if (value!.isEmpty) {
                  return "field is required";
                } else if (value.length < 6) {
                  return "password length is less than 6 letter";
                }
                return null;
              },
              obscureText: true,
              controller: rePasswordController,
              decoration: const InputDecoration(
                labelText: "confirm password",
                prefixIcon: Padding(
                  padding:
                      EdgeInsets.only(top: 5), // add padding to adjust icon
                  child: Icon(Icons.password_outlined),
                ),
              ),
            )),
        const SizedBox(height: 18),
        h.addButton(Cons.signUp, () {
          f().then((value) => {
            createUser(value[true]).then((value) => {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const OwnerMain()))
            }).onError((error, stackTrace) => showAlert(error.toString()))
          }).onError((error, stackTrace) => showAlert(error.toString()));
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

// await FirebaseAuth.instance.verifyPhoneNumber(
//   phoneNumber: phoneController.text,
//   verificationCompleted: (PhoneAuthCredential credential) {},
//   verificationFailed: (FirebaseAuthException e) {},
//   codeSent: (String verificationId, int? resendToken) {},
//   codeAutoRetrievalTimeout: (String verificationId) {},
// );
