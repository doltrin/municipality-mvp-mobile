import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/service_card.dart';

/// Services screen - Browse all municipal services by category
class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Documents',
    'Payments',
    'Transport',
    'Waste',
    'Community',
  ];

  final List<_ServiceItem> _services = const [
    _ServiceItem('Birth Certificate', LucideIcons.baby, AppColors.categoryCertificates, 'Documents'),
    _ServiceItem('Marriage Certificate', LucideIcons.heart, AppColors.categoryCertificates, 'Documents'),
    _ServiceItem('ID Documents', LucideIcons.creditCard, AppColors.categoryCertificates, 'Documents'),
    _ServiceItem('Property Tax', LucideIcons.home, AppColors.categoryPayments, 'Payments'),
    _ServiceItem('Water Bill', LucideIcons.droplets, AppColors.categoryPayments, 'Payments'),
    _ServiceItem('Parking Fines', LucideIcons.car, AppColors.categoryPayments, 'Payments'),
    _ServiceItem('Bus Routes', LucideIcons.bus, AppColors.categoryTransport, 'Transport'),
    _ServiceItem('Smart Parking', LucideIcons.parkingCircle, AppColors.categoryParking, 'Transport'),
    _ServiceItem('Bike Sharing', LucideIcons.bike, AppColors.categoryTransport, 'Transport'),
    _ServiceItem('Collection Schedule', LucideIcons.calendar, AppColors.categoryWaste, 'Waste'),
    _ServiceItem('Recycling Points', LucideIcons.recycle, AppColors.categoryWaste, 'Waste'),
    _ServiceItem('Bulky Waste', LucideIcons.truck, AppColors.categoryWaste, 'Waste'),
    _ServiceItem('Report Issue', LucideIcons.alertTriangle, AppColors.categoryReports, 'Community'),
    _ServiceItem('Volunteer', LucideIcons.heart, AppColors.success, 'Community'),
    _ServiceItem('Events', LucideIcons.partyPopper, AppColors.accent, 'Community'),
  ];

  List<_ServiceItem> get _filteredServices {
    if (_selectedCategory == 'All') return _services;
    return _services.where((s) => s.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 48,
            margin: const EdgeInsets.symmetric(vertical: AppConstants.spacingSm),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingMd),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;

                return Padding(
                  padding: const EdgeInsets.only(right: AppConstants.spacingXs),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selectedCategory = category),
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

          // Services Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: AppConstants.gridSpacing,
                mainAxisSpacing: AppConstants.gridSpacing,
                childAspectRatio: 0.9,
              ),
              itemCount: _filteredServices.length,
              itemBuilder: (context, index) {
                final service = _filteredServices[index];
                return ServiceCard(
                  label: service.name,
                  icon: service.icon,
                  color: service.color,
                  onTap: () {
                    // Navigate to service detail
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceItem {
  const _ServiceItem(this.name, this.icon, this.color, this.category);
  final String name;
  final IconData icon;
  final Color color;
  final String category;
}
