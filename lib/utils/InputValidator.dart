import 'package:email_validator/email_validator.dart';

class InputValidator {

  static String? firstName(value) {
    if (value.isEmpty) {
      return 'Please provide your First Name!';
    }
    return null;
  }

  static String? lastName(value) {
    if (value.isEmpty) {
      return 'Please provide your Last Name!';
    }
    return null;
  }

  static String? email(value) {
    if (value.isEmpty) {
      return 'Please provide your email address!';
    }
    if (!EmailValidator.validate(value)) {
      return 'Please enter a valid email!';
    }
    return null;
  }

  static String? password(value) {
    if (value.isEmpty) {
      return 'Please provide your password!';
    }
    if (value.length < 3 || value.length > 100) {
      return 'Password must be between 3 - 100 characters!';
    }
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return 'Sorry, special characters are not allowed!';
    }
    return null;
  }
  static String? confipassword(value,value2) {
    if (value.isEmpty) {
      return 'Please provide your password!';
    }
    if (value.length < 3 || value.length > 100) {
      return 'Password must be between 3 - 100 characters!';
    }
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return 'Sorry, special characters are not allowed!';
    }
    if (value != value2) {
      return "Password don't match";
    }
    return null;
  }
  
}