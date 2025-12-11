import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/status_badge.dart';

/// Requests screen - View and track citizen requests
class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  String _selectedFilter = 'All';

  final List<String> _filters = ['All', 'Active', 'Completed', 'Cancelled'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Requests'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.plus),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            height: 48,
            margin: const EdgeInsets.symmetric(vertical: AppConstants.spacingSm),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingMd),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = filter == _selectedFilter;

                return Padding(
                  padding: const EdgeInsets.only(right: AppConstants.spacingXs),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selectedFilter = filter),
                    backgroundColor: isDark ? AppColors.cardDark : AppColors.surfaceLight,
                    selectedColor: isDark ? AppColors.primaryDark : AppColors.primaryContainer,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? (isDark ? AppColors.primaryLight : AppColors.primary)
                          : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                    side: BorderSide(
                      color: isSelected
                          ? (isDark ? AppColors.primaryLight : AppColors.primary)
                          : (isDark ? AppColors.borderDark : AppColors.borderLight),
                    ),
                    showCheckmark: false,
                  ),
                );
              },
            ),
          ),

          // Requests List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              children: const [
                _RequestCard(
                  id: 'REQ-2024-1234',
                  title: 'Street Light Repair',
                  description: 'Broken street light on Ermou Street near Syntagma Square',
                  status: StatusType.inProgress,
                  date: '2 days ago',
                  icon: LucideIcons.zap,
                  category: 'Infrastructure',
                ),
                _RequestCard(
                  id: 'REQ-2024-1233',
                  title: 'Pothole Report',
                  description: 'Large pothole on Stadiou Street causing traffic issues',
                  status: StatusType.pending,
                  date: '5 days ago',
                  icon: LucideIcons.alertTriangle,
                  category: 'Roads',
                ),
                _RequestCard(
                  id: 'REQ-2024-1230',
                  title: 'Garbage Collection',
                  description: 'Missed garbage collection on Monday',
                  status: StatusType.completed,
                  date: '1 week ago',
                  icon: LucideIcons.trash2,
                  category: 'Waste',
                ),
                _RequestCard(
                  id: 'REQ-2024-1228',
                  title: 'Park Maintenance',
                  description: 'Broken bench in National Garden',
                  status: StatusType.completed,
                  date: '2 weeks ago',
                  icon: LucideIcons.trees,
                  category: 'Parks',
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(LucideIcons.plus),
        label: const Text('New Request'),
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.date,
    required this.icon,
    required this.category,
  });

  final String id;
  final String title;
  final String description;
  final StatusType status;
  final String date;
  final IconData icon;
  final String category;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spacingSm),
      child: AppCard(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.primary.withValues(alpha: 0.15)
                        : AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 22),
                ),
                const SizedBox(width: AppConstants.spacingSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.accent.withValues(alpha: 0.2)
                                  : AppColors.accentContainer,
                              borderRadius: BorderRadius.circular(4),
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
                          const SizedBox(width: 8),
                          Text(
                            id,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                StatusBadge(status: status),
              ],
            ),
            const SizedBox(height: AppConstants.spacingSm),
            Text(
              description,
              style: theme.textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppConstants.spacingSm),
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
                  date,
                  style: theme.textTheme.bodySmall,
                ),
                const Spacer(),
                Icon(
                  LucideIcons.chevronRight,
                  size: 18,
                  color: isDark
                      ? AppColors.textTertiaryDark
                      : AppColors.textTertiaryLight,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
