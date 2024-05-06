import 'dart:async';
import 'package:camel_trace/Combonet/my_widget.dart';
import 'package:camel_trace/Helpers/validation.dart';
import 'package:camel_trace/modles/UserModel.dart';
import 'package:camel_trace/views/shepherds/shepherd_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../Helpers/const.dart';

class AddShepherd extends StatefulWidget {
  const AddShepherd({super.key});

  @override
  State<AddShepherd> createState() => _AddShepherdState();
}

class _AddShepherdState extends State<AddShepherd> {
  var ownerId = "";
  var nameController = TextEditingController();
  var idController = TextEditingController();
  var numberOfCamelsController = TextEditingController();
  var mobileController = TextEditingController();
  var isOtpAppeard = false;
  String myCredId = "";
  late UserModel model;
  int seconds = 120;
  late Timer _timer;
  bool _buttonEnabled = false;
  Color myColor = Colors.grey;
  @override
  void initState() {
    startTimer();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        ownerId = value.getString("userId") ?? "";
      });
    });
    super.initState();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (seconds > 0) {
          setState(() {
            seconds--;
          });
        } else {
          _timer.cancel();
          setState(() {
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
    var w = MyWidgets(context: context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(children: [
        Positioned.fill(
            left: 0.0,
            bottom: -30,
            child: Container(
              alignment: Alignment.topCenter,
              color: lightOrangeColor,
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: w.addTitleTextView("Add New Shepherd",
                    color: dark2OrangeColor),
              ),
            )),
        isOtpAppeard
            ? Positioned.fill(
                top: 200,
                child: SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.topCenter,
                    color: whiteColor,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Container(
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
                              borderColor:
                                  const Color.fromARGB(255, 192, 99, 32),

                              showFieldAsBox: true,

                              onCodeChanged: (String code) {},

                              onSubmit: (String verificationCode) async {
                                AuthCredential credential =
                                    PhoneAuthProvider.credential(
                                        verificationId: myCredId,
                                        smsCode: verificationCode);

                                await FirebaseAuth.instance.signOut();
                                await FirebaseAuth.instance
                                    .signInWithCredential(credential);

                                await FirebaseDatabase.instance
                                    .ref()
                                    .child("users")
                                    .child(model.id)
                                    .set(model.toJson())
                                    .then((value) {
                                  w.showAlertDialog(
                                      context, "shepherd added successfully!",
                                      () {
                                    // Navigator.of(context).pop();
                                    nameController.text = "";
                                    idController.text = "";
                                    numberOfCamelsController.text = "";
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ShepherdList()));
                                  });
                                }).onError((error, stackTrace) {
                                  w.showAlertDialog(context, error.toString(),
                                      () {
                                    Navigator.of(context).pop();
                                  });
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
                              child: MyWidgets(context: context).addButton(
                                  "Resend", () {
                                if (_buttonEnabled) {
                                } else {}
                              },
                                  backgroundColor: _buttonEnabled
                                      ? lightOrangeColor
                                      : myColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ))
            : Positioned.fill(
                top: 200,
                child: Container(
                  decoration: const BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const SizedBox(height: 40),
                          w.regularEditText(nameController, "shepherd name",
                              icon: Icons.person),
                          const SizedBox(height: 18),
                          w.regularEditText(
                              idController, "shepherd Identity number",
                              icon: Icons.note),
                          const SizedBox(height: 18),
                          w.regularEditText(mobileController, "shepherd mobile",
                              icon: Icons.numbers),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              var phone =
                                  "+966${mobileController.text.substring(1)}";
                              var shepherdId = const Uuid().v1();
                              final hashed = hashPassword(idController.text);

                              model = UserModel(
                                id: shepherdId,
                                name: nameController.text,
                                email: "",
                                identityId: idController.text,
                                userType: "shepherd",
                                phone: phone,
                                password: hashed,
                                ownerId: ownerId,
                              );
                              FirebaseAuth.instance
                                  .verifyPhoneNumber(
                                      phoneNumber: phone,
                                      verificationCompleted:
                                          (PhoneAuthCredential credential) {},
                                      verificationFailed:
                                          (FirebaseAuthException e) {},
                                      codeSent: (reId, retoken) {
                                        setState(() {
                                          myCredId = reId;
                                        });
                                      },
                                      codeAutoRetrievalTimeout: (timeOut) {})
                                  .then((value) {
                                setState(() {
                                  isOtpAppeard = !isOtpAppeard;
                                });
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: lightOrangeColor,
                              foregroundColor: dark2OrangeColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 20),
                              textStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            child: Text(Cons.save),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ]),
    );
  }
}
