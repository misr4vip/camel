import 'package:flutter/material.dart';

class textLogin extends StatelessWidget {
  final String text;
  final Color color;
  final double Size;


   const textLogin(String s, {super.key, required this.text, required this.color, required this.Size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: Size,
        fontFamily: 'Cairo-Regular',
        fontWeight: FontWeight.w400,
        height: 0.07,
      ),
    );
  }
}
