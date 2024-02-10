import 'package:flutter/material.dart';

class CustomGradientTextButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const CustomGradientTextButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: LinearGradient(
          colors: [Colors.white, Colors.white],
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        // Add your onPressed logic here

        style: TextButton.styleFrom(
          padding: EdgeInsets.all(16.0),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [Color(0xFF0086EC), Color(0xFF6BECEC)],
            ).createShader(bounds);
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
