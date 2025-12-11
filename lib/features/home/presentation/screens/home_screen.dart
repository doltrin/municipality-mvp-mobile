import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/service_card.dart';
import '../../../../shared/widgets/status_badge.dart';

/// Home screen - Main dashboard for the municipality app
/// Displays weather, quick services, active tasks, and news
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with greeting
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good Morning',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: isDark 
                                      ? AppColors.textSecondaryDark 
                                      : AppColors.textSecondaryLight,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Μιχάλης',
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              _HeaderIconButton(
                                icon: LucideIcons.search,
                                onTap: () {},
                              ),
                              const SizedBox(width: 8),
                              _HeaderIconButton(
                                icon: LucideIcons.bell,
                                onTap: () {},
                                badge: '3',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverPadding(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Weather Card
                const _WeatherCard(),
                const SizedBox(height: AppConstants.spacingLg),

                // Quick Services Section
                _SectionHeader(
                  title: 'Quick Services',
                  actionLabel: 'See All',
                  onAction: () {},
                ),
                const SizedBox(height: AppConstants.spacingSm),
                const _QuickServicesGrid(),
                const SizedBox(height: AppConstants.spacingLg),

                // Active Tasks Section
                _SectionHeader(
                  title: 'Active Tasks',
                  actionLabel: 'View All',
                  onAction: () {},
                ),
                const SizedBox(height: AppConstants.spacingSm),
                const _ActiveTasksList(),
                const SizedBox(height: AppConstants.spacingLg),

                // News Section
                _SectionHeader(
                  title: 'Latest News',
                  actionLabel: 'More',
                  onAction: () {},
                ),
                const SizedBox(height: AppConstants.spacingSm),
                const _NewsCard(),
                
                // Bottom padding for nav bar
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.onTap,
    this.badge,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Stack(
      children: [
        Material(
          color: isDark ? AppColors.cardDark : AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            child: Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 22,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              ),
            ),
          ),
        ),
        if (badge != null)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              child: Text(
                badge!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _WeatherCard extends StatelessWidget {
  const _WeatherCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        gradient: AppColors.weatherGradient,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(LucideIcons.mapPin, color: Colors.white70, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        'Athens, Greece',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '24',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 56,
                          fontWeight: FontWeight.w300,
                          height: 1,
                        ),
                      ),
                      Text(
                        '°C',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Sunny',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Icon(
                LucideIcons.sun,
                color: Colors.white,
                size: 64,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _WeatherStat(icon: LucideIcons.droplets, value: '45%', label: 'Humidity'),
                _WeatherStat(icon: LucideIcons.wind, value: '12 km/h', label: 'Wind'),
                _WeatherStat(icon: LucideIcons.thermometer, value: '26°', label: 'Feels'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WeatherStat extends StatelessWidget {
  const _WeatherStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 16),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (actionLabel != null)
          TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              actionLabel!,
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}

class _QuickServicesGrid extends StatelessWidget {
  const _QuickServicesGrid();

  @override
  Widget build(BuildContext context) {
    final services = [
      (label: 'Certificates', icon: LucideIcons.fileText, color: AppColors.categoryCertificates),
      (label: 'Report Issue', icon: LucideIcons.alertTriangle, color: AppColors.categoryReports),
      (label: 'Payments', icon: LucideIcons.creditCard, color: AppColors.categoryPayments),
      (label: 'Transport', icon: LucideIcons.bus, color: AppColors.categoryTransport),
      (label: 'Waste', icon: LucideIcons.recycle, color: AppColors.categoryWaste),
      (label: 'All Services', icon: LucideIcons.sparkles, color: AppColors.accent),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppConstants.gridSpacing,
        mainAxisSpacing: AppConstants.gridSpacing,
        childAspectRatio: 0.95,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return ServiceCard(
          label: service.label,
          icon: service.icon,
          color: service.color,
          onTap: () {},
        );
      },
    );
  }
}

class _ActiveTasksList extends StatelessWidget {
  const _ActiveTasksList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final tasks = [
      (
        title: 'Street Light Repair',
        status: StatusType.inProgress,
        date: '2 days ago',
        icon: LucideIcons.zap,
      ),
      (
        title: 'Certificate Pickup',
        status: StatusType.scheduled,
        date: 'Tomorrow, 10:00',
        icon: LucideIcons.calendar,
      ),
    ];

    return Column(
      children: tasks.map((task) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.spacingSm),
          child: AppCard(
            onTap: () {},
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isDark 
                        ? AppColors.primary.withValues(alpha: 0.2)
                        : AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                  ),
                  child: Icon(
                    task.icon,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppConstants.spacingSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        task.date,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                StatusBadge(status: task.status),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _NewsCard extends StatelessWidget {
  const _NewsCard();

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
            height: 140,
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : AppColors.backgroundLight,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppConstants.radiusLg),
              ),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1555993539-1732b0258235?w=800',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(AppConstants.radiusFull),
                    ),
                    child: const Text(
                      'URGENT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
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
                  'Water Supply Maintenance',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Scheduled maintenance on Dec 15th. Areas affected: Kolonaki, Exarchia.',
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
                    Text(
                      '2 hours ago',
                      style: theme.textTheme.bodySmall,
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
