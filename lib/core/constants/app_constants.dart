/// Application-wide constants
/// Centralized configuration for maintainability
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Municipality MVP';
  static const String appVersion = '1.0.0';
  static const String cityName = 'Athens';
  static const String cityNameGreek = 'Αθήνα';

  // Spacing
  static const double spacingXxs = 4.0;
  static const double spacingXs = 8.0;
  static const double spacingSm = 12.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingXxl = 48.0;

  // Border Radius
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 999.0;

  // Icon Sizes
  static const double iconXs = 16.0;
  static const double iconSm = 20.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;

  // Touch Targets (WCAG minimum 44px)
  static const double touchTargetMin = 44.0;
  static const double touchTargetMd = 48.0;
  static const double touchTargetLg = 56.0;

  // Animation Durations
  static const Duration animFast = Duration(milliseconds: 150);
  static const Duration animNormal = Duration(milliseconds: 300);
  static const Duration animSlow = Duration(milliseconds: 500);

  // Bottom Navigation
  static const double bottomNavHeight = 80.0;
  static const double bottomNavIconSize = 24.0;

  // Card Dimensions
  static const double cardElevation = 0.0;
  static const double cardBorderWidth = 1.0;

  // Header Heights
  static const double appBarHeight = 56.0;
  static const double headerExpandedHeight = 200.0;

  // Grid
  static const int gridCrossAxisCount = 2;
  static const double gridSpacing = 12.0;
  static const double gridChildAspectRatio = 1.1;
}
