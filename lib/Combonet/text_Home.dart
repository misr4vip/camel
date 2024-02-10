import 'package:flutter/material.dart';
import 'package:camel_trace/Combonet/Staylle.dart';

class MyWidget extends StatelessWidget {
  MyWidget({super.key, this.text});
  var text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: h1,
        )
      ],
    );
  }
}
