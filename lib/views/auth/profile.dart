import 'package:camel_trace/Helpers/const.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:profile_image_selector/profile_image_selector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Combonet/my_widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String userId = "",
      userName = "",
      userType = "",
      userPhone = "",
      userEmail = "";

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        userId = value.getString("userId") ?? "";
        userName = value.getString("userName") ?? "Guest";
        userType = value.getString("userType") ?? "Guest";
        userPhone = value.getString("userPhone") ?? "05xxx xxx";
        userEmail = value.getString("userEmail") ?? "someThing@gmail.com";
        nameController.text = userName;
        phoneController.text = userPhone;
        emailController.text = userEmail;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MyWidgets(context: context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightOrangeColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: whiteColor,
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: ProfileImageSelector(
                size: 72,
                icon: Icons.person,
                backgroundColor: Colors.black,
                iconColor: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            w.regularEditText(nameController, "owner name"),
            const SizedBox(height: 18),
            w.regularEditText(emailController, "email"),
            const SizedBox(height: 18),
            w.regularEditText(phoneController, "Phone number"),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: () {
                FirebaseDatabase.instance
                    .ref()
                    .child("users")
                    .child(userId)
                    .update({
                  "name": nameController.text,
                  "email": emailController.text,
                  "phone": phoneController.text,
                }).then((value) {
                  // FirebaseAuth.instance.currentUser?.updateEmail(emailController.text).onError((error, stackTrace) => w.showAlertDialog(context, error.toString(), () {
                  //   Navigator.of(context).pop();
                  // }));
                  SharedPreferences.getInstance().then((value) {
                    value.setString("userName", nameController.text);
                    value.setString("userPhone", phoneController.text);
                    value.setString("userEmail", emailController.text);
                  });
                  w.showAlertDialog(context, "data Saved :)", () {
                    Navigator.of(context).pop();
                  });
                }).onError((error, stackTrace) {
                  w.showAlertDialog(context, error.toString(), () {
                    Navigator.of(context).pop();
                  });
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: lightOrangeColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: Text(Cons.save),
            )
          ]),
        ),
      ),
    );
  }
}
