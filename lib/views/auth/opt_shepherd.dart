import 'dart:async';

import 'package:camel_trace/Combonet/my_widget.dart';
import 'package:camel_trace/Helpers/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpShephered extends StatefulWidget {
  OtpShephered({super.key, required this.credId});
  var credId;
  @override
  State<OtpShephered> createState() => _OtpShepheredState();
}

class _OtpShepheredState extends State<OtpShephered> {
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
      body: Container(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
              child: Text(
                " ",
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
              onSubmit: (String verificationCode) async {}, // end onSubmit
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
                } else {}
              }, backgroundColor: _buttonEnabled ? lightOrangeColor : myColor),
            ),
          ],
        ),
      ),
    );
  }
}
