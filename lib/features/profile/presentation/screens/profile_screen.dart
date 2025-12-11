import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_card.dart';

/// Profile screen - User profile and settings
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        children: [
          // Profile Header
          _ProfileHeader(isDark: isDark),
          const SizedBox(height: AppConstants.spacingLg),

          // Stats Cards
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: 'Wallet',
                  value: '€45.50',
                  icon: LucideIcons.wallet,
                  color: AppColors.success,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: AppConstants.spacingSm),
              Expanded(
                child: _StatCard(
                  label: 'Points',
                  value: '1,250',
                  icon: LucideIcons.star,
                  color: AppColors.warning,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: AppConstants.spacingSm),
              Expanded(
                child: _StatCard(
                  label: 'Requests',
                  value: '12',
                  icon: LucideIcons.fileText,
                  color: AppColors.info,
                  isDark: isDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingLg),

          // Menu Sections
          _MenuSection(
            title: 'Account',
            items: [
              _MenuItem(
                icon: LucideIcons.user,
                label: 'Personal Information',
                onTap: () {},
              ),
              _MenuItem(
                icon: LucideIcons.creditCard,
                label: 'Payment Methods',
                onTap: () {},
              ),
              _MenuItem(
                icon: LucideIcons.bell,
                label: 'Notifications',
                onTap: () {},
                trailing: const _NotificationBadge(count: 3),
              ),
              _MenuItem(
                icon: LucideIcons.shield,
                label: 'Privacy & Security',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),

          _MenuSection(
            title: 'Preferences',
            items: [
              _MenuItem(
                icon: LucideIcons.globe,
                label: 'Language',
                onTap: () {},
                trailing: Text(
                  'English',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
              ),
              _MenuItem(
                icon: isDark ? LucideIcons.moon : LucideIcons.sun,
                label: 'Dark Mode',
                onTap: () {},
                trailing: Switch.adaptive(
                  value: isDark,
                  onChanged: (_) {},
                  activeTrackColor: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),

          _MenuSection(
            title: 'Support',
            items: [
              _MenuItem(
                icon: LucideIcons.helpCircle,
                label: 'Help Center',
                onTap: () {},
              ),
              _MenuItem(
                icon: LucideIcons.messageCircle,
                label: 'Contact Us',
                onTap: () {},
              ),
              _MenuItem(
                icon: LucideIcons.info,
                label: 'About',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingLg),

          // Logout Button
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(LucideIcons.logOut, size: 20),
            label: const Text('Sign Out'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.error,
              side: const BorderSide(color: AppColors.error),
            ),
          ),

          const SizedBox(height: AppConstants.spacingMd),
          Center(
            child: Text(
              'Version 1.0.0',
              style: theme.textTheme.bodySmall,
            ),
          ),

          const SizedBox(height: 100), // Bottom padding
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(AppConstants.radiusLg),
            ),
            child: const Center(
              child: Text(
                'MK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Μιχάλης Κρητικός',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'michalis@example.com',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.success.withValues(alpha: 0.2)
                        : AppColors.successLight,
                    borderRadius: BorderRadius.circular(AppConstants.radiusFull),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        LucideIcons.badgeCheck,
                        size: 14,
                        color: AppColors.success,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Verified Citizen',
                        style: TextStyle(
                          color: AppColors.success,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              LucideIcons.pencil,
              size: 20,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.isDark,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: isDark ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: AppConstants.spacingXs),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  const _MenuSection({
    required this.title,
    required this.items,
  });

  final String title;
  final List<_MenuItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppConstants.spacingXs,
            bottom: AppConstants.spacingXs,
          ),
          child: Text(
            title,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.brightness == Brightness.dark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
        ),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  item,
                  if (index < items.length - 1)
                    Divider(
                      height: 1,
                      indent: 56,
                      color: theme.brightness == Brightness.dark
                          ? AppColors.dividerDark
                          : AppColors.dividerLight,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingMd,
          vertical: AppConstants.spacingSm,
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.primary.withValues(alpha: 0.15)
                    : AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(AppConstants.radiusSm),
              ),
              child: Icon(
                icon,
                size: 18,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: AppConstants.spacingSm),
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
            ),
            if (trailing != null)
              trailing!
            else
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

class _NotificationBadge extends StatelessWidget {
  const _NotificationBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(AppConstants.radiusFull),
      ),
      child: Text(
        count.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
