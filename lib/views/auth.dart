import 'package:camel_trace/Helpers/const.dart';
import 'package:camel_trace/views/login_view.dart';
import 'package:camel_trace/views/signup_view.dart';
import 'package:flutter/material.dart';
import '../../Helpers/my_widgets.dart';

class Auth extends StatefulWidget {
  const Auth({
    super.key,
    required this.title,
  });
  final String title;
  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  var screenWidth = 0.0, screenHeight = 0.0;
  var isLogin = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var h = MyWidgets(context: context);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(children: [
        Positioned.fill(
            left: 0.0,
            right: 0.0,
            bottom: -30,
            top: 0.0,
            child: Container(
              alignment: Alignment.center,
              color: const Color(0xffA9BCCB),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: h.addTitleTextView(Cons.appName),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 75),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  isLogin = true;
                                });
                              },
                              child: Text(
                                Cons.signIn,
                                style: TextStyle(
                                    color: Color(isLogin
                                        ? Cons.orangeColor
                                        : Cons.whiteColor),
                                    fontSize: 22),
                              )),
                          Text(
                            "|",
                            style: TextStyle(
                                color: Color(Cons.whiteColor), fontSize: 22),
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  isLogin = false;
                                });
                              },
                              child: Text(
                                Cons.signUp,
                                style: TextStyle(
                                    color: Color(isLogin
                                        ? Cons.whiteColor
                                        : Cons.orangeColor),
                                    fontSize: 22),
                              )),
                        ],
                      ),
                    )
                  ]),
            )),
        Positioned.fill(
          top: 300,
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                  child: isLogin ? const LoginView() : const SignupView()),
            ),
          ),
        ),
      ]),
    );
  }

  void fLogin() {
    if (_formKey.currentState!.validate()) {}
  }
}
