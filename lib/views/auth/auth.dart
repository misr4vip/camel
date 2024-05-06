import 'package:camel_trace/Combonet/my_widget.dart';
import 'package:camel_trace/Helpers/const.dart';
import 'package:camel_trace/views/auth/login_view.dart';
import 'package:camel_trace/views/auth/signup_view.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  var screenWidth = 0.0, screenHeight = 0.0;
  var isLogin = true;

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
              color: grayColor,
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
                                    color:
                                        isLogin ? lightOrangeColor : whiteColor,
                                    fontSize: 22),
                              )),
                          const Text(
                            "|",
                            style: TextStyle(color: whiteColor, fontSize: 22),
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
                                    color:
                                        isLogin ? whiteColor : lightOrangeColor,
                                    fontSize: 22),
                              )),
                        ],
                      ),
                    )
                  ]),
            )),
        Positioned.fill(
          top: 250,
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            alignment: Alignment.center,
            child: SingleChildScrollView(
                child: isLogin ? const LoginView() : const SignupView()),
          ),
        ),
      ]),
    );
  }
}
