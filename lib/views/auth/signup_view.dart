import 'package:camel_trace/Helpers/const.dart';
import 'package:camel_trace/Helpers/validation.dart';
import 'package:camel_trace/modles/UserModel.dart';
import 'package:camel_trace/views/auth/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Combonet/my_widget.dart';

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
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String _verificationId = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    var h = MyWidgets(context: context);
    return Form(
      key: _formKey,
      child: Column(children: [
        h.regularEditText(
          emailController,
          "email",
          icon: Icons.email,
          onCodeChanged: (p0) {
            if (isEmpty(p0!)) {
              return " email cann't be empty!";
            }
            if (!validateEmail(p0)) {
              return "Please enter a valid email";
            }
            return null;
          },
        ),
        const SizedBox(height: 18),
        h.regularEditText(
          phoneController,
          "Phone number ex 05xxxxxxxx",
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
        h.regularEditText(
          nameController,
          "owner name",
          icon: Icons.person,
          onCodeChanged: (p0) {
            if (isEmpty(p0!)) {
              return "Please enter a valid name";
            }
            return null;
          },
        ),
        const SizedBox(height: 18),
        h.regularEditText(
          passwordController,
          "password",
          icon: Icons.password,
          isObscure: _obscureText,
          suffixIcon: IconButton(
              icon:
                  Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              }),
          onCodeChanged: (p0) {
            if (isEmpty(p0!)) {
              return "Please enter a valid password";
            }
            if (validatePassword(p0)) {
              return "password length should be 8 or more \n password should have Capital and small letter ";
            }
            setState(() {
              password = p0;
            });
            return null;
          },
        ),
        const SizedBox(height: 18),
        h.regularEditText(
          rePasswordController,
          "confirm password",
          icon: Icons.password,
          isObscure: _obscureText,
          onCodeChanged: (p0) {
            if (isEmpty(p0!)) {
              return "Please enter a valid confirm password";
            }
            if (!validateConfirmPassword(password, p0)) {
              return "password length should be 8 or more \npassword should have Capital and small letter ";
            }
            return null;
          },
        ),
        const SizedBox(height: 18),
        h.addButton(Cons.signUp, () {
          if (_formKey.currentState!.validate()) {
            _verifyPhoneNumber(context, phoneController.text);
          }
        }),
      ]),
    );
  }

  // Authentication via phone number
  Future<void> _verifyPhoneNumber(
      BuildContext context, String phoneNumber) async {
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
          _verificationId = verificationId;

          final hashed = hashPassword(passwordController.text);
          var user = UserModel(
              id: "",
              name: nameController.text,
              email: emailController.text,
              phone: "+966$phone",
              userType: "owner",
              password: hashed);
          // Navigate to the screen to input the code
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Otp(verificationId: _verificationId, model: user)));
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
