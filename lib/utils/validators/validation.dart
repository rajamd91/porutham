class TValidator {
  /// Empty Text Validation

  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final components = value.split("-");
    if (components.length == 3) {
      final day = int.tryParse(components[0]);
      final month = int.tryParse(components[1]);
      final year = int.tryParse(components[2]);
      if (day != null && month != null && year != null) {
        final date = DateTime(year, month, day);
        if (date.year == year && date.month == month && date.day == day) {
          return null;
        }
      }
    }
    return "wrong date";
  }

  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter $fieldName is required';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is Required';
    }

    /// Regular Expression for Email Validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    /// Check for minimum password length
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    /// Check for upper case letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one upper case letter.';
    }

    /// Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    /// Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    /// Regular expression for phone number validation( Assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'In valid phone number format(10 digits required)';
    }
    return null;
  }

  static String? validateName(String? value) {
    final nameRegExp = RegExp('[a-zA-Z]');
    if (value == null || value.isEmpty) {
      return 'Enter the name';
    }
    if (!nameRegExp.hasMatch(value)) {
      return 'Enter valid name';
    }
    return null;
  }

  // static String? validatePassword(String? value) {
  //   RegExp regex =
  //       RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter password';
  //   } else {
  //     if (value.length < 6) {
  //       return 'Password must be at least six characters long';
  //     } else {
  //       if (!regex.hasMatch(value)) {
  //         return 'Enter valid password';
  //       } else {
  //         return null;
  //       }
  //     }
  //   }
  // }
}
