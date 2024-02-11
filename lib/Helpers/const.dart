
import 'dart:ui';

class Cons {
  ///// strings
  static String appName = 'CAMEL TRACK';
  static String email = 'Email Address';
  static String phoneNumber = "Phone Number";
  static String lastName = "Last name";
  static String firstName = "First name";
  static String password = "Password";
  static String rePassword = "Confirm password";
  static String signIn = "Sign in";
  static String next = "Next";
  static String optional = "Optional";
  static String signUp = 'Sign up';


  static String thisFieldRequired = 'this Field required';
  static String emailIsInvalid = 'email is invalid';
  static String passwordInvalid = 'password invalid';
  static String confirmPasswordNotMatched = "password doesn't match confirm password ";

  ////// Colors

  static int mainColor = 0xff0389ED;
  static int orangeColor = 0xff9D7A68;
  static int whiteColor = 0xffffffff;

  ///  regex
  static String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static String phoneNumberRegex = r'[0-9]+';

  /// password without spichial charcter
  static String passwordRegex = r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$";

  /// password with spicialcharcter
  static String passwordWithSpRegex =
      r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$";
  static Color myGradienColor = lerpGradient(
      [const Color(0xff0086ec), const Color(0xff6becec)], [1, 4], 2.4);

  static Color lerpGradient(List<Color> colors, List<double> stops, double t) {
    for (var s = 0; s < stops.length - 1; s++) {
      final leftStop = stops[s], rightStop = stops[s + 1];
      final leftColor = colors[s], rightColor = colors[s + 1];
      if (t <= leftStop) {
        return leftColor;
      } else if (t < rightStop) {
        final sectionT = (t - leftStop) / (rightStop - leftStop);
        return Color.lerp(leftColor, rightColor, sectionT)!;
      }
    }
    return colors.last;
  }
}
