// This directive tells the Dart analyzer to ignore constant identifier naming warnings
// ignore_for_file: constant_identifier_names

/// AppSecrets manages application-wide configuration constants and sensitive data
/// Uses a private constructor to prevent instantiation
class AppSecrets {
  // Private constructor prevents creating instances of this utility class
  AppSecrets._();

  // Base URL for API endpoints - currently commented out
  // static const String BASE_URL = 'http://localhost:8080';

  // Flag to determine if app is running in production mode
  // Controls feature toggles and environment-specific behavior
  static const bool PROD_MODE = true;

  // Support email for user inquiries and help
  static const String EMAIL_SUPPORT = 'support@animai.com';
}
