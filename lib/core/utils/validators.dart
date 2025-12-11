/// Input validation utilities for security and data integrity
/// Provides validators for common input types following OWASP guidelines
class Validators {
  Validators._();

  // Email validation regex (RFC 5322 compliant)
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$',
  );

  // Phone validation regex (international format)
  static final RegExp _phoneRegex = RegExp(
    r'^\+?[1-9]\d{1,14}$',
  );

  // Greek AFM (Tax ID) validation regex
  static final RegExp _afmRegex = RegExp(r'^\d{9}$');

  // Greek postal code regex
  static final RegExp _postalCodeRegex = RegExp(r'^\d{5}$');

  // Alphanumeric only regex
  static final RegExp _alphanumericRegex = RegExp(r'^[a-zA-Z0-9]+$');

  // No special characters regex (allows spaces and basic punctuation)
  static final RegExp _safeTextRegex = RegExp(r'^[a-zA-Z0-9\s\.,\-_αβγδεζηθικλμνξοπρστυφχψωάέήίόύώΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩΆΈΉΊΌΎΏ]+$');

  /// Validates email address
  static ValidationResult validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationResult.invalid('Email is required');
    }
    if (value.length > 254) {
      return ValidationResult.invalid('Email is too long');
    }
    if (!_emailRegex.hasMatch(value)) {
      return ValidationResult.invalid('Invalid email format');
    }
    return ValidationResult.valid();
  }

  /// Validates password strength
  static ValidationResult validatePassword(String? value, {
    int minLength = 8,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireDigit = true,
    bool requireSpecialChar = true,
  }) {
    if (value == null || value.isEmpty) {
      return ValidationResult.invalid('Password is required');
    }
    if (value.length < minLength) {
      return ValidationResult.invalid('Password must be at least $minLength characters');
    }
    if (value.length > 128) {
      return ValidationResult.invalid('Password is too long');
    }
    if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
      return ValidationResult.invalid('Password must contain an uppercase letter');
    }
    if (requireLowercase && !value.contains(RegExp(r'[a-z]'))) {
      return ValidationResult.invalid('Password must contain a lowercase letter');
    }
    if (requireDigit && !value.contains(RegExp(r'[0-9]'))) {
      return ValidationResult.invalid('Password must contain a digit');
    }
    if (requireSpecialChar && !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return ValidationResult.invalid('Password must contain a special character');
    }
    return ValidationResult.valid();
  }

  /// Validates phone number
  static ValidationResult validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationResult.invalid('Phone number is required');
    }
    final cleaned = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    if (!_phoneRegex.hasMatch(cleaned)) {
      return ValidationResult.invalid('Invalid phone number format');
    }
    return ValidationResult.valid();
  }

  /// Validates Greek AFM (Tax ID)
  static ValidationResult validateAFM(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationResult.invalid('AFM is required');
    }
    if (!_afmRegex.hasMatch(value)) {
      return ValidationResult.invalid('AFM must be 9 digits');
    }
    // Validate AFM checksum
    if (!_isValidAFMChecksum(value)) {
      return ValidationResult.invalid('Invalid AFM');
    }
    return ValidationResult.valid();
  }

  /// Validates Greek postal code
  static ValidationResult validatePostalCode(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationResult.invalid('Postal code is required');
    }
    if (!_postalCodeRegex.hasMatch(value)) {
      return ValidationResult.invalid('Postal code must be 5 digits');
    }
    return ValidationResult.valid();
  }

  /// Validates required field
  static ValidationResult validateRequired(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return ValidationResult.invalid('$fieldName is required');
    }
    return ValidationResult.valid();
  }

  /// Validates text length
  static ValidationResult validateLength(
    String? value, {
    int? minLength,
    int? maxLength,
    String fieldName = 'Field',
  }) {
    if (value == null) {
      return ValidationResult.invalid('$fieldName is required');
    }
    if (minLength != null && value.length < minLength) {
      return ValidationResult.invalid('$fieldName must be at least $minLength characters');
    }
    if (maxLength != null && value.length > maxLength) {
      return ValidationResult.invalid('$fieldName must be at most $maxLength characters');
    }
    return ValidationResult.valid();
  }

  /// Validates numeric input
  static ValidationResult validateNumeric(String? value, {
    double? min,
    double? max,
    String fieldName = 'Value',
  }) {
    if (value == null || value.isEmpty) {
      return ValidationResult.invalid('$fieldName is required');
    }
    final number = double.tryParse(value);
    if (number == null) {
      return ValidationResult.invalid('$fieldName must be a number');
    }
    if (min != null && number < min) {
      return ValidationResult.invalid('$fieldName must be at least $min');
    }
    if (max != null && number > max) {
      return ValidationResult.invalid('$fieldName must be at most $max');
    }
    return ValidationResult.valid();
  }

  /// Validates safe text (no dangerous characters)
  static ValidationResult validateSafeText(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.isEmpty) {
      return ValidationResult.valid(); // Empty is valid for optional fields
    }
    if (!_safeTextRegex.hasMatch(value)) {
      return ValidationResult.invalid('$fieldName contains invalid characters');
    }
    return ValidationResult.valid();
  }

  /// Validates alphanumeric input
  static ValidationResult validateAlphanumeric(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.isEmpty) {
      return ValidationResult.invalid('$fieldName is required');
    }
    if (!_alphanumericRegex.hasMatch(value)) {
      return ValidationResult.invalid('$fieldName must be alphanumeric');
    }
    return ValidationResult.valid();
  }

  /// Validates URL
  static ValidationResult validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationResult.invalid('URL is required');
    }
    final uri = Uri.tryParse(value);
    if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
      return ValidationResult.invalid('Invalid URL format');
    }
    if (!['http', 'https'].contains(uri.scheme.toLowerCase())) {
      return ValidationResult.invalid('URL must use HTTP or HTTPS');
    }
    return ValidationResult.valid();
  }

  // Private helper to validate AFM checksum
  static bool _isValidAFMChecksum(String afm) {
    if (afm.length != 9) return false;
    
    int sum = 0;
    for (int i = 0; i < 8; i++) {
      final digit = int.tryParse(afm[i]);
      if (digit == null) return false;
      sum += digit * (1 << (8 - i));
    }
    
    final checkDigit = int.tryParse(afm[8]);
    if (checkDigit == null) return false;
    
    return (sum % 11) % 10 == checkDigit;
  }
}

/// Result of a validation operation
class ValidationResult {
  const ValidationResult._({
    required this.isValid,
    this.errorMessage,
  });

  factory ValidationResult.valid() => const ValidationResult._(isValid: true);
  
  factory ValidationResult.invalid(String message) => ValidationResult._(
    isValid: false,
    errorMessage: message,
  );

  final bool isValid;
  final String? errorMessage;

  @override
  String toString() => isValid ? 'Valid' : 'Invalid: $errorMessage';
}

/// Extension for String validation
extension StringValidation on String? {
  ValidationResult get isValidEmail => Validators.validateEmail(this);
  ValidationResult get isValidPhone => Validators.validatePhone(this);
  ValidationResult get isValidAFM => Validators.validateAFM(this);
  ValidationResult get isValidPostalCode => Validators.validatePostalCode(this);
  ValidationResult get isValidUrl => Validators.validateUrl(this);
  ValidationResult get isRequired => Validators.validateRequired(this);
  ValidationResult get isSafeText => Validators.validateSafeText(this);
}
