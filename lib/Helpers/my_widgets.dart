import 'package:camel_trace/Combonet/Staylle.dart';
import 'package:camel_trace/Combonet/gredent.dart';
import 'package:camel_trace/Helpers/const.dart';
import 'package:camel_trace/Helpers/gradianbuttonborder.dart';
import 'package:flutter/material.dart';

class MyWidgets {
  MyWidgets({required this.context});
  final BuildContext context;
  Widget addFooterImage() {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Positioned.fill(
        left: 0.0,
        right: 0.0,
        bottom: -30,
        child: ColoredBox(
          color: Color(0xffA9BCCB),
        ));
  }

  Widget addTitleTextView(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Color(0xFFFFFFFF),
        letterSpacing: 8.0,
        fontSize: 26,
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w600,
        height: 0.03,
      ),
    );
  }

  Widget addLogoImage() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      width: screenWidth,
      height: screenHeight / 5,
      child: Image.asset(
        "images/logo.png",
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
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

  Widget addLabel(
    String text,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        alignment: Alignment.centerRight,
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black45,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          text,
        ),
      ),
    );
  }

  Widget addTextFieldWithFillData(
    TextEditingController controller,
    String title,
    Function(String?) onChanged,
    Function() action,
    String? Function(String?) validation, {
    TextInputType inputType = TextInputType.text,
    bool obsureText = false,
    bool enableSuggestion = true,
    bool autoCorrect = true,
    bool readOnly = false,
    bool showCursor = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
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
        onChanged: onChanged,
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
    return Padding(
      padding: const EdgeInsets.only(right: 53, left: 53),
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment(1.00, 0.00),
            end: Alignment(-1, 0),
            colors: [Color(Cons.orangeColor), Color(Cons.orangeColor)],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
        child: TextButton(
          onPressed: action,
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget addButtonWithoutBg(String title, void Function() action) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
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
      actions: [
        okButton,
      ],
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

  showAlertDialogWithCancel(
      BuildContext context, String message, VoidCallback onOKPressed) {
    var buttonStyleOK = const TextStyle(
      color: Colors.blue,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    var buttonStyleCancel = const TextStyle(
      color: Colors.blue,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    // set up the button
    Widget okButton = TextButton(
      child: constText(
        "OK",
        style: buttonStyleOK,
      ),
      onPressed: onOKPressed,
    );
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: buttonStyleCancel,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: const EdgeInsets.all(0),
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
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      actions: [
        okButton,
        cancelButton,
      ],
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

  // showCustomToast(String message, [Color? mColor]) {
  //   mColor ??= const Color.fromARGB(153, 26, 20, 219);
  //   Fluttertoast.showToast(
  //     msg: message,
  //     toastLength: Toast.LENGTH_LONG,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 1,
  //     fontSize: 16.0,
  //     textColor: Colors.white,
  //   );
  // }

  Widget addDropDownList(String dropDownText, Function(dynamic)? callBack,
      List<DropdownMenuItem<dynamic>> items) {
    items.add(const DropdownMenuItem(child: Text("المنطقة")));
    return Container(
      //    color: Color.fromARGB(255, 242, 237, 237),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width - 40,
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

  Widget addProgressBar(double progress) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 55),
      child: LinearProgressIndicator(
        backgroundColor: const Color(0xffD9D9D9),
        valueColor: AlwaysStoppedAnimation<Color>(Cons.myGradienColor),
        value: progress,
      ),
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

  Widget searchCard() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Container(
            width: 80,
            height: 31,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              shadows: [
                BoxShadow(
                  color: Color(0x1E000000),
                  blurRadius: 2,
                  offset: Offset(2, 2),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                    onTap: () {},
                    child: Image.asset(
                      "images/Group.png",
                      color: darkblue,
                      fit: BoxFit.fill,
                    )),
                InkWell(
                    onTap: () {
                      //
                    },
                    child: Image.asset("images/pdf.png", fit: BoxFit.fill)),
                InkWell(
                    onTap: () {},
                    child: Image.asset(
                      "images/Icon Left.png",
                      fit: BoxFit.fill,
                    )),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Container(
            width: 260,
            height: 31,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              shadows: [
                BoxShadow(
                  color: Color(0x1E000000),
                  blurRadius: 2,
                  offset: Offset(2, 2),
                  spreadRadius: 0,
                )
              ],
            ),
            child: InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "ابحث",
                    style: h5,
                  ),
                  Icon(Icons.search)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget search() {
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: Container(
        width: double.infinity,
        height: 31,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          shadows: [
            BoxShadow(
              color: Color(0x1E000000),
              blurRadius: 2,
              offset: Offset(2, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: InkWell(
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text(
              "ابحث ",
              style: h5,
            ),
            Icon(Icons.search)
          ]),
        ),
      ),
    );
  }

  constText(String s, {required TextStyle style}) {}
}
