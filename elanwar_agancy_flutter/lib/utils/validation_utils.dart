class ValidationUtils {
  static bool isValidEmail(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }

  static bool isValidUrl(String url) {
    var urlPattern =
        r"^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w-\._~:/?#[\]@!\$'\(\)\*\+,;=.]+$";
    return RegExp(urlPattern, caseSensitive: false).hasMatch(url);
  }

  static bool isValidUsername(String username) {
    return RegExp(r'^(?!\s*$)[a-zA_Z0-9_-]{3,20}$').hasMatch(username);
  }

  static bool isValidPassword(String password) {
    return password.length > 7;
  }

  static bool isValidPhoneNumber(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10-12}$)';
    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(value.replaceAll("+", ""))) {
      return false;
    }

    return true;
  }

  static String? formValidatorEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email Required";
    }
    if (!isValidEmail(value)) {
      return "Invalid Email";
    }
    return null;
  }

  static String? formValidatorUserName(String? value) {
    if (value == null || value.isEmpty) {
      return "Username Required";
    }
    if (!isValidUsername(value)) {
      return "Invalid Username";
    }
    return null;
  }

  static String? formValidatorPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password Required";
    }
    if (!isValidPassword(value)) {
      return "Invalid Password";
    }
    return null;
  }

  static String? formValidatorPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number Required";
    }
    // if (!isValidPhoneNumber(value)) {
    //   return "Invalid Phone number";
    // }

    return null;
  }

  static String? formValidatorNotEmpty(String? value, String label) {
    if (value == null || value.isEmpty) {
      return "$label Required";
    }

    return null;
  }
}
