import 'dart:convert';
import 'package:crypto/crypto.dart';

bool validateEmail(String email) {
  // Regular expression for validating email
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  return emailRegex.hasMatch(email);
}

bool isEmpty(String txt) {
  return txt.isEmpty;
}

bool validatePhoneNumber(String phoneNumber) {
  // Regular expression for validating phone number
  final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');

  return phoneRegex.hasMatch(phoneNumber);
}

String hashPassword(String password) {
  // Create a SHA-256 hash
  var bytes = utf8.encode(password); // Convert password to bytes
  var digest = sha256.convert(bytes); // Generate hash

  // Convert hash to hexadecimal string
  return digest.toString();
}

bool validatePassword(String password) {
  // Define validation criteria
  const minLength = 8;
  final pattern =
      RegExp(r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  // Check if the password meets the criteria
  return password.length >= minLength && pattern.hasMatch(password);
}

bool validateConfirmPassword(String password, String confirmPassword) {
  // Check if the passwords match
  return password == confirmPassword;
}
