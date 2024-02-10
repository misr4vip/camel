import 'package:camel_trace/Helpers/const.dart';
import 'package:flutter/material.dart';
import '../../Helpers/my_widgets.dart';

class SignUpFirstLayout extends StatefulWidget {
  const SignUpFirstLayout({super.key, required this.title});
  final String title;
  @override
  State<SignUpFirstLayout> createState() => _SignUpFirstLayoutState();
}

class _SignUpFirstLayoutState extends State<SignUpFirstLayout> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var telNumController = TextEditingController();
  var emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var h = MyWidgets(context: context);
    // var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Column(children: [

              h.addTitleTextView("CAMEL TRACK"),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(right: 52, left: 52),
                child: h.addTextField(
                    firstNameController, Cons.firstName, () => null, (value) {
                  if (value!.isEmpty) {
                    return Cons.thisFieldRequired;
                  } else {
                    return null;
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 52, left: 52),
                child: h.addTextField(
                    lastNameController, Cons.lastName, () => null, (value) {
                  if (value!.isEmpty) {
                    return Cons.thisFieldRequired;
                  } else {
                    return null;
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 52, left: 52),
                child: h.addTextField(
                    telNumController, Cons.phoneNumber, () => null, (value) {
                  final bool isValid =
                      RegExp(Cons.phoneNumberRegex).hasMatch(value!);
                  if (value.isEmpty) {
                    return Cons.thisFieldRequired;
                  } else if (!isValid) {
                    return Cons.phoneNumberIsInvalid;
                  } else if (value.length < 12 || value.length > 12) {
                    return Cons.phoneNumberIsInvalid;
                  } else {
                    return null;
                  }
                }, inputType: TextInputType.phone),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 52, left: 52),
                child: h.addTextField(
                    emailController,
                    "${Cons.email}   ( ${Cons.optional} )",
                    () => null, (value) {
                  final bool isValid =
                      RegExp(Cons.emailRegex).hasMatch(value!);
                  if (!isValid && value.isNotEmpty) {
                    return Cons.emailIsInvalid;
                  }
                  return null;
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              h.addButton(Cons.next, nextPage),
              const SizedBox(
                height: 10,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  nextPage() {
    if (_formKey.currentState!.validate()) {}
  }
}
