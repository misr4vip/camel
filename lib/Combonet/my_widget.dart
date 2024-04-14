import 'package:flutter/material.dart';
import 'package:camel_trace/Helpers/const.dart';
import 'package:camel_trace/Combonet/unicornOutLineButton.dart';

import '../Helpers/gradiantext.dart';

class MyWidgets {
  MyWidgets({required this.context});
  final BuildContext context;

  Widget addTitleTextView(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Color(0xFF0389ED),
        fontSize: 28,
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w600,
        height: 0.03,
      ),
    );
  }

  Widget addLogoImage(String imagePath) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      width: screenWidth,
      height: screenHeight / 5,
      child: Image.asset(
        imagePath,
      ),
    );
  }

  Widget addImage(String imagePath) {
    return Image.asset(imagePath);
  }

  Widget addTextField(
    TextEditingController controller,
    String title,
    Function() action,
    String? Function(String?) validation, {
    TextInputType inputType = TextInputType.text,
    bool obsureText = false,
    bool enableSuggestion = true,
    bool autoCorrect = true,
    bool readOnly = false,
    bool showCursor = true,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        obscureText: obsureText,
        enableSuggestions: enableSuggestion,
        autocorrect: autoCorrect,
        keyboardType: inputType,
        readOnly: readOnly,
        validator: validation,
        showCursor: showCursor,
        controller: controller,
        onTap: action,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5), gapPadding: 2),
          label: Text(title),
        ),
      ),
    );
  }

  Widget addCheckBox(String title) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        SizedBox(
          width: screenWidth / 9,
        ),
        Text(title),
        const Checkbox(
          value: false,
          onChanged: null,
        ),
      ],
    );
  }

  Widget addButton(String title, VoidCallback action) {
    return Container(
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(1.00, 0.00),
          end: Alignment(-1, 0),
          colors: [Color(0xFF0086EC), Color(0xFF6BECEC)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: TextButton(
        onPressed: action,
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget addButtonWithoutBg(String title, void Function() action) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
      child: UnicornOutlineButton(
        strokeWidth: 3,
        radius: 15,
        gradient: const LinearGradient(
            colors: [Color(0xFF0086EC), Color(0xFF6BECEC)]),
        onPressed: action,
        child: GradientText(
          title,
          style: const TextStyle(fontSize: 16),
          gradient: const LinearGradient(
              colors: [Color(0xFF0086EC), Color(0xFF6BECEC)]),
        ),
      ),
    );
  }

  Widget regularEditText(
    TextEditingController controller,
    String title, {
    IconData icon = Icons.abc,
    isObscure = false,
    VoidCallback? TappedFunction,
    bool isReadOnly = false,
    bool showCurser = true,
  }) {
    return Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty || value.length < 3) {
              return "name should at least  have 3 letters.";
            }
            return null;
          },
          controller: controller,
          readOnly: isReadOnly,
          showCursor: showCurser,
          decoration: InputDecoration(
            labelText: title,
            prefixIcon: Padding(
              padding:
                  const EdgeInsets.only(top: 5), // add padding to adjust icon
              child: Icon(icon),
            ),
          ),
          onTap: TappedFunction,
          obscureText: isObscure,
        ));
  }

  showAlertDialog(
      BuildContext context, String message, VoidCallback onOKPressed) {
    // set up the button
    Widget okButton = TextButton(
      onPressed: onOKPressed,
      child: const Text("OK"),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        Cons.appName,
        style: const TextStyle(
          color: Colors.black87,
          fontFamily: "Philosopher",
        ),
      ),
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      actions: [okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.white,
          ),
          child: Container(child: alert),
        );
      },
    );
  }

  showAlertDialogOkCancel(
      BuildContext context, String message, VoidCallback onOKPressed) {
    // set up the button
    Widget okButton = TextButton(
      onPressed: onOKPressed,
      child: const Text("OK"),
    );
    Widget cancelButton = TextButton(
      child: const Text(
        "Cancel",
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        Cons.appName,
        style: const TextStyle(
          color: Colors.black87,
          fontFamily: "Philosopher",
        ),
      ),
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.white,
          ),
          child: Container(child: alert),
        );
      },
    );
  }

  Widget addDropDownList(String dropDownText, Function(dynamic)? callBack,
      List<DropdownMenuItem<dynamic>> items) {
    items.add(const DropdownMenuItem(child: Text("المنطقة")));
    return Container(
      //    color: Color.fromARGB(255, 242, 237, 237),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.black26,
          ),
          borderRadius: BorderRadius.circular(5)),
      child: DropdownButton(
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
          borderRadius: BorderRadius.circular(10),
          itemHeight: 70,
          alignment: AlignmentDirectional.centerEnd,
          icon: const Icon(Icons.keyboard_arrow_left),
          items: items,
          onChanged: callBack),
    );
  }

  Widget addFilePicker(VoidCallback action, double screenWidth, String title) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      alignment: Alignment.center,
      width: screenWidth,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextButton(
        onPressed: action,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.black),
            ),
            const Icon(
              Icons.file_open,
            ),
          ],
        ),
      ),
    );
  }

  constText(String s, {required TextStyle style}) {}

  addProgressBar(double d) {}
}
