import 'package:flutter/material.dart';

class CustomGradientBackgroundButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const CustomGradientBackgroundButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: Ink(
          decoration: BoxDecoration(
              color: const Color(0xFFCBCBD4),
              gradient: onPressed == null
                  ? null
                  : const LinearGradient(
                      begin: Alignment(1.00, 0.00),
                      end: Alignment(-1, 0),
                      colors: [Color(0xFF0086EC), Color(0xFF6BECEC)],
                    ),
              borderRadius: BorderRadius.circular(15)),
          child: Container(
            width: 300,
            height: 48,
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: "Cairo-SemiBold",
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
