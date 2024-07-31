class Validators {
  // PAN validation
  static String? validatePan(String? value) {
    if (value == null || value.isEmpty) {
      return 'PAN is required';
    }
    if (!isValidPan(value)) {
      return 'Invalid PAN format';
    }
    return null;
  }

  static bool isValidPan(String value) {
    final panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
    return panRegex.hasMatch(value);
  }

  // Full name validation
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.length > 140) {
      return 'Full name cannot be more than 140 characters';
    }
    return null;
  }

  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  // Mobile number validation
  static String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }
    if (!isValidMobileNumber(value)) {
      return 'Invalid mobile number format';
    }
    return null;
  }

  static bool isValidMobileNumber(String value) {
    final mobileRegex = RegExp(r'^[6-9]\d{9}$');
    return mobileRegex.hasMatch(value);
  }

  // Address line validation
  static String? validateAddressLine(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address line is required';
    }
    return null;
  }

  // Postcode validation
  static String? validatePostcode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Postcode is required';
    }
    if (!isValidPostcode(value)) {
      return 'Invalid postcode format';
    }
    return null;
  }

  static bool isValidPostcode(String value) {
    final postcodeRegex = RegExp(r'^\d{6}$');
    return postcodeRegex.hasMatch(value);
  }
}
