class ValidatorUtil {
  ValidatorUtil._();
  // Validate if the field is not empty
  static String? validateRequired(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  static String? validateUserName(String? value, {int minLength = 3, int maxLength = 20}) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required.';
    }
    if (value.length < minLength) {
      return 'Username must be at least $minLength characters.';
    }
    if (value.length > maxLength) {
      return 'Username cannot exceed $maxLength characters.';
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores.';
    }
    return null;
  }

  // Validate email format
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required.';
    }
    // Simplified and effective regex for validating email
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  // Validate password strength
  static String? validatePassword(String? value, {int minLength = 8}) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters long.';
    }
    // if (!RegExp(r'[A-Z]').hasMatch(value)) {
    //   return 'Password must contain at least one uppercase letter.';
    // }
    // if (!RegExp(r'[a-z]').hasMatch(value)) {
    //   return 'Password must contain at least one lowercase letter.';
    // }
    // if (!RegExp(r'[0-9]').hasMatch(value)) {
    //   return 'Password must contain at least one number.';
    // }
    // if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
    //   return 'Password must contain at least one special character.';
    // }
    return null;
  }

  // Validate name (only letters and spaces)
  static String? validateNameRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required.';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name must contain only letters and spaces.';
    }
    return null;
  }

  static String? validateNameOptional(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
        return 'Name must contain only letters and spaces.';
      }
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required.';
    }
    if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
      return 'Enter a valid phone number.';
    }
    return null;
  }

  // Validate numeric input
  static String? validateNumeric(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required.';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Enter a valid number.';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? originalPassword) {
    if (value == null || value.trim().isEmpty) {
      return 'Confirm password is required.';
    }
    if (value != originalPassword) {
      return 'Passwords do not match.';
    }
    return null;
  }

  // Validate matching fields (e.g., password and confirm password)
  static String? validateMatch(String? value, String? compareTo, {String fieldName = 'Fields'}) {
    if (value != compareTo) {
      return '$fieldName do not match.';
    }
    return null;
  }
}
