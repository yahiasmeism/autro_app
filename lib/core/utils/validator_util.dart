class ValidatorUtils {
  ValidatorUtils._();
  // Validate if the field is not empty
  static String? validateRequired(String? value,
      {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  static String? validateUserName(String? value,
      {int minLength = 3, int maxLength = 20}) {
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
    if (!RegExp(r'^[\p{L}\p{N}\s\W]+$', unicode: true).hasMatch(value)) {
      return 'Invalid input. Only letters, numbers, and symbols are allowed.';
    }
    return null;
  }

  static String? validateNameOptional(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      if (!RegExp(r'^[\p{L}\p{N}\s\W]+$', unicode: true).hasMatch(value)) {
        return 'Invalid input. Only letters, numbers, and symbols are allowed.';
      }
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

  static String? validateConfirmPassword(
      String? value, String? originalPassword) {
    if (value == null || value.trim().isEmpty) {
      return 'Confirm password is required.';
    }
    if (value != originalPassword) {
      return 'Passwords do not match.';
    }
    return null;
  }

  // Validate matching fields (e.g., password and confirm password)
  static String? validateMatch(String? value, String? compareTo,
      {String fieldName = 'Fields'}) {
    if (value != compareTo) {
      return '$fieldName do not match.';
    }
    return null;
  }

  /// Validate a non-empty text field
  static String? validateRequiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName cannot be empty.';
    }
    return null;
  }

  /// Validate email address
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // ✅ Email is now optional
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  /// Validate website URL
  static String? validateWebsite(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Website URL cannot be empty.';
    }
    final urlRegex =
        RegExp(r'^(https?:\/\/)?([\w-]+(\.[\w-]+)+)([\/\w .-]*)*\/?$');
    if (!urlRegex.hasMatch(value.trim())) {
      return 'Please enter a valid website URL.';
    }
    return null;
  }

  static String? validateTelephone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Telephone number cannot be empty.';
    }

    final telephoneRegex = RegExp(r'^\+?[0-9]{1,4}([-\s]?[0-9]{1,3}){2,4}$');

    if (!telephoneRegex.hasMatch(value.trim())) {
      return 'Please enter a valid telephone number.';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // ✅ Now it's optional
    }

    final phoneRegex = RegExp(
        r'^\+?[0-9\s-]+$'); // ✅ Simple format: numbers, spaces, and dashes only

    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Please enter a valid phone number (numbers, spaces, and dashes only).';
    }

    return null;
  }

  /// Validate optional file path (e.g., for logo or signature)
  static String? validateFilePath(String? value, String fieldName) {
    if (value != null && value.trim().isNotEmpty) {
      final fileRegex = RegExp(r'^.+\.(jpg|jpeg|png|gif)$');
      if (!fileRegex.hasMatch(value.trim())) {
        return 'Please upload a valid $fieldName (JPG, JPEG, PNG, or GIF).';
      }
    }
    return null;
  }
}
