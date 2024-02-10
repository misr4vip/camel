import 'package:camel_trace/Helpers/const.dart';
import 'package:flutter/material.dart';
import '../../Helpers/my_widgets.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
    required this.title,
  });
  final String title;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var screenWidth = 0.0, screenHeight = 0.0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var h = MyWidgets(context: context);

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(

      ),
      body: Stack(children: [
        h.addFooterImage(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(children: [
                h.addTitleTextView(Cons.appName),
                SizedBox(height: screenWidth / 10),

                Padding(
                  padding: const EdgeInsets.only(left: 58, right: 58),
                  child: h.addTextField(
                      userNameController, Cons.phoneNumber, () => null,
                      (value) {
                    if (value!.isEmpty) {
                      return Cons.thisFieldRequired;
                    } else if (value.length < 10) {
                      return Cons.thisFieldRequired;
                    } else if (!value.startsWith("9665")) {
                      return Cons.thisFieldRequired;
                    }

                    return null;
                  }),
                ),
                SizedBox(height: screenWidth / 20),
                Padding(
                  padding: const EdgeInsets.only(left: 58, right: 58),
                  child: h.addTextField(
                      passwordController, Cons.password, () => null, (value) {
                    if (value!.isEmpty) {
                      return Cons.thisFieldRequired;
                    }
                    return null;
                  }, obsureText: true),
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 88, right: 88),
                      child: TextButton(
                          onPressed: null,
                          child: Text(
                            "نسيت كلمة المرور؟",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          )),
                    ),
                  ],
                ),
                h.addButton(Cons.signIn, () => fLogin()),
                const SizedBox(
                  height: 10,
                ),
                h.addButtonWithoutBg(Cons.signUp, () => fSignUp()),
                const SizedBox(
                  height: 140,
                )
              ]),
            ),
          ),
        ),
      ]),
    );
  }

  void fSignUp() {}
  void fLogin() {
    if (_formKey.currentState!.validate()) {}
  }
}
