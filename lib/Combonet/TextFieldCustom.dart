import 'package:flutter/material.dart';


class CustomTextField extends TextField {

  CustomTextField({
    Key? key,
    TextEditingController? controller,
    TextStyle? style,
    Color ? color,
    Image?image,
     bool obscureText = true
 
    
      
  }) :
      super(
          key: key,
          controller: controller,
          style: style,
          obscureText: obscureText,
          
          
          decoration: InputDecoration(
            
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
             
            ),
          ),
        );
}