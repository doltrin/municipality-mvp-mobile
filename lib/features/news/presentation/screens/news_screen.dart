import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_card.dart';

/// News screen - Latest news and announcements from the municipality
class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('News & Events'),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.filter),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        children: [
          // Featured News
          const _FeaturedNewsCard(
            title: 'New Metro Line Opening',
            summary: 'The new metro line connecting Piraeus to the northern suburbs will open next month.',
            imageUrl: 'https://images.unsplash.com/photo-1565043666747-69f6646db940?w=800',
            category: 'Transport',
            date: '1 hour ago',
            isUrgent: false,
          ),
          const SizedBox(height: AppConstants.spacingMd),

          // Urgent Alert
          const _AlertCard(
            title: 'Water Supply Interruption',
            message: 'Scheduled maintenance on Dec 15th, 08:00-14:00. Areas: Kolonaki, Exarchia.',
            type: AlertType.warning,
          ),
          const SizedBox(height: AppConstants.spacingLg),

          // News List
          Text(
            'Recent News',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.spacingSm),

          const _NewsListItem(
            title: 'Free Parking During Holidays',
            category: 'Parking',
            date: '3 hours ago',
            imageUrl: 'https://images.unsplash.com/photo-1506521781263-d8422e82f27a?w=400',
          ),
          const _NewsListItem(
            title: 'New Recycling Program Launch',
            category: 'Environment',
            date: '5 hours ago',
            imageUrl: 'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=400',
          ),
          const _NewsListItem(
            title: 'Cultural Festival This Weekend',
            category: 'Events',
            date: 'Yesterday',
            imageUrl: 'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=400',
          ),
          const _NewsListItem(
            title: 'Road Works on Main Avenue',
            category: 'Traffic',
            date: '2 days ago',
            imageUrl: 'https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=400',
          ),

          const SizedBox(height: 100), // Bottom padding
        ],
      ),
    );
  }
}

class _FeaturedNewsCard extends StatelessWidget {
  const _FeaturedNewsCard({
    required this.title,
    required this.summary,
    required this.imageUrl,
    required this.category,
    required this.date,
    this.isUrgent = false,
  });

  final String title;
  final String summary;
  final String imageUrl;
  final String category;
  final String date;
  final bool isUrgent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppCard(
      onTap: () {},
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppConstants.radiusLg),
              ),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppConstants.radiusLg),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
                // Category badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(AppConstants.radiusFull),
                    ),
                    child: Text(
                      category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  summary,
                  style: theme.textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      LucideIcons.clock,
                      size: 14,
                      color: isDark
                          ? AppColors.textTertiaryDark
                          : AppColors.textTertiaryLight,
                    ),
                    const SizedBox(width: 4),
                    Text(date, style: theme.textTheme.bodySmall),
                    const Spacer(),
                    Icon(
                      LucideIcons.share2,
                      size: 18,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      LucideIcons.bookmark,
                      size: 18,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum AlertType { info, warning, error }

class _AlertCard extends StatelessWidget {
  const _AlertCard({
    required this.title,
    required this.message,
    required this.type,
  });

  final String title;
  final String message;
  final AlertType type;

  @override
  Widget build(BuildContext context) {
    final (color, bgColor, icon) = switch (type) {
      AlertType.info => (AppColors.info, AppColors.infoLight, LucideIcons.info),
      AlertType.warning => (AppColors.warning, AppColors.warningLight, LucideIcons.alertTriangle),
      AlertType.error => (AppColors.error, AppColors.errorLight, LucideIcons.alertCircle),
    };

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: AppConstants.spacingSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(
                    color: color.withValues(alpha: 0.8),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NewsListItem extends StatelessWidget {
  const _NewsListItem({
    required this.title,
    required this.category,
    required this.date,
    required this.imageUrl,
  });

  final String title;
  final String category;
  final String date;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spacingSm),
      child: AppCard(
        onTap: () {},
        padding: const EdgeInsets.all(AppConstants.spacingSm),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              child: Image.network(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  color: isDark ? AppColors.cardDark : AppColors.backgroundLight,
                  child: const Icon(LucideIcons.image, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: AppConstants.spacingSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.accent.withValues(alpha: 0.2)
                          : AppColors.accentContainer,
                      borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                    ),
                    child: Text(
                      category,
                      style: const TextStyle(
                        color: AppColors.accent,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    title,
                    style: theme.textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Icon(
              LucideIcons.chevronRight,
              size: 20,
              color: isDark
                  ? AppColors.textTertiaryDark
                  : AppColors.textTertiaryLight,
            ),
          ],
        ),
      ),
    );
  }
}
