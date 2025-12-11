import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';

/// Status badge widget for displaying request/task status
/// Semantic colors for different states
enum StatusType { pending, inProgress, completed, cancelled, scheduled }

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    required this.status,
    super.key,
    this.label,
  });

  final StatusType status;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final (color, bgColor, text) = _getStatusStyle();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingSm,
        vertical: AppConstants.spacingXxs,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusFull),
      ),
      child: Text(
        label ?? text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  (Color, Color, String) _getStatusStyle() {
    switch (status) {
      case StatusType.pending:
        return (AppColors.warning, AppColors.warningLight, 'Pending');
      case StatusType.inProgress:
        return (AppColors.info, AppColors.infoLight, 'In Progress');
      case StatusType.completed:
        return (AppColors.success, AppColors.successLight, 'Completed');
      case StatusType.cancelled:
        return (AppColors.error, AppColors.errorLight, 'Cancelled');
      case StatusType.scheduled:
        return (AppColors.accent, AppColors.accentContainer, 'Scheduled');
    }
  }
}
