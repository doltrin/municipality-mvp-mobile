import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

/// Accessibility utilities for WCAG AA compliance
/// Provides helpers for semantic labels, focus management, and screen reader support
class AccessibilityUtils {
  AccessibilityUtils._();

  /// Minimum touch target size (WCAG 2.1 Level AA)
  static const double minTouchTarget = 44.0;

  /// Recommended touch target size for better accessibility
  static const double recommendedTouchTarget = 48.0;

  /// Wraps a widget with semantic information for screen readers
  static Widget semanticButton({
    required Widget child,
    required String label,
    String? hint,
    VoidCallback? onTap,
    bool isButton = true,
    bool isEnabled = true,
  }) {
    return Semantics(
      button: isButton,
      enabled: isEnabled,
      label: label,
      hint: hint,
      onTap: onTap,
      child: child,
    );
  }

  /// Wraps a widget with semantic information for images
  static Widget semanticImage({
    required Widget child,
    required String label,
    bool isDecorative = false,
  }) {
    if (isDecorative) {
      return ExcludeSemantics(child: child);
    }
    return Semantics(
      image: true,
      label: label,
      child: child,
    );
  }

  /// Wraps a widget with semantic information for text fields
  static Widget semanticTextField({
    required Widget child,
    required String label,
    String? hint,
    String? value,
    bool isObscured = false,
  }) {
    return Semantics(
      textField: true,
      label: label,
      hint: hint,
      value: value,
      obscured: isObscured,
      child: child,
    );
  }

  /// Wraps a widget with semantic information for headers
  static Widget semanticHeader({
    required Widget child,
    required String label,
    bool isHeader = true,
  }) {
    return Semantics(
      header: isHeader,
      label: label,
      child: child,
    );
  }

  /// Wraps a widget with semantic information for links
  static Widget semanticLink({
    required Widget child,
    required String label,
    String? hint,
    VoidCallback? onTap,
  }) {
    return Semantics(
      link: true,
      label: label,
      hint: hint,
      onTap: onTap,
      child: child,
    );
  }

  /// Creates a semantic announcement for screen readers
  static void announce(BuildContext context, String message) {
    // ignore: deprecated_member_use
    SemanticsService.announce(message, TextDirection.ltr);
  }

  /// Ensures minimum touch target size
  static Widget ensureMinTouchTarget({
    required Widget child,
    double minSize = minTouchTarget,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minSize,
        minHeight: minSize,
      ),
      child: child,
    );
  }

  /// Creates a focus node with proper configuration
  static FocusNode createFocusNode({
    String? debugLabel,
    bool skipTraversal = false,
    bool canRequestFocus = true,
  }) {
    return FocusNode(
      debugLabel: debugLabel,
      skipTraversal: skipTraversal,
      canRequestFocus: canRequestFocus,
    );
  }

  /// Checks if high contrast mode is enabled
  static bool isHighContrastMode(BuildContext context) {
    return MediaQuery.of(context).highContrast;
  }

  /// Checks if reduce motion is enabled
  static bool isReduceMotionEnabled(BuildContext context) {
    return MediaQuery.of(context).disableAnimations;
  }

  /// Checks if bold text is enabled
  static bool isBoldTextEnabled(BuildContext context) {
    return MediaQuery.of(context).boldText;
  }

  /// Gets the text scale factor
  static double getTextScaleFactor(BuildContext context) {
    return MediaQuery.textScalerOf(context).scale(1.0);
  }

  /// Checks if text is scaled significantly (accessibility setting)
  static bool isLargeTextEnabled(BuildContext context) {
    return getTextScaleFactor(context) > 1.3;
  }
}

/// Extension for adding accessibility to any widget
extension AccessibilityExtension on Widget {
  /// Adds semantic button properties
  Widget withSemanticButton(String label, {String? hint, VoidCallback? onTap}) {
    return AccessibilityUtils.semanticButton(
      label: label,
      hint: hint,
      onTap: onTap,
      child: this,
    );
  }

  /// Adds semantic image properties
  Widget withSemanticImage(String label, {bool isDecorative = false}) {
    return AccessibilityUtils.semanticImage(
      label: label,
      isDecorative: isDecorative,
      child: this,
    );
  }

  /// Adds semantic header properties
  Widget withSemanticHeader(String label) {
    return AccessibilityUtils.semanticHeader(
      label: label,
      child: this,
    );
  }

  /// Excludes from semantics tree (for decorative elements)
  Widget excludeFromSemantics() {
    return ExcludeSemantics(child: this);
  }

  /// Ensures minimum touch target size
  Widget withMinTouchTarget([double size = 44.0]) {
    return AccessibilityUtils.ensureMinTouchTarget(
      minSize: size,
      child: this,
    );
  }
}

/// Semantic sort keys for controlling focus order
class AppSortKeys {
  AppSortKeys._();

  static const OrdinalSortKey header = OrdinalSortKey(0);
  static const OrdinalSortKey navigation = OrdinalSortKey(1);
  static const OrdinalSortKey mainContent = OrdinalSortKey(2);
  static const OrdinalSortKey actions = OrdinalSortKey(3);
  static const OrdinalSortKey footer = OrdinalSortKey(4);
}
