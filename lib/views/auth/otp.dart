import 'dart:async';

import 'package:camel_trace/Combonet/my_widget.dart';
import 'package:camel_trace/Helpers/const.dart';
import 'package:camel_trace/modles/UserModel.dart';
import 'package:camel_trace/views/owner_main_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Otp extends StatefulWidget {
  Otp({super.key, required this.model, required this.verificationId});
  UserModel model;
  String verificationId;
  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  int seconds = 120;
  late Timer _timer;
  bool _buttonEnabled = false;
  Color myColor = Colors.grey;
  @override
  void initState() {
    super.initState();
    // Start the timer when the screen is initialized
    startTimer();
  }

  void startTimer() {
    // Create a one-second periodic timer
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (seconds > 0) {
          setState(() {
            seconds--;
          });
        } else {
          // Stop the timer when the countdown reaches 0
          _timer.cancel();
          setState(() {
            // Toggle button enabled/disabled state
            _buttonEnabled = !_buttonEnabled;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the screen is disposed
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
              child: Text(
                "We send you a code to verify your mobile number",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
              child: Text(
                "Enter you OTP code here",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            OtpTextField(
              numberOfFields: 6,
              borderColor: const Color.fromARGB(255, 192, 99, 32),
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) async {
                AuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: verificationCode);
                await FirebaseAuth.instance
                    .signInWithCredential(credential)
                    .then((value) {
                  if (value.user != null) {
                    widget.model.id = value.user!.uid;
                    createUser(widget.model);
                  }
                }).then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OwnerMain()));
                }).onError((error, stackTrace) {
                  AlertDialog(
                    title: const Text("Error"),
                    content: Text(error.toString()),
                  );
                });
              }, // end onSubmit
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("$seconds to resend code"),
            )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MyWidgets(context: context).addButton("Resend", () {
                if (_buttonEnabled) {
                  _verifyPhoneNumber(context, widget.model.phone);
                } else {}
              }, backgroundColor: _buttonEnabled ? lightOrangeColor : myColor),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> createUser(UserModel user) async {
    var result = true;
    var ref = FirebaseDatabase.instance.ref().child("users").child(user.id);
    await ref.set(user.toJson()).then((value) async {
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

  Future<void> _verifyPhoneNumber(
      BuildContext context, String phoneNumber) async {
    var _auth = FirebaseAuth.instance;
    final phone = phoneNumber.substring(1);
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+966$phone",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure
          AlertDialog(
            title: const Text("Error"),
            content: Text(e.toString()),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          // Save the verification id to use it later
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out, handle the issue here
        },
      );
    } catch (e) {
      AlertDialog(
        title: const Text("Error"),
        content: Text(e.toString()),
      );
    }
  }
}
