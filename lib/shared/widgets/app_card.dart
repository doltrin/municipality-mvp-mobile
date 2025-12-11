import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

/// Reusable card widget with consistent styling
/// Follows enterprise design system standards
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.borderRadius,
    this.color,
    this.borderColor,
    this.elevation,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double? borderRadius;
  final Color? color;
  final Color? borderColor;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final cardColor = color ?? theme.cardTheme.color;
    final cardBorderColor = borderColor ??
        (isDark ? const Color(0xFF3F3F46) : const Color(0xFFE4E4E7));
    final cardRadius = borderRadius ?? AppConstants.radiusLg;

    Widget card = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(cardRadius),
        border: Border.all(color: cardBorderColor, width: 1),
        boxShadow: elevation != null && elevation! > 0
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: elevation! * 2,
                  offset: Offset(0, elevation!),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cardRadius),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppConstants.spacingMd),
          child: child,
        ),
      ),
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(cardRadius),
          child: card,
        ),
      );
    }

    return card;
  }
}
