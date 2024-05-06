import 'package:camel_trace/Helpers/const.dart';
import 'package:camel_trace/Helpers/validation.dart';
import 'package:camel_trace/modles/UserModel.dart';
import 'package:camel_trace/views/auth/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Combonet/my_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscureText = true;
  late BuildContext mContext;
  late MyWidgets w;
  late UserModel user;
  @override
  Widget build(BuildContext context) {
    mContext = context;
    w = MyWidgets(context: mContext);
    return Form(
      key: _formKey,
      child: Column(children: [
        w.addSubTitleTextView(Cons.welcomeBack),
        const SizedBox(height: 50),
        w.regularEditText(
          userNameController,
          Cons.phoneNumber,
          icon: Icons.phone,
          onCodeChanged: (p0) {
            if (isEmpty(p0!)) {
              return "Please enter a valid phone number";
            }
            if (p0.length != 10) {
              return " phone number should be 10 numbers ";
            }
            if (!p0.startsWith('0')) {
              return " phone number should be start with 0";
            }
            if (!validatePhoneNumber(p0)) {
              return "Please enter a valid phone number";
            }
            return null;
          },
        ),
        const SizedBox(height: 18),
        w.regularEditText(
          passwordController,
          Cons.password,
          icon: Icons.password,
          isObscure: _obscureText,
          onCodeChanged: (p0) {
            if (isEmpty(p0!)) {
              return "Please enter a valid password";
            }
            return null;
          },
          suffixIcon: IconButton(
              icon:
                  Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              }),
        ),
        const SizedBox(
          height: 18,
        ),
        Container(
          alignment: Alignment.topRight,
          child: TextButton(
              onPressed: null,
              child: Text(
                Cons.forgetPassword,
                style: const TextStyle(
                  color: darkOrangeColor,
                  fontSize: 18,
                ),
              )),
        ),
        const SizedBox(
          height: 18,
        ),
        w.addButton(Cons.signIn, () async => signIn(userNameController.text)),
      ]),
    );
  }

  Future signIn(String phone) async {
    if (_formKey.currentState!.validate()) {
      getUserData(userNameController.text, passwordController.text);
    }
  }

  Future getUserData(String phone, String password) async {
    var phoneNumber = "+966${phone.substring(1)}";
    final hashedPassword = hashPassword(passwordController.text);
    var w = MyWidgets(context: context);
    var isFound = false;
    await FirebaseDatabase.instance.ref().child("users").get().then((value) {
      if (value.exists) {
        for (var element in value.children) {
          var object = element.value as Map;
          user = UserModel.fromJson(object);
          if (user.phone == phoneNumber && user.password == hashedPassword) {
            SharedPreferences.getInstance().then((value) {
              value.setString("userId", user.id);
              value.setString("userName", user.name);
              value.setString("userType", user.userType);
              value.setString("userPassword", user.password);
              value.setString("userPhone", user.phone);
              value.setString("userEmail", user.email);
            });
            isFound = true;
            _verifyPhoneNumber(phoneNumber);
            break;
          }
        }
      }
    }).onError((error, stackTrace) {
      w.showAlertDialog(context, error.toString(), () {
        Navigator.of(context).pop();
      });
    });

    if (!isFound) {
      w.showAlertDialog(mContext, "password is invalid!", () {
        Navigator.of(mContext).pop();
      });
    }
  }

  Future<void> _verifyPhoneNumber(String number) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure
          errorFade(e.message!);
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
              mContext,
              MaterialPageRoute(
                  builder: (mContext) =>
                      Otp(verificationId: verificationId, model: user)));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out, handle the issue here
        },
      );
    } catch (e) {
      errorFade(e.toString());
    }
  }

  errorFade(String msg) {
    w.showAlertDialog(mContext, msg, () {
      Navigator.of(mContext).pop();
    });
  }
}
